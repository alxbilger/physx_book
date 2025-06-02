#import "../variables.typ": *

== Deduction from the Lagrangian <law_motion_deduced_from_lagrangian>

We apply the Euler-Lagrange equation on the Lagrangian defined in @the_lagrangian. It requires to compute $(partial lagrangian)/(partial position)$ and $d/(d t)((partial lagrangian)/(partial velocity))$.

First, let's compute the term $(partial lagrangian)/(partial position)$:

$
(partial lagrangian)/(partial position) = (partial kineticenergy) / (partial position) - (partial V)/(partial position)
$

$
  (partial kineticenergy) / (partial position) &= partial/(partial position) [1/2 velocity(t)^T mass(position) velocity(t)] \
  &= 1/2 velocity(t)^T (partial mass)/(partial position) velocity(t)
$

Therefore,

$
(partial lagrangian)/(partial position) = 1/2 velocity(t)^T (partial mass)/(partial position) velocity(t) + force(position, velocity)
$

Then, the term $d/(d t)((partial lagrangian)/(partial velocity))$ is the time derivative of the momentum (@momentum):

$
  (d momentum)/(d t) = (d mass(position) velocity(t))/(d t) = dot(mass)(position) velocity(t) + mass(position) acceleration(t)
$

Putting all together from @euler_lagrange_equation:

$
  (partial lagrangian)/(partial #position) - d/(d t)((partial lagrangian)/(partial #velocity)) = 0
  &<=> 1/2 velocity(t)^T (partial mass)/(partial position) velocity(t) + force(position, velocity) - (dot(mass)(position) velocity(t) + mass(position) acceleration(t)) = 0 \
  &<=>mass(position) acceleration(t) + dot(mass)(position) velocity(t) - 1/2 velocity(t)^T (partial mass)/(partial position) velocity(t) = force(position, velocity)
$

Let's us define the Coriolis and centrifugal terms $coriolismatrix(position, velocity)$ such that

$
  coriolismatrix(position, velocity) velocity(t) = dot(mass)(position) velocity(t) - 1/2 velocity(t)^T (partial mass)/(partial position) velocity(t)
$

The final form of the second Newton's law deduced from the Lagrangian is:

$
mass(position) acceleration(t) + coriolismatrix(position, velocity) velocity(t) = force(position, velocity)
$ <second_newton_law>

In the special case where the mass does not depend on the position, nor time, $coriolismatrix=0$. Then the Newton's law of motion is:

$
mass(position) acceleration(t) = force(position, velocity)
$