#import "../variables.typ": *
#import "../box.typ": *

== Trapezoidal Rule Method

Let's consider a mass matrix ODE (@eq_mass_matrix_ode) of the form $odemassmatrix(t,y) thick y'=f(t,y)$ with $y(t_0) = y_0$.

The *Trapezoidal Rule* method approximates the integral in @eq_integrated_ode and @eq_integrated_mass_ode by the trapezoidal rule:

$
  integral_(t_n)^(t_(n+1)) f(t,y) dif t approx 1/2 stepsize thick(f(t_n, y_n) + f(t_(n+1), y_(n+1)))
$