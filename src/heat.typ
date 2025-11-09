#import "box.typ":*
#import "variables.typ": *

= Heat Equation

#definition(title: "Heat Equation")[
$
(partial u)/(partial t) = diffusivity laplace u
$ <heat_equation>

with $diffusivity$ a positive coefficient called thermal diffusivity, and $laplace$ is the Laplace operator.
]

For a cartesian coordinate system:

$
(partial u)/(partial t) = diffusivity ( (partial^2 u)/(partial x_1^2) + ... + (partial^2 u)/(partial x_2^2) )
$

#definition(title:"Steady-state Equation")[
No variation with respect to time: $(partial u)/(partial t) = 0$. The heat equation is then:

$
  laplace u = 0
$
]