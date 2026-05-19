#import "../variables.typ": *
#import "../box.typ": *

== Forward Euler Method <section_forward_euler>

Let's consider an ODE (@sec_ode) and its residual function $residualode(t,y,y')$.

The *Forward Euler method* approximates the integral in @eq_integral_residual by the rectangle rule evaluated at the start of the interval (@eq_numerical_integration_rectangle_start):

$
  integral_(t_n)^(t_(n+1)) residualode(t,y,y') dif t approx stepsize thick residualode(t_n, y_n, y'_n)
$

#figure(
  image("../img/integral_forward_euler.svg", width: 30%),
  caption: [
    Example of the approximation of the integral of a function using the rectangle rule.
  ],
)

Substituting this approximation into @eq_integral_residual yields:

$
  stepsize thick residualode(t_n, y_n, y'_n) thick = 0
$

or, simply

$
  residualode(t_n, y_n, y'_n) thick = 0
$

For a mass matrix ODE (@eq_mass_matrix_ode), the residual is $residualode(t,y,y') = odemassmatrix(t,y) thick y' - f(t,y)$ (@eq_residual_mass_matrix_ode).

Therefore:

$
  odemassmatrix(t_n,y_n) thick y'_n - f(t_n,y_n) = 0
$

First-order approximation of $y'_n$:
$
  y'_n approx (y_(n+1)-y_n)/stepsize
$ <eq_forward_euler_approx_diff>

By substitution:

#result(title: "Forward Euler Method")[
$
  odemassmatrix(t_n,y_n) thick [y_(n+1)-y_n] = stepsize thick f(t_n, y_n)
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
    math.equation(block: true, numbering: none, $ integral_(t_text(fill: green,n))^(t_text(fill: red,n+1)) residualode(t,y) dif t approx stepsize thick residualode(t_text(fill: green,n), y_text(fill: green,n)) $),
    math.equation(block: true, numbering: none, $ integral_(t_text(fill: green,n))^(t_text(fill: red,n+1)) residualode(t,y) dif t approx stepsize thick residualode(t_text(fill: red,n+1), y_text(fill: red,n+1)) $),
    image("../img/integral_forward_euler.svg", width: 20%),
    image("../img/integral_backward_euler.svg", width: 20%),
    math.equation(block: true, numbering: none, $ odemassmatrix(t_text(fill: green,n),y_text(fill: green,n)) thick [y_text(fill: red,n+1)-y_text(fill: green,n)] = stepsize thick f(t_text(fill: green,n), y_text(fill: green,n)) $),
    math.equation(block: true, numbering: none, $ odemassmatrix(t_text(fill: red,n+1),y_text(fill: red,n+1)) thick [y_text(fill: red,n+1)-y_text(fill: green,n)] = stepsize thick f(t_text(fill: red,n+1), y_text(fill: red,n+1)) $),
    
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

#mybox(title:"Mass matrix property")[
  In @eq_forward_euler_approx_diff, we introduced an approximation. In some cases, this approximation is not ncessary:

  1) In @eq_integral_residual_mass_matrix_ode_invertible, we have:

  $
    y_(n+1) - y_n - integral_(t_n)^(t_(n+1)) odemassmatrix(t,y)^(-1) f(t,y) thick dif t = 0
  $

  The rectangle rule is used on $integral_(t_n)^(t_(n+1)) odemassmatrix(t,y)^(-1) f(t,y) thick dif t$:

  $
    y_(n+1) - y_n - integral_(t_n)^(t_(n+1)) odemassmatrix(t,y)^(-1) f(t,y) thick dif t = y_(n+1) - y_n - stepsize thick odemassmatrix(t_n, y_n)^(-1) f(t_n, y_n)
  $

  which is equivalent to @eq_generic_explicit_euler.

  2) In @eq_integrated_mass_ode, we have:
  $
    odemassmatrix [y_(n+1) - y_n] - integral_(t_n)^(t_(n+1)) f(t,y) thick dif t = 0
  $

  The rectangle rule is used on $integral_(t_n)^(t_(n+1)) f(t,y) thick dif t$:

  $
    odemassmatrix [y_(n+1) - y_n] - f(t_n,y_n) = 0
  $

  which is equivalent to @eq_generic_explicit_euler.
]

=== Mechanics

In Newton's second law of motion (@definition_y, @definition_f, @definition_M):
$
  y(t) = mat( position(t); velocity(t))
  , wide
  f(t,y) = mat(
    velocity(t);
    force(position, velocity) - coriolismatrix(position, velocity) velocity
  )
  , wide
  odemassmatrix = mat(
    identity,0;
    0, massmatrix(position)
  )
$

Substituting in @eq_generic_explicit_euler:

#result[
$
  &
  mat(
    identity,0;
    0, massmatrix(position)
  )
  thick
  mat(
    position_(n+1) - position_n;
    velocity_(n+1) - velocity_n
  )
  = stepsize thick mat(velocity_n; force(position_n, velocity_n) - coriolismatrix(position_n, velocity_n) velocity_n) \
  <=>&
  mat(delim: #("{", none),
    position_(n+1) &= position_n + stepsize thick velocity_n;
    velocity_(n+1) &= velocity_n + stepsize thick massmatrix(position)^(-1) (force(position_n, velocity_n) - coriolismatrix(position_n, velocity_n) velocity_n)
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