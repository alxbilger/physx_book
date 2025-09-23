#import "box.typ":*
#import "variables.typ": *

= Lagrangian Mechanics

== States

#definition(title: "Generalized Coordinates")[
  $position=position (t)$ is the generalized coordinates (= position in Cartesian coordinates).
]

#definition(title: "Generalized Velocity")[
$velocity=velocity (t)$ is the generalized velocity (= velocity in Cartesian coordinates), i.e. the time derivative of the generalized coordinates.
]

#property()[
$
velocity (t) = (d position)/(d t)
$ <definition_velocity>
]

#definition(title: "Generalized Acceleration")[
$acceleration=acceleration (t)$ is the generalized acceleration (= acceleration in Cartesian coordinates), i.e. the time derivative of the generalized velocity.
]

#property[
$
acceleration (t) = (d velocity)/(d t) = (d^2 position)/(d t^2)
$ <definition_acceleration>
]

If we combine @definition_velocity and @definition_acceleration:

$
mat( #velocity (t); #acceleration (t))=
d/(d t) mat( #position (t); #velocity (t))
$ <states_ode>

#definition(title: "Global State")[
Global state
$
#state (t) =  mat( #position (t); #velocity (t))
$
]

$
mat( #velocity (t); #acceleration (t))=
(d #state)/(d t)
$

== Kinetic Energy

#definition(title: "Kinetic Energy")[
The continuous total kinetic energy $T$ of a deformable body with mass density $rho(position)$ is given by integrating over the entire volume $V$:

$
kineticenergy &= 1/2 integral_V norm(velocity (t))^2 thick rho(position) thick dif V
$
]

$
kineticenergy &= 1/2 integral_V norm(velocity (t))^2 thick rho(position) thick dif V \
&= 1/2 integral_V velocity (t)^T dot velocity(t) thick rho(position) thick dif V \
&= 1/2 velocity(t)^T (integral_V rho(position) d v) velocity(t)
$

#definition(title: "Mass")[
The term $integral_V rho(position) d v$ is called mass:

$
  massmatrix(position) = integral_V rho(position) d v
$
]

Therefore,

$
  kineticenergy = 1/2 thick velocity(t)^T thick massmatrix(position) thick velocity(t)
$

In general, the mass $massmatrix$ depends on the state $position$, and therefore varies with time.

== Lagrangian

#definition(title: "Lagrangian")[
The Lagrangian $lagrangian$ of a system of particles is defined as:

$
lagrangian(position, velocity, t) = kineticenergy - potentialenergy
$ <the_lagrangian>

where:
- $kineticenergy$ is the total kinetic energy
- $potentialenergy$ is the potential energy
]

#definition(title:"Lagrangian Density")[
  The Lagrangian density $lagrangian$ of a vector field $phi$ is defined as:
  $
    lagrangiandensity(phi, dot(phi), nabla phi) = kineticenergy - potentialenergy
  $

  Then, the Lagrangian is defined as:
  $
    lagrangian = integral_Omega lagrangiandensity thick dif V
  $
]

== Forces

#definition(title: "Force")[
Conservative forces $#force = #force (#position, #velocity)$ are forces deriving from a potential energy:

$
force = -(partial potentialenergy) / (partial position)
$
]

#definition(title: "Stiffness")[
$stiffness (position, velocity) = (partial force)/(partial position)$ is called stiffness.
]

#definition(title: "Damping")[
$damping (position, velocity) = (partial force)/(partial velocity)$ is called damping.
]

== Momentum

#definition(title: "Momentum")[
The conjugate momentum is defined as:
$
momentum = (partial lagrangian) / (partial velocity)
$ <momentum>
]

Based on the definition of the Lagrangian (@the_lagrangian):

$
  momentum = (partial kineticenergy)/(partial velocity) - (partial V)/(partial velocity)
$

When the potential energy does not depend on the velocity (magnetic forces, dissipative forces...):

$
  (partial V)/(partial velocity) = 0
$

Therefore,

#result(title:"Linear Momentum")[
$
momentum = (partial kineticenergy)/(partial velocity) = massmatrix(position) thick velocity(t)
$
#emoji.warning This result is valid only if the potential energy does not depend on the velocity
]

