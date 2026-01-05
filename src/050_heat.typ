#import "box.typ":*
#import "variables.typ": *

= Heat Equation

== Definition

#definition(title: "Heat Equation")[

  The heat equation describes how heat (temperature) spreads through a material over time. It's the mathematical model for diffusion—how anything (heat, ideas, pollutants) spreads from areas of high concentration to low concentration.

  The heat equation in its simplest form is:
$
(partial u)/(partial t) = diffusivity laplace u
$ <heat_equation>

with $diffusivity$ a positive coefficient called thermal diffusivity, and $laplace$ is the Laplace operator. $u(position, t)$ can represent the temperature at position $position$ and time $t$.
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

== Coupling with the equation of motion

#definition(title: "Thermomechanics")[
  Thermomechanics is the branch of physics that studies how heat (energy) and mechanical motion interact in materials.

  It describes how temperature changes cause motion, and how motion changes heat distribution — all in one system.
]