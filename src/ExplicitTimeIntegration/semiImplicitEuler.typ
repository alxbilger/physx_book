#import "../variables.typ": *
#import "../box.typ": *

== Semi-implicit Euler method

Let's consider a mass matrix ODE (@eq_mass_matrix_ode) of the form $odemassmatrix thick mat(x';v')=mat(f(t,v); g(t,x))$ with $x(t_0) = x_0$ and $v(t_0) = v_0$.

The *Semi-implicit Euler method* approximates the integral in @eq_integrated_ode and @eq_integrated_mass_ode differently for $f$ and $g$:

- It approximates $f$ the integral using the rectangle rule evaluated at the end of the interval $[t_n, t_(n+1)]$:
$
  integral_(t_n)^(t_(n+1)) f(t,v) dif t approx stepsize thick f(t_(n+1), v_(n+1))
$

- It approximates $g$ the integral using the rectangle rule evaluated at the start of the interval $[t_n, t_(n+1)]$:
$
  integral_(t_n)^(t_(n+1)) g(t,x) dif t approx stepsize thick g(t_n, x_n)
$

Substituting this approximation into @eq_integrated_mass_ode yields:

$
  odemassmatrix mat(
    x_(n+1) - x_n; 
    v_(n+1) - v_n
  ) =
  stepsize thick mat(
    f(t_(n+1), v_(n+1));
    g(t_n, x_n)
  )
$ <eq_generic_semi_implicit_euler>

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

It corresponds to the form that we study. Substituting in @eq_generic_semi_implicit_euler:

$
  &
  mat(
    identity,0;
    0, massmatrix
  )
  mat(
    position_(n+1) - position_n; 
    velocity_(n+1) - velocity_n
  ) =
  stepsize thick mat(
    velocity_(n+1);
    force_n
  )\
  <=>&
  mat(delim: #("{", none),
    position_(n+1) &= position_n + stepsize thick velocity_(n+1);
    velocity_(n+1) &= velocity_n + stepsize thick massmatrix^(-1) force_n
  )
$

#warning()[
  Computing $position_(n+1)$ requires $velocity_(n+1)$. Therefore, $velocity_(n+1)$ will need to be computed before $position_(n+1)$.
]

#property(title:"Two variants")[
  A second variant consists in inversing how the integral are approximated. It leads to:

  $
    mat(delim: #("{", none),
      position_(n+1) &= position_n + stepsize thick velocity_(n);
      velocity_(n+1) &= velocity_n + stepsize thick massmatrix^(-1) force_(n+1)
    )
  $
]