== Action

#definition(title: "Action")[
The action is the accumulation of values of the Lagrangian between two states:

$
S = integral_(t_1)^(t_2) lagrangian thick dif t
$

For a vector field $phi$,

$
  S = integral_(t_1)^(t_2) integral_Omega lagrangiandensity thick dif V dif t
$

More generally, we can write:
$
  S = integral lagrangiandensity thick dif^(d+1) x
$
where $d^(d+1) x$ denotes integration over space and time ($d=0$ for particles and $d>=1$ for fields).
]

The action principles state that the true path of $position$ from $t_1$ to $t_2$ is a stationary point of the action:

$
delta S = (d S) / (d position) = 0
$ <action_principle>

where $delta$ represents a small variation of the trajectory.

== Euler-Lagrange Equation

For a system of particles, we develop the Lagrangian at the first-order:

$
lagrangian(position + delta position, velocity + delta velocity, t) approx lagrangian(position, velocity, t) + (partial lagrangian)/(partial position) delta position + (partial lagrangian)/(partial velocity) delta velocity
$

The variation of the action in terms of the first-order development:

$
delta S &= S[position + delta position] - S[position] \
&= integral_(t_1)^(t_2) (lagrangian(position, velocity, t) + (partial lagrangian)/(partial position) delta position + (partial lagrangian)/(partial velocity) delta velocity) d t - integral_(t_1)^(t_2) lagrangian(position, velocity, t) thick dif t \
&= integral_(t_1)^(t_2) [(partial lagrangian) / (partial position) delta position + (partial lagrangian) / (partial velocity) delta velocity] d t \
&= integral_(t_1)^(t_2) (partial lagrangian) / (partial position) delta position thick dif t + integral_(t_1)^(t_2)  (partial lagrangian) / (partial velocity) delta velocity thick dif t
$ <action_variation_first_order>

The velocity term is transformed using integration by parts (@integration_by_parts):

$
integral_(t_1)^(t_2) (partial lagrangian) / (partial velocity) delta velocity thick dif t = [(partial lagrangian)/(partial velocity) delta position]_(t_1)^(t_2) - integral_(t_1)^(t_2) d/(d t) ((partial lagrangian)/(partial velocity)) delta position  thick dif t
$


The position at $t_1$ and $t_2$ is fixed. Only the path from $t_1$ to $t_2$ is subject to change. It means that $delta position(t_1) = 0$ and $delta position(t_2) = 0$. We can deduce that $[(partial lagrangian)/(partial velocity) delta position]_(t_1)^(t_2) = 0$.

Finally, the velocity term is replaced in @action_variation_first_order:

$
delta S &= integral_(t_1)^(t_2) (partial lagrangian) / (partial position) delta position thick dif t + integral_(t_1)^(t_2)  (partial lagrangian) / (partial velocity) delta velocity thick dif t \ 
&= integral_(t_1)^(t_2) (partial lagrangian) / (partial position) delta position thick dif t - integral_(t_1)^(t_2) d/(d t) ((partial lagrangian)/(partial velocity)) delta position  thick dif t \
&= integral_(t_1)^(t_2) [(partial lagrangian) / (partial position) delta position - d/(d t) ((partial lagrangian)/(partial velocity)) delta position ] dif t \
&= integral_(t_1)^(t_2) [(partial lagrangian) / (partial position) - d/(d t) ((partial lagrangian)/(partial velocity)) ] delta position thick dif t
$

From the fundamental lemma of the calculus of variations:

$
(partial lagrangian)/(partial #position) - d/(d t)((partial lagrangian)/(partial #velocity)) = 0
$ <euler_lagrange_equation>

#definition(title: "Euler-Lagrange Equation")[
@euler_lagrange_equation is the Euler-Lagrange equation for a system of particles.
]

#result(title:"General Euler-Lagrange Equation")[
  $
    (partial lagrangian)/(partial phi) - "Div" dot ((partial lagrangiandensity)/(partial nabla lagrangiandensity)) = 0
  $
]