#import "variables.typ": *

== 1-step BDF (Backward Euler)

In @initial_value_problem, the time derivative can be approximated using the backward first-order finite differences:

$
y'_(n+1) approx (y_(n+1)-y_n)/stepsize <=> 
d/(d t) mat(delim: "[", position(t+stepsize); velocity(t+stepsize)) approx  1/stepsize (mat(delim:"[", position (t+ Delta t); velocity (t + stepsize)) - mat(delim:"[", position (t); velocity (t)) )
$

@initial_value_problem becomes:

$
&(y_(n+1)-y_n)/stepsize &&= f(t+stepsize,y_(n+1)) \
<=>& y_(n+1)-y_n &&= stepsize thick f(t+stepsize,y_(n+1))
$

We observe that the method enters into the category of linear multistep methods (@linear_multistep_method) with:

$
cases(s &= 1,
a_1 &= 1,
a_0 &= -1,
b_1 &= 1,
b_0 &= 0
)
$

We apply this equation on $y$ from @definition_y and $f$ from @definition_f:

$
mat(delim:"[",
position_(n+1) - position_n;
velocity_(n+1) - velocity_n
)
=
stepsize
mat(delim:"[",
velocity_(n+1);
mass^(-1) force(position_(n+1), velocity_(n+1)))
$

We multiply the second line by $mass$ to get rid of the inverse:
$
mat(delim:"[",
position_(n+1) - position_n;
mass ( velocity_(n+1) - velocity_n)
)
=
stepsize
mat(delim:"[",
velocity_(n+1);
force(position_(n+1), velocity_(n+1)))
$ <backward_euler>



This is a non-linear set of equations: $force$ is non-linear with respect to the unknown $#position _(n+1)$ and $#velocity _(n+1)$.

Let's define the residual function $r$ such that:

$
r(state) = r(position, velocity) = mat(delim:"[", position - position _n - stepsize thick velocity ; mass(velocity -velocity _n) - stepsize thick F(state))
= mat(delim:"[", r_1(state); r_2(state))
$<h_backward_euler>

Based on @backward_euler, we want to find the root $#state _(n+1) = mat(delim:"[",#position _(n+1); #velocity _(n+1))$ of $r$ such that 

