#import "../variables.typ": *
#import "../box.typ": *

== Forward Euler Method <section_forward_euler>

Let's consider a mass matrix ODE (@eq_mass_matrix_ode) of the form $odemassmatrix(t,y) thick y'=f(t,y)$ with $y(t_0) = y_0$.

The *Forward Euler method* approximates the integral in @eq_integrated_ode and @eq_integrated_mass_ode by the rectangle rule evaluated at the start of the interval:

$
  integral_(t_n)^(t_(n+1)) f(t,y) dif t approx stepsize thick f(t_n, y_n)
$

#figure(
  image("../img/integral_forward_euler.svg", width: 30%),
  caption: [
    Example of the approximation of the integral of a function using the rectangle rule.
  ],
)

Substituting this approximation into @eq_integrated_mass_ode yields:

#result(title: "Forward Euler Method")[
$
  odemassmatrix thick [y_(n+1)-y_n] = stepsize thick f(t_n, y_n)
$ <eq_generic_explicit_euler>

This is the *Explicit Euler method*. It provides a direct, computationally simple way to advance the solution from $y_n$ to $y_(n+1)$.
]

#property(title:"Comparison with Backward Euler method")[
  The Backward Euler method is introduced in @section_backward_euler.

  #table(
    columns:(50%, 49%),
    align: center,
    stroke: none,
    table.header(
      [*Forward Euler*], [*Backward Euler*]
    ),
    math.equation(block: true, numbering: none, $ integral_(t_text(fill: green,n))^(t_text(fill: red,n+1)) f(t,y) dif t approx stepsize thick f(t_text(fill: green,n), y_text(fill: green,n)) $),
    math.equation(block: true, numbering: none, $ integral_(t_text(fill: green,n))^(t_text(fill: red,n+1)) f(t,y) dif t approx stepsize thick f(t_text(fill: red,n+1), y_text(fill: red,n+1)) $),
    image("../img/integral_forward_euler.svg", width: 20%),
    image("../img/integral_backward_euler.svg", width: 20%),
    math.equation(block: true, numbering: none, $ odemassmatrix thick [y_text(fill: red,n+1)-y_text(fill: green,n)] = stepsize thick f(t_text(fill: green,n), y_text(fill: green,n)) $),
    math.equation(block: true, numbering: none, $ odemassmatrix thick [y_text(fill: red,n+1)-y_text(fill: green,n)] = stepsize thick f(t_text(fill: red,n+1), y_text(fill: red,n+1)) $),
    
  )
]

#property(title:"Solving")[
  @eq_generic_explicit_euler is a linear system to solve. A linear solver is required to solve this system (see @section_linear_solvers). 
  
  If $odemassmatrix$ is invertible, the system can be written as:

  $
    y_(n+1) = y_n + odemassmatrix^(-1) stepsize thick f(t_n, y_n)
  $

  If $odemassmatrix$ is diagonal, $odemassmatrix^(-1)$ is trivial. In that case, the linear solver can be bypassed.
]

=== Mechanics

In Newton's second law of motion (@definition_y, @definition_f, @definition_M):
$
  y(t) = mat( position(t); velocity(t))
  , wide
  f(t,y) = mat(
    velocity(t);
    force(position(t), velocity(t))
  )
  , wide
  odemassmatrix = mat(
    identity,0;
    0, massmatrix
  )
$

Substituting in @eq_generic_explicit_euler:

#result[
$
  &
  mat(
    identity,0;
    0, massmatrix
  )
  thick
  mat(
    position_(n+1) - position_n;
    velocity_(n+1) - velocity_n
  )
  = stepsize thick mat(velocity_n; force_n) \
  <=>&
  mat(delim: #("{", none),
    position_(n+1) &= position_n + stepsize thick velocity_n;
    velocity_(n+1) &= velocity_n + stepsize thick massmatrix^(-1) force_n
  )
$ <forward_euler>

This is the time-discrete version of the Newton's second law of motion when the forward Euler method is applied.
]

=== Heat Equation

The @section_heat_equation_as_ODE, introduces the definition of $y$ and $f$ for mechanics problems. Substituting $y$ and $f$ in @eq_generic_explicit_euler:

#result[
$
u_(n+1) = diffusivity thick stepsize thick laplace u_n + u_n
$

This is the time-discrete version of the heat equation when the forward Euler method is applied.
]