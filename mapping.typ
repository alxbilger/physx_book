#import "variables.typ": *
#import "box.typ": *

= Mapping

#definition(title: "Mapping")[
A mapping is defined as a differentiable coordinate transformation function $mapping$ that satisfies the following condition:

$
  position_"out" = mapping(position_"in")
$ <mapping_function>

where $position_"in"$ and $position_"out"$ are respectively the input coordinates and the output coordinates of the mapping.
]

== Velocity

The velocity in the transformed coordinate system is derived from the mapping function @mapping_function:

$
  velocity_"out" = (d position_"out")/(d t) = (d mapping(position_"in"))/(d t) 
$

Using the chain rule:

$
  velocity_"out" = (d mapping(position_"in")) / (d position_"in") (d position_"in") / (d t) = (d mapping(position_"in")) / (d position_"in") velocity_"in"
$

#definition(title: "Mapping Jacobian Matrix")[
The Jacobian matrix $jacobianmapping$ of the mapping is defined as:

$
  jacobianmapping(position) = bold(partial) mapping(position) = (partial mapping(position)) / (partial position)
$
]

Such that:

$
  velocity_"out" = jacobianmapping(position_"in") velocity_"in"
$ <mapping_velocity>

== Force

The power delivered by a force is invariant under coordinate transformations. For a force $force_"in"$ acting at $position_"in"$, we have:

$
  velocity_"in"^T force_"in" (position_"in") = velocity_"out"^T force_"out" (position_"out")
$

Substituting $velocity_"out"$ from @mapping_velocity,

$
  velocity_"in"^T force_"in" (position_"in") = (jacobianmapping(position_"in") velocity_"in")^T force_"out" (position_"out") = velocity_"in"^T jacobianmapping(position_"in")^T force_"out" (position_"out")
$

By the principle of virtual work, this implies:

$
  force_"in" (position_"in") = jacobianmapping(position_"in")^T force_"out" (position_"out")
$ <mapping_force>

== Derivatives

If we are interested in the derivatives, such as the stiffness matrix:

$
  stiffness_"in" (position_"in") = (partial force_"in" (position_"in"))/(partial position_"in") 
  &= (partial jacobianmapping(position_"in")^T)/(partial position_"in") force_"out" (position_"out") + jacobianmapping(position_"in")^T  (partial force_"out" (position_"out"))/(partial position_"in") \
  &= (partial jacobianmapping(position_"in")^T)/(partial position_"in") force_"out" (position_"out") + jacobianmapping(position_"in")^T  (partial force_"out" (position_"out"))/(partial position_"out") (partial position_"out")/(partial position_"in") \
  &= (partial jacobianmapping(position_"in")^T)/(partial position_"in") force_"out" (position_"out") + jacobianmapping(position_"in")^T  stiffness_"out" (position_"out") (partial mapping(position_"in"))/(partial position_"in") \
  &= (partial jacobianmapping(position_"in")^T)/(partial position_"in") force_"out" (position_"out") + jacobianmapping(position_"in")^T  stiffness_"out" (position_"out") jacobianmapping(position_"in")
$

The term $(partial jacobianmapping(position_"in")^T)/(partial position_"in")$ is called the geometric stiffness of the mapping.

The term $jacobianmapping(position_"in")^T  stiffness_"out" (position_"out") jacobianmapping(position_"in")$ is a projection of the matrix $stiffness_"out"$ from the space "out" to the space "in".


== Mass

The kinetic energy:
$
  kineticenergy_"out" = 1/2 velocity_"out"^T massmatrix_"out" (position_"out") velocity_"out"
$

From @mapping_velocity:

$
  kineticenergy_"out" &= 1/2 (jacobianmapping(position_"in") velocity_"in")^T massmatrix_"out" (position_"out") (jacobianmapping(position_"in") velocity_"in") \
  &= 1/2 velocity_"in"^T jacobianmapping(position_"in")^T massmatrix_"out" (position_"out")  jacobianmapping(position_"in") velocity_"in"
$

We also have

$
  kineticenergy_"in" = 1/2 velocity_"in"^T massmatrix_"in" (position_"in")  velocity_"in"
