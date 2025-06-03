
#import "variables.typ": *

= Lagrangian Mechanics

== States

$position=position (t)$ is the generalized coordinates (= position in Cartesian coordinates).

$velocity=velocity (t)$ is the generalized velocity (= velocity in Cartesian coordinates), i.e. the time derivative of the generalized coordinates.

$
velocity (t) = (d position)/(d t)
$ <definition_velocity>

$acceleration=acceleration (t)$ is the generalized acceleration (= acceleration in Cartesian coordinates), i.e. the time derivative of the generalized velocity.

$
acceleration (t) = (d velocity)/(d t) = (d^2 position)/(d t^2)
$ <definition_acceleration>

If we combine @definition_velocity and @definition_acceleration:

$
mat( #velocity (t); #acceleration (t))=
d/(d t) mat( #position (t); #velocity (t))
$ <states_ode>

Global state
$
#state (t) =  mat( #position (t); #velocity (t))
$

$
mat( #velocity (t); #acceleration (t))=
(d #state)/(d t)
$

== Kinetic Energy

The continuous total kinetic energy $T$ of a deformable body with mass density $rho(position)$ is given by integrating over the entire volume $V$:

$
kineticenergy &= 1/2 integral_V norm(velocity (t))^2 thick rho(position) thick d v \
&= 1/2 integral_V velocity (t)^T dot velocity(t) thick rho(position) thick d v \
&= 1/2 velocity(t)^T (integral_V rho(position) d v) velocity(t)
$

The term $integral_V rho(position) d v$ is called mass:

$
  mass(position) = integral_V rho(position) d v
$

Therefore,

$
  kineticenergy = 1/2 thick velocity(t)^T thick mass(position) thick velocity(t)
$

In general, the mass $mass$ depends on the state $position$, and therefore varies with time.

== Lagrangian

The Lagrangian $lagrangian$ of a system is defined as:

$
lagrangian(position, velocity, t) = kineticenergy - potentialenergy
$ <the_lagrangian>

where:
- $kineticenergy$ is the total kinetic energy
- $potentialenergy$ is the potential energy

== Forces

Conservative forces $#force = #force (#position, #velocity)$ are forces deriving from a potential energy:

$
force = -(partial potentialenergy) / (partial position)
$


$#stiffness (#position, #velocity) = (partial #force)/(partial #position)$ is called stiffness.

$#damping (#position, #velocity) = (partial #force)/(partial #velocity)$ is called damping.

== Momentum

The conjugate momentum is defined as:
$
momentum = (partial lagrangian) / (partial velocity)
$ <momentum>

Based on the definition of the Lagrangian (@the_lagrangian):

$
  momentum = (partial kineticenergy)/(partial velocity) - (partial V)/(partial velocity)
$

When the potential energy does not depend on the velocity (magnetic forces, dissipative forces...):

$
  (partial V)/(partial velocity) = 0
$

Therefore,
$
momentum = (partial kineticenergy)/(partial velocity) = mass(position) thick velocity(t)
$

== Action

The action is the accumulation of values of the Lagrangian between two states:

$
S = integral_(t_1)^(t_2) lagrangian thick d t
$

The action principles state that the true path of $position$ from $t_1$ to $t_2$ is a stationary point of the action:

$
delta S = (d S) / (d position) = 0
$

where $delta$ represents a small variation of the trajectory.

== Euler-Lagrange Equation

We develop the Lagrangian at the first-order:

$
lagrangian(position + delta position, velocity + delta velocity, t) approx lagrangian(position, velocity, t) + (partial lagrangian)/(partial position) delta position + (partial lagrangian)/(partial velocity) delta velocity
$

The variation of the action in terms of the first-order development:

$
delta S &= S[position + delta position] - S[position] \
&= integral_(t_1)^(t_2) (lagrangian(position, velocity, t) + (partial lagrangian)/(partial position) delta position + (partial lagrangian)/(partial velocity) delta velocity) d t - integral_(t_1)^(t_2) lagrangian(position, velocity, t) thick d t \
&= integral_(t_1)^(t_2) [(partial lagrangian) / (partial position) delta position + (partial lagrangian) / (partial velocity) delta velocity] d t \
&= integral_(t_1)^(t_2) (partial lagrangian) / (partial position) delta position thick d t + integral_(t_1)^(t_2)  (partial lagrangian) / (partial velocity) delta velocity thick d t
$ <action_variation_first_order>

The velocity term is transformed using integration by parts (@integration_by_parts):

$
integral_(t_1)^(t_2) (partial lagrangian) / (partial velocity) delta velocity thick d t = [(partial lagrangian)/(partial velocity) delta position]_(t_1)^(t_2) - integral_(t_1)^(t_2) d/(d t) ((partial lagrangian)/(partial velocity)) delta position  thick d t
$


The position at $t_1$ and $t_2$ is fixed. Only the path from $t_1$ to $t_2$ is subject to change. It means that $delta position(t_1) = 0$ and $delta position(t_2) = 0$. We can deduce that $[(partial lagrangian)/(partial velocity) delta position]_(t_1)^(t_2) = 0$.

Finally, the velocity term is replaced in @action_variation_first_order:

$
delta S &= integral_(t_1)^(t_2) (partial lagrangian) / (partial position) delta position thick d t + integral_(t_1)^(t_2)  (partial lagrangian) / (partial velocity) delta velocity thick d t \ 
&= integral_(t_1)^(t_2) (partial lagrangian) / (partial position) delta position thick d t - integral_(t_1)^(t_2) d/(d t) ((partial lagrangian)/(partial velocity)) delta position  thick d t \
&= integral_(t_1)^(t_2) [(partial lagrangian) / (partial position) delta position - d/(d t) ((partial lagrangian)/(partial velocity)) delta position ] d t \
&= integral_(t_1)^(t_2) [(partial lagrangian) / (partial position) - d/(d t) ((partial lagrangian)/(partial velocity)) ] delta position thick d t
$

From the fundamental lemma of the calculus of variations:

$
(partial lagrangian)/(partial #position) - d/(d t)((partial lagrangian)/(partial #velocity)) = 0
$ <euler_lagrange_equation>

This is the Euler-Lagrange equation.
