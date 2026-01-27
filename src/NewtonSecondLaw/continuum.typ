#import "../variables.typ": *
#import "../box.typ":*

== Continuum

Let's define the Lagrangian density (@eq_lagrangian_density) for an elastodynamic problem:

$
  lagrangiandensity &= 
  kineticenergy - potentialenergy \
  &= 1/2 thick density(position) ||velocity(t)||^2 - strainenergydensity + density bold(b) dot velocity(t)
$

The strain energy density function $strainenergydensity$ is introduced in details in @section_continuum_mechanics.

Recall the action is defined as $S = integral_(t_1)^(t_2) integral_Omega lagrangiandensity thick dif V dif t$ (@eq_action_field) and $delta S = 0$.

$
  delta S = delta (integral_(t_1)^(t_2) integral_Omega lagrangiandensity thick dif V dif t) = integral_(t_1)^(t_2) integral_Omega delta lagrangiandensity thick dif V dif t
$

It requires to compute $delta lagrangiandensity$ and integrate it.

$
  delta lagrangiandensity 
  &= delta (1/2 thick density(position) ||velocity(t)||^2 - strainenergydensity + density bold(b) dot velocity(t)) \
  &= delta(1/2 thick density(position) ||velocity(t)||^2) - delta strainenergydensity + delta(density bold(b) dot velocity(t))
$

The kinematic energy term:

$
delta(1/2 thick density(position) ||velocity(t)||^2) = density(position) velocity dot delta velocity
$

Integrate by parts in time:

$
  integral_(t_0)^(t_1) density(position) velocity dot delta velocity dif t = -integral_(t_0)^(t_1) density(position) acceleration dot delta velocity dif t
$

The stored energy term:

$
  delta strainenergydensity = (partial strainenergydensity)/(partial deformationgradient) : delta deformationgradient
$

#todo()[
  The rest of the derivation.
]

#result()[
  $
    density_0 acceleration = "Div" pk1 + density_0 bold(b)
  $

  This is Newton's second law for a continuum. It can also be called balance of linear momentum.
]

#result()[
  In @section_continuum_mechanics and @section_finite_element_method, we will see that the blance of linear momentum after space discretization using the finite element method leads to the following equation:

  $
    massmatrix dot.double(displacement)(t) = force_"int" + force_"ext"
  $

  This is very similar to the set of ODEs for a particles system (@second_newton_law). FEM turns a continuum into a finite-dimensional Lagrangian mechanical system. The resulting equations are indistinguishable in structure from particle dynamics.

  The difference is on the unknown function ($position$ for the particles system, $displacement$ for the continuum). However, the Lagrangian framework is applied on generalized coordinates. Generalized coordinates are used in both cases. This allows coupling of particles and continuum under the same framework.
]