$

The kinetic energy is invariant under coordinate transformation: $kineticenergy_"in"=kineticenergy_"out"$. By identification, we can deduce that

$
  massmatrix_"in" (position_"in") = jacobianmapping(position_"in")^T massmatrix_"out" (position_"out") jacobianmapping(position_"in")
$ <mapping_mass>

== Momentum

From @momentum,

$
  momentum_"in" = (partial kineticenergy_"in")/(partial velocity_"in") 
  &= partial/(partial velocity_"in") (1/2 velocity_"in"^T massmatrix_"in" (position_"in") velocity_"in")\
  &= massmatrix_"in" (position_"in") velocity_"in"\
  &= jacobianmapping(position_"in")^T massmatrix_"out" (position_"out") jacobianmapping(position_"in") velocity_"in"\
$

From @mapping_velocity:

$
  momentum_"in" &= jacobianmapping(position_"in")^T massmatrix_"out" (position_"out") velocity_"out"
$

We also have:

$
  momentum_"out" = (partial kineticenergy_"out")/(partial velocity_"out")
  &= partial/(partial velocity_"out") (1/2 velocity_"out"^T massmatrix_"out" (position_"out") velocity_"out")\
  &= massmatrix_"out" (position_"out") velocity_"out"
$

We can deduce that:

$
  momentum_"in" = jacobianmapping(position_"in")^T momentum_"out"
$

== Newton's Second Law of Motion

In @law_motion_deduced_from_lagrangian, we deduced the Newton's second law of motion from the Euler-Lagrange equation (@euler_lagrange_equation):

$
  massmatrix_"in" (position_"in") acceleration_"in"(t) + coriolismatrix(position_"in", velocity_"in") velocity_"in"(t) = force_"in" (position_"in", velocity_"in")
$

We are already able to compute the inertia term ($massmatrix_"in" = jacobianmapping^T massmatrix_"out" jacobianmapping$ in @mapping_mass) and the forces ($force_"in" = jacobianmapping force_"out"$ in @mapping_force), so let's focus on the Coriolis term:

$
  coriolismatrix(position_"in", velocity_"in") velocity_"in"(t) = dot(massmatrix_"in")(position_"in") velocity_"in"(t) - 1/2 velocity_"in" (t)^T (partial massmatrix_"in")/(partial position_"in") velocity_"in"(t)
$ 

First term:

$
  dot(massmatrix_"in")(position_"in") velocity_"in"(t) 
  &= (d massmatrix_"in")/(d t) velocity_"in"\
  &= d/(d t) [jacobianmapping^T massmatrix_"out" jacobianmapping] velocity_"in"\
  &= dot(jacobianmapping)^T massmatrix_"out" jacobianmapping velocity_"in" + jacobianmapping^T dot(massmatrix)_"out" jacobianmapping velocity_"in" + jacobianmapping^T massmatrix_"out" dot(jacobianmapping) velocity_"in"
$

The second term involve the derivative of the mass with respect to the state:

$
  (partial massmatrix_"in")/(partial position_"in") &= (partial [jacobianmapping(position_"in")^T massmatrix_"out" (position_"out") jacobianmapping(position_"in")])/(partial position_"in") \
  &= (partial jacobianmapping^T)/(partial position_"in") massmatrix_"out" (position_"out") jacobianmapping(position_"in")
  + jacobianmapping(position_"in")^T (partial massmatrix_"out" (position_"out"))/(partial position_"in") jacobianmapping(position_"in")
  + jacobianmapping(position_"in")^T massmatrix_"out" (position_"out") (partial jacobianmapping(position_"in"))/(partial position_"in")
$

The term $(partial massmatrix_"out" (position_"out"))/(partial position_"in")$:

$
  (partial massmatrix_"out" (position_"out"))/(partial position_"in") 
  &= (partial massmatrix_"out" (position_"out"))/(partial position_"out") (partial position_"out")/(partial position_"in") \
  &= (partial massmatrix_"out" (position_"out"))/(partial position_"out") jacobianmapping(position_"in")
$