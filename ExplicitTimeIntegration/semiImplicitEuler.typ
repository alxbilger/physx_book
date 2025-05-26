#import "../variables.typ": *

== Semi-implicit Euler method

The time derivative in @states_ode can be approximated using a backward first-order finite difference for $x$ and a forward first-order finite difference for $v$:

$
d/(d t) mat(delim:"[", #position (t); #velocity (t)) approx 1/(Delta t) (mat(delim:"[", #position (t); #velocity (t + Delta t)) - mat(delim:"[", #position (t - Delta t); #velocity (t)) )
$

Substituting this approximation into @states_ode:

$
mat(delim:"[", #velocity (t); acceleration(t))=
1/(Delta t) (mat(delim:"[", #position (t); #velocity (t + Delta t)) - mat(delim:"[", #position (t - Delta t); #velocity (t)) )
$

From @sequence, we can also write:

$
mat(delim:"[", #velocity _(n); #acceleration _(n))=
1/(Delta t) mat(delim:"[", position_n - position_(n-1); #velocity _(n+1) - #velocity _n)
$

or

$
mat(delim:"[", #velocity _(n+1); #acceleration _n)=
1/(Delta t) mat(delim:"[", position_(n+1) - position_n; #velocity _(n+1) - #velocity _(n))
$ <initial_semiimplicit_euler>

Multiplying the second line of @initial_semiimplicit_euler by $M$:
$
mat(delim:"[", #velocity _(n+1); M #acceleration _n)=
1/(Delta t) mat(delim:"[", position_(n+1) - position_n; M(#velocity _(n+1) - #velocity _(n)))
$

From @short_dynamic:
$
mat(delim:"[", #velocity _(n+1); F(position_n,#velocity _n))=
1/(Delta t) mat(delim:"[", position_(n+1) - position_n; M(#velocity _(n+1) - #velocity _(n)))
$

Finally,

$
mat(delim:"[", position_(n+1); #velocity _(n+1)) =
mat(delim:"[", position_n& + Delta t thick #velocity _(n+1); #velocity _n& + Delta t thick M^(-1)F(position_n, #velocity _n))
$