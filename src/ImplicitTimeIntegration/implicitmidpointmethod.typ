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

Let's consider a mass matrix ODE (@eq_mass_matrix_ode) of the form $odemassmatrix(t,y) thick y'=f(t,y)$ with $y(t_0) = y_0$.

The implicit midpoint method approximates the integral in @eq_integrated_ode and @eq_integrated_mass_ode by the rectangle rule evaluated at the midpoint of a time step:

$
  integral_(t_n)^(t_(n+1)) f(t,y) dif t approx stepsize thick f(t_(n+1/2), y_(n+1/2))
$

Substituting this approximation into @eq_integrated_mass_ode yields:

$
  odemassmatrix(t_(n+1),y_(n+1)) thick [y_(n+1)-y_n] = stepsize thick f(t_(n+1/2), y_(n+1/2))
$

$y_(n+1/2)$ is still unknown. We approximate it as the midpoint of the segment from $y_n$ to $y_(n+1)$:

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
r_(n+1)(z) := odemassmatrix thick [z-y_n] - stepsize thick f(t_(n+1/2), (z+y_n)/2)
$

With this definition, $y_(n+1)$ is the solution of $r_(n+1)(z)=0$.
]

The application of the Newton-Raphson algorithm requires the computation of the Jacobian of the residual function (@linear_system_in_newton_raphson):

$
  (partial r_(n+1))/(partial z) = 
  odemassmatrix - stepsize/2 thick lr((partial f)/(partial z)|)_(t_(n+1/2),(z+y_n)/2)
$

Substituting this Jacobian into @linear_system_in_newton_raphson, we obtain:

$
  (odemassmatrix - stepsize/2 lr((partial f)/(partial z)|)_(t_(n+1/2),(z+y_n)/2)) (z^(i+1)-z^i) = -r_(n+1)(z^i)
$ <eq_implicit_midpoint_newton_raphson>

#property(title: "Newton's Second Law of Motion ")[
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

  In @eq_implicit_midpoint_newton_raphson, we need the derivative of $f$:

  $
    (partial f(t_(n+1), y))/(partial y) =
    mat(
      (partial velocity)/(partial position), (partial velocity)/(partial velocity);
      (partial force)/(partial position), (partial force)/(partial velocity)
    ) =
    mat(
      0, identity;
      (partial force)/(partial position), (partial force)/(partial velocity)
    ) =
    mat(
      0, identity;
      stiffness, damping
    )
  $

  We also express the residual for the law of motion:
  $
    r_(n+1)(state^i) &= mat(
      identity,0;
      0, massmatrix
    ) mat(position^(i) - position_n; velocity^(i) - velocity_n)
    - stepsize mat(
      (velocity^i + velocity_n)/2;
      force((state^i + state_n)/2)
    ) \
    &=
    mat(
      position^(i) - position_n - stepsize thick (velocity^i + velocity_n)/2;
      massmatrix (velocity^(i) - velocity_n) - stepsize thick force((state^i + state_n)/2)
    )

  $

  Substituting the derivative of $f$ in @eq_implicit_midpoint_newton_raphson:

  $
    &
    (mat(
      identity,0;
      0, massmatrix
    ) - 
    stepsize/2 mat(
      0, identity;
      stiffness((state^i + state_n)/2), damping((state^i + state_n)/2)
    )
    ) 
    mat(position^(i+1) - position^i; velocity^(i+1) - velocity^i) = -r_(n+1)(state^i)
    \
    <=> &
    mat(
      identity, - stepsize/2 identity;
      - stepsize/2 thick stiffness((state^i + state_n)/2), massmatrix - stepsize/2 thick damping((state^i + state_n)/2)
    )
    mat(position^(i+1) - position^i; velocity^(i+1) - velocity^i) = -r_(n+1)(state^i)
  $ <eq_implicit_midpoint_newton_raphson_motion>
]

=== Solve for $velocity$

Using the Schur complement (see @schur_complement_linear_system_y) in @eq_implicit_midpoint_newton_raphson_motion, we obtain the reduced equation in $velocity ^(i+1) - velocity ^i$:

#result()[
$
  (massmatrix - stepsize/2 damping((state^i + state_n)/2) - stepsize^2/4 stiffness((state^i + state_n)/2))
  (velocity^(i+1) - velocity^i) = \

  -massmatrix (velocity^i - velocity_n) 
  + stepsize thick force((state^i + state_n)/2)
  - stepsize/2 stiffness((state^i + state_n)/2) (position^i - position_n - stepsize velocity_(n+1/2)) 
$
]

From @block_elimination_x, we can deduce $position^(i+1) - position^i$:

$
  position^(i+1) - position^i 
  &= -(position^(i) - position_n - stepsize thick (velocity^i + velocity_n)/2) + stepsize/2 (velocity^(i+1) - velocity^i) \
  &= position_n - position^i + stepsize/2 (velocity^i + velocity_n + velocity^(i+1) - velocity^i )\
  &= position_n - position^i + stepsize/2 (velocity_n + velocity^(i+1))
$

Then

#result()[
$
position^(i+1) = position_n + stepsize thick (velocity^(i+1) + velocity_n)/2 
$
]