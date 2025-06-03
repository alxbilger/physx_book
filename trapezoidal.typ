#import "variables.typ": *

== Crank–Nicolson method

It is the average of the forward Euler method (@forward_euler) and the backward Euler method (@backward_euler)

$
underbrace(1/stepsize
mat(
position_(n+1)-position_n;
mass(velocity_(n+1)-velocity_n)), "forward")
+ 
underbrace(1/stepsize
mat(
position_(n+1) - position_n;
mass ( velocity_(n+1) - velocity_n)
), "backward")
=
underbrace(mat(
velocity_n;
force(position_n,velocity_n)), "forward")
+
underbrace(mat(
velocity_(n+1);
force(position_(n+1), velocity_(n+1))), "backward")
$

$
2/stepsize
mat(
position_(n+1)-position_n;
mass(velocity_(n+1)-velocity_n))
=
mat(
velocity_n + velocity_(n+1);
force(position_n,velocity_n) + force(position_(n+1), velocity_(n+1))
)
$<trapezoidal_rule>

Definition of the residual function $r$:

$
r(state) = r(position, velocity) =
mat(
position - position_(n) - stepsize/2 (velocity_n + velocity);
mass(velocity - velocity_n) - stepsize/2 (force(position_n, velocity_n)+force(position, velocity))
)
$

Based on @trapezoidal_rule, we want to find the root $state_(n+1) = mat( position_(n+1); velocity_(n+1))$ of $r$ such that $r(state_(n+1))=0$.

We will need to compute the Jacobian $J_r = (partial r)/(partial x) = mat(
(partial r_1)/(partial #position), (partial r_1)/(partial #velocity);
(partial r_2)/(partial #position), (partial r_2)/(partial #velocity);
)$ of $r$. Let's compute each term:

$
(partial r_1)/(partial position) = identity
$

$
(partial r_1)/(partial velocity) = -stepsize/2 thick identity
$

$
(partial r_2)/(partial position) = -stepsize/2 (partial F)/(partial position) = - stepsize/2 thick K
$

$
(partial r_2)/(partial velocity) = M - stepsize/2 (partial F)/(partial velocity) = M - stepsize/2 thick B
$

The final expression of the Jacobian is:

$
J_r = mat(
identity, quad -stepsize/2 thick identity;
 - stepsize/2 thick K, quad M - stepsize/2 thick B)
$

Newton-Raphson to solve $r(state)=0$:

$
mat(
identity, quad -stepsize/2 thick identity;
 - stepsize/2 thick K, quad mass - stepsize/2 thick B)
mat( #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) =
mat(
-position^i + position_(n) + stepsize/2 (velocity_n + velocity^i);
-M(velocity^i - velocity_n) + stepsize/2 (force(position_n, velocity_n)+force(position^i, velocity^i))
)
$

=== Force Linearization

Replacing the linearized force from @force_linearization in the bottom row of @trapezoidal_rule:

$
M thick Delta v = 1/2 Delta t (2 F(#position _n, #velocity _n) + K Delta x + B Delta v)
$ <trapezoidal_rule_linearized>

==== Solve for $Delta v$

Replacing $Delta x$ from  in @trapezoidal_rule_linearized:

$
M thick Delta v = 1/2 Delta t (2 F(#position _n, #velocity _n) + K 1/2 thick Delta t (Delta v + 2 #velocity _n) + B Delta v)
$

Grouping terms in $Delta v$ in LHS:

$
(M- 1/2 Delta t thick B - 1/4 Delta t^2 thick K) Delta v = Delta t thick F(#position _n, #velocity _n) + 1/2 Delta t^2 K #velocity _n
$

=== Force Linearization with Rayleigh Damping

Replacing the linearized force from @force_linearization_rayleigh in the bottom row of @trapezoidal_rule:

$
M thick Delta v =& 1/2 Delta t [2 F(#position _n, #velocity _n) + 2 (-alpha M + beta K)#velocity _n \ &+ K thick Delta x + (B-alpha M + beta K) Delta v]
$ <trapezoidal_rule_linearized_rayleigh>

==== Solve for $Delta v$

Replacing $Delta x$ from in @trapezoidal_rule_linearized:

$
[(1+ 1/2 alpha Delta t) M - 1/2 Delta t B - 1/2 Delta t (1/2 Delta t + beta) K] Delta v \ = Delta t thick F(#position _n, #velocity _n) + Delta t (-alpha M + (beta + 1/2 Delta t)K)#velocity _n
$