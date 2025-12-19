#import "../variables.typ": *
#import "../box.typ": *

== Forward Euler Method

Considering an IVP (@initial_value_problem) of the form $y'=f(t,y)$ with $y(t_0) = y_0$, the time derivative can be approximated using a forward first-order finite difference:

$
y'(t) approx 1/stepsize (y(t+stepsize)-y(t))
$

Substituting this approximation into the IVP yields:

$
  cases(
    1/stepsize (y(t+stepsize)-y(t)) &=f(t,y),
    y(t_0) = y_0
  )
$

Under the discrete sequence notation from @sequence, we write:

$
  1/stepsize (y_(n+1)-y_n)=f(t,y_n)
$
where $y_0$ is known.

Rearranging for $y_(n+1)$:

#result(title: "Forward Euler Method")[
$
  y_(n+1) = stepsize thick f(t,y_n) + y_n
$ <eq_generic_explicit_euler>

This is the *Explicit Euler method*. It provides a direct, computationally simple way to advance the solution from $y_n$ to $y_(n+1)$.
]

=== Mechanics

The @section_newton_second_law_as_ODE, introduces the definition of $y$ and $f$ for mechanics problems. Substituting $y$ and $f$ in @eq_generic_explicit_euler:

#result[
$
mat(
position_(n+1);
velocity_(n+1)
)
=
mat(
position_n + stepsize thick velocity_n;
velocity_n + stepsize thick massmatrix(position_n)^(-1) (force(position_n,velocity_n) - coriolismatrix(position_n, velocity_n) velocity_n)
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