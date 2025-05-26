#import "../variables.typ": *

== Ordinary Differential Equation

@second_newton_law is a second-order differential equation. We transform it to a first-order.

Substituting @definition_acceleration into @second_newton_law:

$
mass (d velocity)/(d t) = force(position, velocity)
$

Combined with @definition_velocity, we have a first-order ordinary differential equation in $position$ and $velocity$:

$
mat(delim:"[",
(d position)/(d t);
mass (d velocity)/(d t)
) =
mat(delim:"[",
velocity;
force(position, velocity)
)
$ <ODE>

=== Rayleigh Damping

Rayleigh damping is defined as:

$
F_"Rayleigh" = (-alpha mass + beta underbrace((partial force(position, velocity))/(partial position), stiffness(position, velocity))) velocity
$ <F_rayleigh>

$F_"Rayleigh"$ is added to the sum of forces in @ODE:

$
mat(delim:"[",
(d position)/(d t);
mass (d velocity)/(d t)
) =
mat(delim:"[",
velocity;
force(position, velocity) + (-alpha mass + beta stiffness) velocity
)
$ <ODE_rayleigh>
