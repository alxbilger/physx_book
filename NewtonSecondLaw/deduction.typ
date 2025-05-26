#import "../variables.typ": *

== Deduction from the Lagrangian <law_motion_deduced_from_lagrangian>

We apply the Euler-Lagrange equation on the Lagrangian defined in @the_lagrangian. It requires to compute $(partial lagrangian)/(partial position)$ and $d/(d t)((partial lagrangian)/(partial velocity))$:

$
(partial lagrangian)/(partial position) = (partial T) / (partial position) - (partial V)/(partial position)
$

The derivative of the kinetic energy $T$ with respect to the position is null as it does not depend on the position (only the rest position). Therefore,

$
(partial lagrangian)/(partial position) = - (partial V)/(partial position) = force(position, velocity)
$

The term $d/(d t)((partial lagrangian)/(partial velocity))$ is the time derivative of the momentum (@momentum).

The final form of the second Newton's law deduced from the Lagrangian is:

$
force(position, velocity) - (d momentum)/(d t) = 0
$

If we rearrange the terms:

$
(d momentum)/(d t) = force(position, velocity) 
$

If the potential energy does not depend on the velocity:

$
mass acceleration = force(position, velocity)
$ <second_newton_law>
