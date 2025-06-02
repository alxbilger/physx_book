#import "variables.typ": *

= Mapping

A mapping is a coordinate transformation function $mapping$ such that:

$
  position_"out" = mapping(position_"in")
$ <mapping_function>

== Velocity

The velocity is deduced from @mapping_function:

$
  velocity_"out" = (d position_"out")/(d t) = (d mapping(position_"in"))/(d t) = (d mapping(position_"in")) / (d position_"in") (d position_"in") / (d t) = (d mapping(position_"in")) / (d position_"in") velocity_"in"
$

We introduce the jacobian matrix $jacobianmapping$ of the mapping:

$
  jacobianmapping(position) = bold(partial) mapping(position) = (partial mapping(position)) / (partial position)
$

Such that:

$
  velocity_"out" = jacobianmapping(position_"in") velocity_"in"
$ <mapping_velocity>

== Force

The power of the force applying on $position_"in"$ is equivalent to the power of the force applying on $position_"out"$:

$
  velocity_"in"^T force_"in" (position_"in") = velocity_"out"^T force_"out" (position_"out")
$

Then,

$
  velocity_"in"^T force_"in" (position_"in") = (jacobianmapping(position_"in") velocity_"in")^T force_"out" (position_"out") = velocity_"in"^T jacobianmapping(position_"in")^T force_"out" (position_"out")
$

We can deduce from the principle of virtual work:

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
  kineticenergy_"out" = 1/2 velocity_"out"^T mass_"out" (position_"out") velocity_"out"
$

From @mapping_velocity:

$
  kineticenergy_"out" &= 1/2 (jacobianmapping(position_"in") velocity_"in")^T mass_"out" (position_"out") (jacobianmapping(position_"in") velocity_"in") \
  &= 1/2 velocity_"in"^T jacobianmapping(position_"in")^T mass_"out" (position_"out")  jacobianmapping(position_"in") velocity_"in"
$

We also have

$
  kineticenergy_"in" = 1/2 velocity_"in"^T mass_"in" (position_"in")  velocity_"in"
$

The kinetic energy is invariant under coordinate transformation: $kineticenergy_"in"=kineticenergy_"out"$. By identification, we can deduce that

$
  mass_"in" (position_"in") = jacobianmapping(position_"in")^T mass_"out" (position_"out") jacobianmapping(position_"in")
$ <mapping_mass>

== Momentum

From @momentum,

$
  momentum_"in" = (partial kineticenergy_"in")/(partial velocity_"in") 
  &= partial/(partial velocity_"in") (1/2 velocity_"in"^T mass_"in" (position_"in") velocity_"in")\
  &= mass_"in" (position_"in") velocity_"in"\
  &= jacobianmapping(position_"in")^T mass_"out" (position_"out") jacobianmapping(position_"in") velocity_"in"\
$

From @mapping_velocity:

$
  momentum_"in" &= jacobianmapping(position_"in")^T mass_"out" (position_"out") velocity_"out"
$

We also have:

$
  momentum_"out" = (partial kineticenergy_"out")/(partial velocity_"out")
  &= partial/(partial velocity_"out") (1/2 velocity_"out"^T mass_"out" (position_"out") velocity_"out")\
  &= mass_"out" (position_"out") velocity_"out"
$

We can deduce that:

$
  momentum_"in" = jacobianmapping(position_"in")^T momentum_"out"
$

== Newton's Second Law of Motion

In @law_motion_deduced_from_lagrangian, we deduced the Newton's second law of motion from the Euler-Lagrange equation (@euler_lagrange_equation):

$
  mass_"in" (position_"in") acceleration_"in"(t) + coriolismatrix(position_"in", velocity_"in") velocity_"in"(t) = force_"in" (position_"in", velocity_"in")
$

We are already able to compute the inertia term ($mass_"in" = jacobianmapping^T mass_"out" jacobianmapping$ in @mapping_mass) and the forces ($force_"in" = jacobianmapping force_"out"$ in @mapping_force), so let's focus on the Coriolis term:

$
  coriolismatrix(position_"in", velocity_"in") velocity_"in"(t) = dot(mass_"in")(position_"in") velocity_"in"(t) - 1/2 velocity_"in" (t)^T (partial mass_"in")/(partial position_"in") velocity_"in"(t)
$ 

First term:

$
  dot(mass_"in")(position_"in") velocity_"in"(t) 
  &= (d mass_"in")/(d t) velocity_"in"\
  &= d/(d t) [jacobianmapping^T mass_"out" jacobianmapping] velocity_"in"\
  &= dot(jacobianmapping)^T mass_"out" jacobianmapping velocity_"in" + jacobianmapping^T dot(mass)_"out" jacobianmapping velocity_"in" + jacobianmapping^T mass_"out" dot(jacobianmapping) velocity_"in"
$

The second term involve the derivative of the mass with respect to the state:

$
  (partial mass_"in")/(partial position_"in") &= (partial [jacobianmapping(position_"in")^T mass_"out" (position_"out") jacobianmapping(position_"in")])/(partial position_"in") \
  &= (partial jacobianmapping^T)/(partial position_"in") mass_"out" (position_"out") jacobianmapping(position_"in")
  + jacobianmapping(position_"in")^T (partial mass_"out" (position_"out"))/(partial position_"in") jacobianmapping(position_"in")
  + jacobianmapping(position_"in")^T mass_"out" (position_"out") (partial jacobianmapping(position_"in"))/(partial position_"in")
$

The term $(partial mass_"out" (position_"out"))/(partial position_"in")$:

$
  (partial mass_"out" (position_"out"))/(partial position_"in") 
  &= (partial mass_"out" (position_"out"))/(partial position_"out") (partial position_"out")/(partial position_"in") \
  &= (partial mass_"out" (position_"out"))/(partial position_"out") jacobianmapping(position_"in")
$