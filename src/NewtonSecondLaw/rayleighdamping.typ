#import "../variables.typ": *
#import "../box.typ": *

== Rayleigh Damping <sec_rayleigh_damping>

#definition(title: "Rayleigh Damping")[
Rayleigh damping is defined as:

$
F_"Rayleigh" := (-alpha massmatrix(position) + beta stiffness(position, velocity)) velocity
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
