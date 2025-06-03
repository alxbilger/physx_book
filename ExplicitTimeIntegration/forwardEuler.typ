#import "../variables.typ": *

== Forward Euler Method

The time derivative in @states_ode can be approximated using a forward first-order finite difference:

$
y'(t) approx 1/stepsize (y(t+stepsize)-y(t)) <=> d/(d t) mat( position (t); velocity (t)) approx  1/stepsize (mat( position (t+ Delta t); velocity (t + stepsize)) - mat( position (t); velocity (t)) )
$

Substituting this approximation into @ODE:

$
1/stepsize
mat(
position(t+stepsize)-position(t);
mass(position) thick (velocity(t+stepsize)-velocity(t)) 
)
=
mat(
velocity(t);
force(position,velocity) - coriolismatrix(position, velocity) velocity(t)
)
$


From @sequence, we can also write:

$
1/stepsize
mat(
position_(n+1)-position_n;
mass(velocity_(n+1)-velocity_n)
)
=
mat(
velocity_n;
force(position_n,velocity_n) - coriolismatrix(position_n, velocity_n) velocity_n
)
$ <forward_euler>

Grouping the terms in $n+1$ on the left-hand side:

$
mat( #position _(n+1); #velocity _(n+1))=
mat( #position _n& + Delta t thick #velocity _n; #velocity _n& + Delta t thick mass^(-1)(force(position _n, velocity _n) - coriolismatrix(position_n, velocity_n) velocity_n))
$