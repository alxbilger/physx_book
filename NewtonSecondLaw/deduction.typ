#import "../variables.typ": *
#import "../box.typ":*

== Deduction from the Lagrangian <law_motion_deduced_from_lagrangian>

We apply the Euler-Lagrange equation on the Lagrangian defined in @the_lagrangian. It requires to compute $(partial lagrangian)/(partial position)$ and $d/(d t)((partial lagrangian)/(partial velocity))$.

#mybox(title: "Computation of " + $(partial lagrangian)/(partial position)$)[
First, let's compute the term $(partial lagrangian)/(partial position)$:

$
(partial lagrangian)/(partial position) = (partial kineticenergy) / (partial position) - (partial V)/(partial position)
$

$
  (partial kineticenergy) / (partial position) &= partial/(partial position) [1/2 velocity(t)^T massmatrix(position) velocity(t)] \
  &= 1/2 velocity(t)^T (partial massmatrix)/(partial position) velocity(t)
$

Therefore,

$
(partial lagrangian)/(partial position) = 1/2 velocity(t)^T (partial massmatrix)/(partial position) velocity(t) + force(position, velocity)
$
]

#mybox(title: "Computation of " + $d/(d t)((partial lagrangian)/(partial velocity))$)[
Then, the term $d/(d t)((partial lagrangian)/(partial velocity))$ is the time derivative of the momentum (see @momentum):

$
  (d momentum)/(d t) = (d massmatrix(position) velocity(t))/(d t) = dot(massmatrix)(position) velocity(t) + massmatrix(position) acceleration(t)
$
]

Putting all together from @euler_lagrange_equation:

$
  (partial lagrangian)/(partial #position) - d/(d t)((partial lagrangian)/(partial #velocity)) = 0
  &<=> 1/2 velocity(t)^T (partial massmatrix)/(partial position) velocity(t) + force(position, velocity) - (dot(massmatrix)(position) velocity(t) + massmatrix(position) acceleration(t)) = 0 \
  &<=>massmatrix(position) acceleration(t) + dot(massmatrix)(position) velocity(t) - 1/2 velocity(t)^T (partial massmatrix)/(partial position) velocity(t) = force(position, velocity)
$

#definition(title: "Coriolis Matrix")[
Let's us define the Coriolis and centrifugal terms $coriolismatrix(position, velocity)$ such that

$
  coriolismatrix(position, velocity) velocity(t) = dot(massmatrix)(position) velocity(t) - 1/2 velocity(t)^T (partial massmatrix)/(partial position) velocity(t)
$
]

#result[
The final form of the second Newton's law deduced from the Lagrangian is:

$
massmatrix(position) acceleration(t) + coriolismatrix(position, velocity) velocity(t) = force(position, velocity)
$ <second_newton_law>
]

#result[
In the special case where the mass does not depend on the position, nor time, $coriolismatrix=0$. Then the Newton's law of motion is:

$
massmatrix acceleration(t) = force(position, velocity)
$
]