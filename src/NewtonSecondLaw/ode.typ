#import "../variables.typ": *
#import "../box.typ": *

== Ordinary Differential Equation

@second_newton_law is a second-order differential equation. We transform it to a first-order.

Substituting @definition_acceleration into @second_newton_law:

$
massmatrix(position) (d velocity)/(d t) + coriolismatrix(position, velocity) velocity(t) = force(position, velocity)
$

Combined with @definition_velocity, we have a first-order ordinary differential equation in $position$ and $velocity$:

$
mat(
(d position)/(d t);
massmatrix(position) thick (d velocity)/(d t) + coriolismatrix(position, velocity) velocity(t)
) =
mat(
velocity;
force(position, velocity)
)
$ <ODE>

=== Rayleigh Damping

#definition(title: "Rayleigh Damping")[
Rayleigh damping is defined as:

$
F_"Rayleigh" = (-alpha massmatrix(position) + beta stiffness(position, velocity)) velocity
$ <F_rayleigh>

where $alpha$ is a stiffness-proportional damping coefficient, and $beta$ is a mass-proportional damping coefficient.
]

$F_"Rayleigh"$ is added to the sum of forces in @ODE:

$
mat(
(d position)/(d t);
massmatrix(position) (d velocity)/(d t) + coriolismatrix(position, velocity) velocity(t)
) =
mat(
velocity;
force(position, velocity) + (-alpha massmatrix + beta stiffness) velocity
)
$ <ODE_rayleigh>
