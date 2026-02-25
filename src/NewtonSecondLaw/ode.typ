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
