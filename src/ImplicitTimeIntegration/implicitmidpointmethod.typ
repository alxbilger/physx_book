#import "../variables.typ": *
#import "../box.typ": *

== Implicit Midpoint Method

Extending the notation from @eq_time_sequence, we write the midpoint of two consecutive time steps $t_n$ and $t_(n+1)$:
$
t_(n+1/2) = (t_n + t_(n+1))/2 = t_0 + (n+1/2) thick stepsize = t_n + stepsize /2 , wide n = 0, 1, 2, dots
$

If $y$ is expressed at the midpoint of two consecutive time steps $t_n$ and $t_(n+1)$, it is denoted $y_(n+1/2)$:

$
  y_(n+1/2) = y(t_(n+1/2))
$

The mass matri ODE @eq_mass_matrix_ode expresed at the midpoint $t_n + stepsize / 2$ becomes:

$
  odemassmatrix thick y'_(n+1/2) = f(t_(n+1/2), y_(n+1/2))
$

The time derivative can be approximated such as:

$
  y'_(n+1/2) approx (y_(n+1) - y_n) / stepsize
$

Substituting in the initial value problem:

$
  odemassmatrix thick (y_(n+1) - y_n) / stepsize = f(t_(n+1/2), y_(n+1/2))
$

$y_(n+1/2)$ is still unknown. We approximate it as:

$
  y_(n+1/2) approx (y_(n+1) + y_n)/2
$

Then,

$
  odemassmatrix thick (y_(n+1) - y_n) = stepsize thick f(t_(n+1/2), (y_(n+1) + y_n)/2)
$ <eq_ode_midpoint>

#property(title: "Newton's Second Law of Motion ")[

We apply this equation on $y$ from @definition_y and $f$ from @definition_f:

$
  odemassmatrix thick (mat(position_(n+1); velocity_(n+1)) - mat(position_n; velocity_n)) = stepsize thick mat(velocity_(n+1/2); force((position_(n+1) + position_n)/2, velocity_(n+1/2)))
$

$velocity_(n+1/2)$ is also approximated:

$
  velocity_(n+1/2) = (velocity_(n+1) + velocity_n) / 2
$

Then,

$
  odemassmatrix thick mat(position_(n+1) - position_n; velocity_(n+1) - velocity_n) = stepsize thick mat((velocity_(n+1) + velocity_n) / 2; force((position_(n+1) + position_n)/2, (velocity_(n+1) + velocity_n) / 2))
$
]

@eq_ode_midpoint is a set of non-linear equations that can be solved with the Newton-Raphson algorithm (@section_newton_raphson).

#mybox(title: "Residual Function")[
Let's define the residual function $r$ such that:

$
r_(n+1)(z) := 1/stepsize odemassmatrix thick [z-y_n] - f(t_(n+1/2), (z+y_n)/2)
$

With this definition, $y_(n+1)$ is the solution of $r_(n+1)(z)=0$.
]

The application of the Newton-Raphson algorithm requires the computation of the Jacobian of the residual function (@linear_system_in_newton_raphson):

$
  (partial r_(n+1))/(partial z) = 
  1/stepsize odemassmatrix - 1/2 lr((partial f)/(partial z)|)_(t_(n+1/2),(z+y_n)/2)
$

Substituting this Jacobian into @linear_system_in_newton_raphson, we obtain:

$
  (1/stepsize odemassmatrix - 1/2 lr((partial f)/(partial z)|)_(t_(n+1/2),(z+y_n)/2)) (z^(i+1)-z^i) = -r_(n+1)(z^i)
$

#property(title: "Newton's Second Law of Motion ")[
]