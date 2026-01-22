#import "box.typ":*
#import "variables.typ": *

= Lagrangian Mechanics <section_lagrangian_mechanics>

== Introduction

The foundation of Classical Mechanics rests upon a powerful principle: the Lagrangian. This framework provides a way to define and analyze motion without explicitly considering forces or constraints. At its core lies the concept of generalized coordinates, which represent the key variables used to describe the system's state – essentially, how you would measure the system’s position and velocity at any given time.  This section will delve into the fundamental components of Lagrangian mechanics, exploring how these generalized quantities are defined, calculated, and ultimately connected to the dynamics of a physical system.

== States

#definition(title:"State")[
A *state* of a dynamical system is simply a complete description of its condition at a specific point in time. It encompasses all relevant information about the system—its position, velocity, temperature, pressure, or any other measurable properties.  Think of it as representing the *current* state of the system.  For example, if you’re tracking the trajectory of a ball, the state might include its $x$ and $y$ coordinates (position) and its velocity components (speed in each direction).  A state can be defined in many ways – mathematically, physically, or even conceptually – but it always includes the necessary information to fully describe the system's behavior.  The choice of how to define a state depends on the specific problem and the level of detail required.
]

#definition(title: "Generalized Coordinates")[
  $position=position (t)$ is the primary generalized coordinate, representing the system's position in Cartesian coordinates.
]

#definition(title: "Generalized Velocity")[
$velocity=velocity (t)$ is the generalized velocity, representing the rate of change of generalized coordinate.  Importantly, this is the time derivative of the position vector. It captures how quickly the system is moving and provides a direct link to the dynamics of the system..
]

#property()[
$
velocity (t) = (d position)/(d t)
$ <definition_velocity>
This expression calculates the generalized velocity, which is the time derivative of the generalized coordinate vector.
]

#definition(title: "Generalized Acceleration")[
$acceleration=acceleration (t)$ is the generalized acceleration, representing the rate at which the system’s velocity changes.  It’s a measure of how quickly the system is accelerating or decelerating.
]

#property[
$
acceleration (t) = (d velocity)/(d t) = (d^2 position)/(d t^2)
$ <definition_acceleration>
]

If we combine @definition_velocity and @definition_acceleration:

$
mat( velocity (t); acceleration (t))=
d/(d t) mat( position (t); velocity (t))
$ <states_ode>

#definition(title: "Global State")[
$
state (t) =  mat( position (t); velocity (t))
$
This expression represents the global state of the system. It is calculated by taking the concatenation of the position and velocity vectors at a specific time, `t`. This concatenation combines all the relevant information into a single vector, providing a holistic representation of the system’s configuration.
]

$
mat( velocity (t); acceleration (t))=
(d state)/(d t)
$

== Kinetic Energy

#definition(title: "Kinetic Energy")[
The continuous total kinetic energy $kineticenergy$ of a deformable body with mass density $rho(position)$ is given by integrating over the entire volume $V$:

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
The Lagrangian $lagrangian$ of a system of particles is a scalar defined as:

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
Conservative forces $force = force (position, velocity)$ are forces deriving from a potential energy:

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
(partial lagrangian)/(partial position) - d/(d t)((partial lagrangian)/(partial velocity)) = 0
$ <euler_lagrange_equation>

#definition(title: "Euler-Lagrange Equation")[
@euler_lagrange_equation is the Euler-Lagrange equation for a system of particles.
]

#result(title:"General Euler-Lagrange Equation")[
  $
    (partial lagrangian)/(partial phi) - "Div" dot ((partial lagrangiandensity)/(partial nabla phi)) = 0
  $
]