$
r(#state _(n+1))=0
$

We will need to compute the Jacobian $J_r$ of $r$:

$
J_r = (partial r)/(partial x) = mat(delim:"[",
(partial r_1)/(partial #position), (partial r_1)/(partial #velocity);
(partial r_2)/(partial #position), (partial r_2)/(partial #velocity);
)
$

Let's compute each term:

$
(partial r_1)/(partial #position) = I
$ <backward_euler_derivative_r1_position>

$
(partial r_1)/(partial #velocity) = -stepsize thick I
$ <backward_euler_derivative_r1_velocity>

$
(partial r_2)/(partial #position) = -stepsize thick (partial force)/(partial #position) = - stepsize thick #stiffness
$ <backward_euler_derivative_r_2_position>

$
(partial r_2)/(partial #velocity) = mass - stepsize thick (partial force)/(partial #velocity) = mass - stepsize thick #damping
$ <backward_euler_derivative_r_2_velocity>

The final expression of the Jacobian is:
$
J_r = (partial r)/(partial state) = 
mat(delim:"[",
identity, quad -stepsize thick identity;
-stepsize thick #stiffness, quad mass - stepsize thick #damping;
)
$

Let's define $position^0$ and $velocity^0$ the first estimate of the solution of this equation, called the initial guess.


Newton-Raphson to solve $r(state)=0$:

$
J_r (#state ^i) (#state ^(i+1) - #state ^i) = -r(#state ^i)
$


$
mat(delim:"[",
identity, quad -stepsize thick identity;
-stepsize thick #stiffness (#state^i), quad mass - stepsize thick #damping (#state^i);
)
mat(delim:"[", #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) 
=
mat(delim:"[", -position^i + position_n + stepsize thick velocity^i ; -mass(velocity^i - velocity_n) + stepsize thick force(state^i))
$

=== Solve for #velocity

Using the Schur complement (see @schur_complement_linear_system_y), we obtain the reduced equation in $velocity ^(i+1) - velocity ^i$:

$
(mass - stepsize thick #damping (#state^i) - (-stepsize thick #stiffness (#state^i)) (-stepsize thick identity)) (velocity ^(i+1) - velocity ^i) =\ -mass(velocity^i - velocity_n) + stepsize thick force(state^i) - (-stepsize thick #stiffness (#state^i))(-position^i + position_n + stepsize thick velocity^i)
$

Cleaning:
$
(mass - stepsize thick #damping (#state^i) + stepsize^2 thick #stiffness (#state^i)) (velocity ^(i+1) - velocity ^i) =\ -mass(velocity^i - velocity_n) + stepsize thick force(state^i) + stepsize thick #stiffness (#state^i)(-position^i + position_n + stepsize thick velocity^i)
$

From @block_elimination_x, we can deduce $position^(i+1) - position^i$:

$
position^(i+1) - position^i &= -position^i + position_n + stepsize thick velocity^i - (-stepsize thick identity) (velocity ^(i+1) - velocity ^i)\
&= -position^i + position_n + stepsize thick velocity^i + stepsize thick (velocity ^(i+1) - velocity ^i)\
&= -position^i + position_n + stepsize thick velocity ^(i+1)
$

Then

$
position^(i+1) = position_n + stepsize thick velocity ^(i+1)
$

=== Solve for #position

Using the Schur complement (see @schur_complement_linear_system_x), we obtain the reduced equation in $position^(i+1) - position ^i$:


$
((-stepsize thick #stiffness (#state^i))-(M - stepsize thick #damping (#state^i)) (-1/stepsize I)) (position^(i+1) - position ^i) =\ -M(velocity^i - velocity_n) + stepsize thick force(state^i) - (M - stepsize thick #damping (#state^i))(-1/stepsize) (-position^i + position_n + stepsize thick velocity^i)
$

Cleaning:

$
(1/stepsize M - damping(state^i) -stepsize thick #stiffness (#state^i)) (position^(i+1) - position ^i) =\ -M(velocity^i - velocity_n) + stepsize thick force(state^i) + 1/stepsize (M - stepsize thick #damping (#state^i)) (-position^i + position_n + stepsize thick velocity^i)
$

=== Rayleigh Damping

$F_"Rayleigh"$ (@F_rayleigh) is added to the sum of forces in @backward_euler:

$
M (#velocity _(n+1) - #velocity _n) &= stepsize thick (F(#position _(n+1), #velocity _(n+1)) + F_"Rayleigh")\
&= stepsize thick (F(#position _(n+1), #velocity _(n+1)) + (-alpha M + beta K) #velocity _(n+1))
$ <backward_euler_rayleigh>

We define the residual function $r$ such that:

$
r(#state) = mat(delim:"[", #position - #position _n - stepsize thick #velocity ; mass(#velocity -#velocity _n) - stepsize thick (force(#state) + (-alpha mass + beta stiffness) velocity _(n+1)))
= mat(delim:"[", r_1(#state); r_2(#state))
$<r_backward_euler_rayleigh>

The nonlinear equation to solve is $r(position,velocity) = 0$

The derivatives of $r_1$ with respect to $position$ and $velocity$ can be found respectively in @backward_euler_derivative_r1_position and @backward_euler_derivative_r1_velocity.

#let backward_euler_rayleigh_dr2dposition = $- stepsize thick stiffness$

$
(partial r_2) / (partial position) = - stepsize (partial force) / (partial position) = #backward_euler_rayleigh_dr2dposition
$

#let backward_euler_rayleigh_dr2dvelocity = $(1+alpha stepsize) mass - stepsize damping - beta stepsize thick stiffness$

$
(partial r_2) / (partial velocity) 
&= mass - stepsize ((partial force) / (partial velocity) -alpha mass + beta stiffness) \
&= #backward_euler_rayleigh_dr2dvelocity
$

The Jacobian of $r$:

$
J_r = (partial r)/(partial state) =
mat(delim:"[",
I, quad -stepsize I;
#backward_euler_rayleigh_dr2dposition, quad #backward_euler_rayleigh_dr2dvelocity)
$

Newton-Raphson to solve $r(state)=0$:

$
mat(delim:"[",
I, quad -stepsize I;
#backward_euler_rayleigh_dr2dposition, quad #backward_euler_rayleigh_dr2dvelocity)
mat(delim:"[", #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) 
=\
mat(delim:"[", -position^i + position_n + stepsize thick velocity^i ; -mass(velocity^i - velocity_n) + stepsize thick (force(state^i) + (-alpha mass + beta stiffness) #velocity _(n+1)))
$

==== Solve for #velocity

Using the Schur complement (see @schur_complement_linear_system_y), we obtain the reduced equation in $velocity ^(i+1) - velocity ^i$:

$
((#backward_euler_rayleigh_dr2dvelocity) - (#backward_euler_rayleigh_dr2dposition)(-stepsize)) (velocity ^(i+1) - velocity ^i) = \
mass(velocity^i - velocity_n) + stepsize thick (force(state^i) + (-alpha mass + beta stiffness) #velocity _(n+1))
- (#backward_euler_rayleigh_dr2dposition)(-position^i + position_n + stepsize thick velocity^i)
$

Cleaning:

$
lr(((1+alpha stepsize) mass - stepsize damping - stepsize (beta + stepsize) thick stiffness), size: #200%)
(velocity ^(i+1) - velocity ^i) = \
mass(velocity^i - velocity_n) + stepsize thick (force(state^i) + (-alpha mass + beta stiffness) #velocity _(n+1) + stiffness(-position^i + position_n + stepsize thick velocity^i))
$

=== Force Linearization

@backward_euler is a nonlinear equation. Instead of solving it iteratively, we use an approximation of the expression of forces.

Let's define:

$
Delta position = #position _(n+1) - #position _n
$

$
Delta velocity = #velocity _(n+1) - #velocity _n
$

From @backward_euler, we can deduce:
$
Delta position = stepsize thick #velocity _(n+1) = stepsize (Delta velocity + #velocity _n)
$ <backwardeuler_deltax>
$
Delta velocity = 1/(stepsize) (#position _(n+1) - #position _n) - #velocity _n = 1/(stepsize) Delta position - #velocity _n
$ <backwardeuler_deltav>

Taylor series expansion of $F$ around $(#position _n, #velocity _n)$:

$
force(#position _(n+1), #velocity _(n+1)) &= force(#position _n + Delta position, #velocity _n + Delta velocity) \
&= force(#position _n, #velocity _n) + (partial force)/(partial position)(position_n, velocity_n) Delta position + (partial force)/(partial velocity)(position_n, velocity_n) Delta velocity + o(||Delta position||^ 2,  ||Delta velocity||^ 2)
$

$force$ is approximated:
$
force(#position _(n+1), #velocity _(n+1)) approx force(position_n, velocity_n) 
+ underbrace((partial force)/(partial position)(position_n, velocity_n),stiffness(position_n, velocity_n)) Delta position 
+ underbrace((partial force)/(partial velocity)(position_n, velocity_n), damping(position_n, velocity_n)) Delta velocity
$ <force_linearization>

Second line of @backward_euler becomes:

$
mass thick Delta velocity = stepsize ( force(#position _n, #velocity _n) + stiffness(position_n, velocity_n) Delta position + damping(position_n, velocity_n) Delta velocity)
$ <backward_euler_linearized>

==== Solving for $Delta velocity$

Replacing $Delta position$ from @backwardeuler_deltax in @backward_euler_linearized:

$
mass thick Delta velocity = stepsize ( force(#position _n, #velocity _n) + stiffness(position_n, velocity_n) thick stepsize thick (Delta velocity + #velocity _n) + damping(position_n, velocity_n) Delta velocity)
$

Grouping terms in $Delta velocity$ in LHS:

$
(mass - stepsize thick damping(position_n, velocity_n) - stepsize^2 thick stiffness(position_n, velocity_n)) Delta velocity = stepsize thick force(position _n, velocity _n) + stepsize^2 stiffness(position_n, velocity_n) velocity _n
$ <backward_euler_linearized_dv>

Defining $A= mass - stepsize thick damping(position_n, velocity_n) - stepsize^2 thick stiffness(position_n, velocity_n)$ and $b=stepsize thick force(#position _n, #velocity _n) + stepsize^2 stiffness(position_n, velocity_n) #velocity _n$, we have a linear system to solve:

$
A thick Delta velocity = b
$

Then we use @backwardeuler_deltax to deduce $Delta position$.

==== Solving for $Delta position$

Replacing $Delta velocity$ from @backwardeuler_deltav in @backward_euler_linearized:

$
mass thick (1/(stepsize) Delta position - #velocity _n) = stepsize ( force(#position _n, #velocity _n) + stiffness(position_n, velocity_n) Delta position + damping(position_n, velocity_n) (1/(stepsize) Delta position - #velocity _n))
$

Grouping terms in $Delta position$ in LHS:

$
(1/(stepsize) mass - damping(position_n, velocity_n) - stepsize stiffness(position_n, velocity_n)) Delta position = stepsize thick force(#position _n, #velocity _n) + (mass - stepsize thick damping(position_n, velocity_n)) #velocity _n
$ <backward_euler_linearized_dx>

Defining $A=1/(stepsize) mass - damping(position_n, velocity_n) - stepsize stiffness(position_n, velocity_n)$ and $b=stepsize thick force(#position _n, #velocity _n) + (mass - stepsize thick damping(position_n, velocity_n)) #velocity _n$, we have a linear system to solve:

$
A thick Delta position = b
$

Then we use @backwardeuler_deltav to deduce $Delta velocity$.

=== Force Linearization with Rayleigh Damping

$
F(#position _(n+1), #velocity _(n+1)) + F_("Rayleigh",n+1) approx & F(#position _n, #velocity _n) + F_("Rayleigh",n) \ &+ (underbrace((partial F)/(partial x),K) + underbrace((partial F_"Rayleigh")/(partial x),0)) Delta x \ &+ (underbrace((partial F)/(partial v),B) + underbrace((partial F_"Rayleigh")/(partial v), -alpha M + beta K)) Delta v
$ 

$
F(#position _(n+1), #velocity _(n+1)) + F_("Rayleigh",n+1)  approx & F(#position _n, #velocity _n) + (-alpha M + beta K)#velocity _n \ &+ K thick Delta x + (B-alpha M + beta K) Delta v
$ <force_linearization_rayleigh>

@backward_euler becomes:

$
M thick Delta v = stepsize ( F(#position _n, #velocity _n) + (-alpha M + beta K)#velocity _n + K thick Delta x + (B-alpha M + beta K) Delta v)
$ <backward_euler_linearized_rayleigh>

==== Solving for $Delta v$

Replacing $Delta x$ from @backwardeuler_deltax in @backward_euler_linearized_rayleigh:

$
M thick Delta v = & stepsize ( F(#position _n, #velocity _n) + (-alpha M + beta K)#velocity _n + K thick stepsize (Delta v + #velocity _n) + (B-alpha M + beta K) Delta v)
$

Grouping terms in $Delta v$ in LHS:

$
((1+alpha stepsize )M - stepsize B - stepsize (stepsize + beta) K) Delta v =& stepsize thick F(#position _n, #velocity _n) \ &+ stepsize thick (-alpha M + (beta + stepsize) K)#velocity _n
$

==== Solving for $Delta x$

Replacing $Delta v$ from @backwardeuler_deltav in @backward_euler_linearized_rayleigh:

$
M thick (1/(stepsize) Delta x - #velocity _n) = \ stepsize ( F(#position _n, #velocity _n) + (-alpha M + beta K)#velocity _n + K thick Delta x + (B-alpha M + beta K) (1/(stepsize) Delta x - #velocity _n))
$

Grouping terms in $Delta x$ in LHS:

$
(M thick (1/(stepsize)) - stepsize thick K thick - (B-alpha M + beta K)) Delta x = \ stepsize ( F(#position _n, #velocity _n) + (-alpha M + beta K)#velocity _n - (B-alpha M + beta K) #velocity _n) + M #velocity _n
$

$
(1/(stepsize)(1/(stepsize) + alpha)M - 1/(stepsize)B - (1+beta/(stepsize))) Delta x = F(#position _n, #velocity _n) + stepsize thick M #velocity _n - B #velocity _n
$
