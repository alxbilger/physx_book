#import "variables.typ": *
#import "box.typ": *

= Numerical Integration

#definition(title:"Numerical Integration")[
  Numerical integration consists in calculating the numerical value of a definite integral. A synonym is *numerical quadrature*.

  Given a function $f$, numerical integration computes an approximate solution of

  $
    integral_a^b f(x) dif x
  $
]

#mybox(title:"Rectangle rule evaluated at " + $a$)[
  #grid(
    columns:(30%, auto),
    align: (left, horizon),
    image("img/integral_forward_euler.svg", width: 100%),
    [
      $
        integral_a^b f(x) dif x approx (b-a) thick f(a)
      $ <eq_numerical_integration_rectangle_start>
    ]
  )
]

#mybox(title:"Rectangle rule evaluated at " + $b$)[
  #grid(
    columns:(30%, auto),
    align: (left, horizon),
    image("img/integral_backward_euler.svg", width: 100%),
    [
      $
        integral_a^b f(x) dif x approx (b-a) thick f(b)
      $ <eq_numerical_integration_rectangle_end>
    ]
  )
]

#mybox(title:"Rectangle rule evaluated at " + $(a+b)/2$)[
  #grid(
    columns:(30%, auto),
    align: (left, horizon),
    image("img/integral_midpoint.svg", width: 100%),
    [
      $
        integral_a^b f(x) dif x approx (b-a) thick f((a+b)/2)
      $ <eq_numerical_integration_rectangle_midpoint>
    ]
  )
]

#mybox(title:"Trapezoidal rule")[
  #grid(
    columns:(30%, auto),
    align: (left, horizon),
    image("img/integral_trapezoid.svg", width: 100%),
    [
      $
        integral_a^b f(x) dif x approx (b-a) thick (f(a) + f(b))/2
      $ <eq_numerical_integration_trapezoid>
    ]
  )

  It is exact if $f$ is a polynomial up to and including degree 1.
]

#mybox(title:"Simpson's 1/3 rule")[
  #grid(
    columns:(30%, auto),
    align: (left, horizon),
    image("img/integral_simpson.svg", width: 100%),
    [
      $
        integral_a^b f(x) dif x approx (b-a)/6 thick (f(a) + 4 f ((a+b)/2) + f(b))
      $ <eq_numerical_integration_simpson>
    ]
  )

  It is exact if $f$ is a polynomial up to and including degree 3.
]

#mybox(title:"Normalization of the interval")[
It is convenient to transform the interval $[a,b]$ to $[-1,1]$.
  
  Let 
  $
    x = (b-a)/2 t + (a+b)/2
  $

  $x=a$ for $t$ satisfying $a = (b-a)/2 t + (a+b)/2$, i.e. $t = (a - (a+b)/2) 2/(b-a) = -1$.

  $x=b$ for $t$ satisfying $b = (b-a)/2 t + (a+b)/2$, i.e. $t = (b - (a+b)/2) 2/(b-a) = 1$.

  Then
  $
    dif x = (b-a)/2 dif t
  $
  and the integral becomes
  $
    integral_a^b f(x) dif x = (b-a)/2 integral_(-1)^1 f((b-a)/2 t + (a+b)/2) dif t
  $

  Let's introduce $g(t) = f((b-a)/2 t + (a+b)/2)$.

  $
  integral_a^b f(x) dif x = (b-a)/2 integral_(-1)^1 g(t) dif t
  $
]

#mybox(title:"Gauss-Legendre quadrature rule")[
  $
    integral_(-1)^1 g(t) dif t approx sum_(i=0)^(n-1) omega_i g(t_i) dif t
  $

  where:
  - $t_i$ are the roots of $P_n(t)$, the Legendre polynomial.
  - $omega_i = 2 / (1-t_i^2)[P'_n(t_i)]^2$
]