#import "variables.typ": *

= Mapping

A mapping is defined by a function $mapping$ such that:

$
  position_"out" = mapping(position_"in")
$


The velocity is deduced:

$
  velocity_"out" = (d position_"out")/(d t) = (d mapping(position_"in"))/(d t) = (d mapping(position_"in")) / (d position_"in") (d position_"in") / (d t) = (d mapping(position_"in")) / (d position_"in") velocity_"in"
$

We introduce the jacobian matrix $jacobianmapping$ of the mapping:

$
  jacobianmapping(position) = (d mapping(position)) / (d position)
$

Such that:

$
  velocity_"out" = jacobianmapping(position_"in") velocity_"in"
$

The power of the force applying on $position_"in"$ is equivalent to the power of the force applying on $position_"out"$:

$
  velocity_"in"^T force(position_"in") = velocity_"out"^T force(position_"out")
$

Then,

$
  velocity_"in"^T force(position_"in")  = (jacobianmapping(position_"in") velocity_"in")^T force(position_"out") = velocity_"in"^T jacobianmapping(position_"in")^T force(position_"out")
$

We can deduce from the principle of virtual work:

$
  force(position_"in") = jacobianmapping(position_"in")^T force(position_"out")
$

If we are interested in the derivatives:

$
  stiffness_"in" (position_"in") = (partial force(position_"in"))/(partial position_"in") 
  &= (partial jacobianmapping(position_"in")^T)/(partial position_"in") force(position_"out") + jacobianmapping(position_"in")^T  (partial force(position_"out"))/(partial position_"in") \
  &= (partial jacobianmapping(position_"in")^T)/(partial position_"in") force(position_"out") + jacobianmapping(position_"in")^T  (partial force(position_"out"))/(partial position_"out") (partial position_"out")/(partial position_"in") \
  &= (partial jacobianmapping(position_"in")^T)/(partial position_"in") force(position_"out") + jacobianmapping(position_"in")^T  stiffness_"out" (position_"out") (partial mapping(position_"in"))/(partial position_"in") \
  &= (partial jacobianmapping(position_"in")^T)/(partial position_"in") force(position_"out") + jacobianmapping(position_"in")^T  stiffness_"out" (position_"out") jacobianmapping(position_"in")
$

The term $(partial jacobianmapping(position_"in")^T)/(partial position_"in")$ is called the geometric stiffness of the mapping.

The term $jacobianmapping(position_"in")^T  stiffness_"out" (position_"out") jacobianmapping(position_"in")$ is a projection of the matrix $stiffness_"out"$ from the space "out" to the space "in".


