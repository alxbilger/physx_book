#import "../variables.typ": *

== Forward Euler Method

The time derivative in @states_ode can be approximated using a forward first-order finite difference:

$
d/(d t) mat(delim:"[", position (t); velocity (t)) approx  1/stepsize (mat(delim:"[", position (t+ Delta t); velocity (t + stepsize)) - mat(delim:"[", position (t); velocity (t)) )
$

Substituting this approximation into @ODE:



$
1/stepsize
mat(delim:"[",
position(t+stepsize)-position(t);
mass (velocity(t+stepsize)-velocity(t)))
=
mat(delim:"[",
velocity(t);
force(position,velocity))
$


From @sequence, we can also write:

$
1/stepsize
mat(delim:"[",
position_(n+1)-position_n;
mass(velocity_(n+1)-velocity_n))
=
mat(delim:"[",
velocity_n;
force(position_n,velocity_n))
$ <forward_euler>

Grouping the terms in $n+1$ on the left-hand side:

$
mat(delim:"[", #position _(n+1); #velocity _(n+1))=
mat(delim:"[", #position _n& + Delta t thick #velocity _n; #velocity _n& + Delta t thick mass^(-1)F(#position _n, #velocity _n))
$