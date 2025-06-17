#import "variables.typ": *
#import "box.typ": *

= Static Equilibrium

#definition(title: "Static Equilibrium")[
The physical system does not experience any acceleration
$
acceleration(t)=0
$
]

#definition(title: "Dynamic Equilibrium")[
$acceleration = 0$ does not necessarily imply $velocity=0$.
It means that $velocity$ is a constant.
If this constant is nonzero, it is called dynamic equilibrium or steady motion.
]

In this section, we consider $velocity=0$.
Second Newton's law (@second_newton_law) becomes:

$
force(#position)=0
$

This is a non-linear equation. It is solved using Newton-Raphson method.

Solve for $Delta position^i = position^(i+1) - position^i$:

$
lr((partial force)/(partial position)|)_(position^i) Delta position^i = -force(position^i) 
$

This is a linear system to be solved.

With $stiffness^i=lr((partial force)/(partial position)|)_(position^i)$, we solve:

$
stiffness^i thick Delta position^i = -force(position^i)
$ <static_linear_system>

Then,

$
#position^(i+1) = Delta #position^i + #position^i
$