#import "../variables.typ": *
#import "../box.typ": *

== Semi-implicit Euler method

The time derivative in @states_ode can be approximated using a backward first-order finite difference for $position$ and a forward first-order finite difference for $velocity$:

$
d/(d t) mat( position (t); velocity (t)) approx 1/stepsize (mat( position (t); velocity (t + Delta t)) - mat( position (t - stepsize); velocity (t)) )
$

Substituting this approximation into @states_ode:

$
mat(velocity (t); acceleration(t))=
1/(stepsize) (mat( #position (t); #velocity (t + stepsize)) - mat( #position (t - stepsize); velocity (t)) )
$

From @sequence, we can also write:

$
mat( #velocity _(n); #acceleration _(n))=
1/(Delta t) mat( position_n - position_(n-1); #velocity _(n+1) - #velocity _n)
$

or

$
mat( #velocity _(n+1); #acceleration _n)=
1/(Delta t) mat( position_(n+1) - position_n; #velocity _(n+1) - #velocity _(n))
$ <initial_semiimplicit_euler>

Multiplying the second line of @initial_semiimplicit_euler by $massmatrix$:
$
mat( #velocity _(n+1); massmatrix acceleration _n)=
1/(Delta t) mat( position_(n+1) - position_n; massmatrix(velocity _(n+1) - velocity _(n)))
$

From @second_newton_law:
$
mat( #velocity _(n+1); force(position_n, velocity _n) - coriolismatrix(position_n, velocity_n) velocity_n) =
1/(Delta t) mat( position_(n+1) - position_n; massmatrix(#velocity _(n+1) - #velocity _(n)))
$

Finally,

#result[
$
mat( position_(n+1); velocity _(n+1)) =
mat( position_n& + Delta t thick velocity _(n+1); velocity _n& + Delta t thick massmatrix^(-1)(force(position_n, velocity _n) - coriolismatrix(position_n, velocity_n) velocity_n))
$
]