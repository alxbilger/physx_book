#import "../variables.typ": *
#import "../box.typ": *

== 1-step BDF (Backward Euler) <section_backward_euler>

Considering an IVP (@eq_mass_matrix_ode) of the form $odemassmatrix(t,y) thick y'=f(t,y)$ with $y(t_0) = y_0$, the time derivative can be approximated using a backward first-order finite differences:

$
  y'(t+stepsize) approx 1/stepsize (y(t+stepsize) - y(t))
$

Substituting this approximation into the IVP yields:

$
  mat(delim: #("{", none),
    1/stepsize odemassmatrix(t + stepsize,y) thick [y(t+stepsize) - y(t)] &= f(t + stepsize, y(t+stepsize));
    y(t_0) &= y_0
  )
$

Under the discrete sequence notation from @sequence, we write:

$
  1/stepsize odemassmatrix(t_(n+1),y_(n+1)) thick [y_(n+1)-y_n]=f(t_(n+1),y_(n+1))
$
where $y_0$ is known.

#todo[
We observe that the method enters into the category of linear multistep methods (@linear_multistep_method) with:

$
cases(s &= 1,
a_1 &= 1,
a_0 &= -1,
b_1 &= 1,
b_0 &= 0
)
$
]

This is a non-linear set of equations that can be solved with the Newton-Raphson algorithm (@section_newton_raphson).

#mybox(title: "Residual Function")[
Let's define the residual function $r$ such that:

$
r_(n+1)(z) = 1/stepsize odemassmatrix(t_(n+1),z) thick [z-y_n] - f(t_(n+1),z)
$

With this definition, $y_(n+1)$ is the solution of $r_(n+1)(z)=0$.
]

The application of the Newton-Raphson algorithm requires the computation of the Jacobian of the residual function (@linear_system_in_newton_raphson):

$
  (partial r_(n+1))/(partial z) = 
  identity - (partial f)/(partial z)
$

Substituting this Jacobian into @linear_system_in_newton_raphson, we obtain:

$
  (identity - lr((partial f)/(partial x)|)_(x^i)) (x^(i+1)-x^i) = -r_(n+1)(x^i)
$




























We apply this equation on $y$ from @definition_y and $f$ from @definition_f:

$
mat(
position_(n+1) - position_n;
velocity_(n+1) - velocity_n
)
=
stepsize
mat(
velocity_(n+1);
massmatrix^(-1) force(position_(n+1), velocity_(n+1)))
$

We multiply the second line by $massmatrix$ to get rid of the inverse:
$
mat(
position_(n+1) - position_n;
massmatrix ( velocity_(n+1) - velocity_n)
)
=
stepsize
mat(
velocity_(n+1);
force(position_(n+1), velocity_(n+1)))
$ <backward_euler>



This is a non-linear set of equations: $force$ is non-linear with respect to the unknown $#position _(n+1)$ and $#velocity _(n+1)$.

#mybox(title: "Residual Function")[
Let's define the residual function $r$ such that:

$
r(state) = r(position, velocity) = mat( position - position _n - stepsize thick velocity ; massmatrix(velocity -velocity _n) - stepsize thick force(state))
= mat( r_1(state); r_2(state))
$<h_backward_euler>
]

Based on @backward_euler, we want to find the root $state _(n+1) = mat(position _(n+1); velocity _(n+1))$ of $r$ such that 

$
r(#state _(n+1))=0
$

#mybox(title: "Computation of the Jacobian")[
We will need to compute the Jacobian $J_r$ of $r$:

$
J_r = (partial r)/(partial x) = mat(
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
(partial r_2)/(partial #velocity) = massmatrix - stepsize thick (partial force)/(partial #velocity) = massmatrix - stepsize thick #damping
$ <backward_euler_derivative_r_2_velocity>

The final expression of the Jacobian is:
$
J_r = (partial r)/(partial state) = 
mat(
identity, quad -stepsize thick identity;
-stepsize thick stiffness, quad massmatrix - stepsize thick damping;
)
$
]

Let's define $position^0$ and $velocity^0$ the first estimate of the solution of this equation, called the initial guess.


Newton-Raphson to solve $r(state)=0$:

$
J_r (#state ^i) (#state ^(i+1) - #state ^i) = -r(#state ^i)
$

$
mat(
identity, -stepsize thick identity;
-stepsize thick #stiffness (#state^i), massmatrix - stepsize thick #damping (#state^i);
)
mat( #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) 
=
mat( -position^i + position_n + stepsize thick velocity^i ; -massmatrix(velocity^i - velocity_n) + stepsize thick force(state^i))
$

=== Solve for $velocity$

Using the Schur complement (see @schur_complement_linear_system_y), we obtain the reduced equation in $velocity ^(i+1) - velocity ^i$:

$
(massmatrix - stepsize thick #damping (#state^i) - (-stepsize thick #stiffness (#state^i)) (-stepsize thick identity)) (velocity ^(i+1) - velocity ^i) =\ -massmatrix(velocity^i - velocity_n) + stepsize thick force(state^i) - (-stepsize thick #stiffness (#state^i))(-position^i + position_n + stepsize thick velocity^i)
$

Cleaning:
$
(massmatrix - stepsize thick #damping (#state^i) + stepsize^2 thick #stiffness (#state^i)) (velocity ^(i+1) - velocity ^i) =\ -massmatrix(velocity^i - velocity_n) + stepsize thick force(state^i) + stepsize thick #stiffness (#state^i)(-position^i + position_n + stepsize thick velocity^i)
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
((-stepsize thick #stiffness (#state^i))-(massmatrix - stepsize thick #damping (#state^i)) (-1/stepsize I)) (position^(i+1) - position ^i) =\ -massmatrix(velocity^i - velocity_n) + stepsize thick force(state^i) - (massmatrix - stepsize thick #damping (#state^i))(-1/stepsize) (-position^i + position_n + stepsize thick velocity^i)
$

Cleaning:

$
(1/stepsize massmatrix - damping(state^i) -stepsize thick #stiffness (#state^i)) (position^(i+1) - position ^i) =\ -massmatrix(velocity^i - velocity_n) + stepsize thick force(state^i) + 1/stepsize (massmatrix - stepsize thick #damping (#state^i)) (-position^i + position_n + stepsize thick velocity^i)
$

=== Rayleigh Damping

$force_"Rayleigh"$ (@F_rayleigh) is added to the sum of forces in @backward_euler:

$
massmatrix (#velocity _(n+1) - #velocity _n) &= stepsize thick (force(#position _(n+1), #velocity _(n+1)) + force_"Rayleigh")\
&= stepsize thick (force(#position _(n+1), #velocity _(n+1)) + (-alpha massmatrix + beta stiffness) #velocity _(n+1))
$ <backward_euler_rayleigh>

#mybox(title: "Residual Function")[
We define the residual function $r$ such that:

$
r(#state) = mat( #position - #position _n - stepsize thick #velocity ; massmatrix(#velocity -#velocity _n) - stepsize thick (force(#state) + (-alpha massmatrix + beta stiffness) velocity _(n+1)))
= mat( r_1(#state); r_2(#state))
$<r_backward_euler_rayleigh>
]

The nonlinear equation to solve is $r(position,velocity) = 0$

#let backward_euler_rayleigh_dr2dposition = $- stepsize thick stiffness$
#let backward_euler_rayleigh_dr2dvelocity = $(1+alpha stepsize) massmatrix - stepsize damping - beta stepsize thick stiffness$

#mybox(title: "Computation of the Jacobian")[
The derivatives of $r_1$ with respect to $position$ and $velocity$ can be found respectively in @backward_euler_derivative_r1_position and @backward_euler_derivative_r1_velocity.

$
(partial r_2) / (partial position) = - stepsize (partial force) / (partial position) = #backward_euler_rayleigh_dr2dposition
$

$
(partial r_2) / (partial velocity) 
&= massmatrix - stepsize ((partial force) / (partial velocity) -alpha massmatrix + beta stiffness) \
&= #backward_euler_rayleigh_dr2dvelocity
$

The Jacobian of $r$:

$
J_r = (partial r)/(partial state) =
mat(
I, quad -stepsize I;
#backward_euler_rayleigh_dr2dposition, quad #backward_euler_rayleigh_dr2dvelocity)
$
]

Newton-Raphson to solve $r(state)=0$:

$
mat(
I, quad -stepsize I;
#backward_euler_rayleigh_dr2dposition, quad #backward_euler_rayleigh_dr2dvelocity)
mat( #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) 
=\
mat( -position^i + position_n + stepsize thick velocity^i ; -massmatrix(velocity^i - velocity_n) + stepsize thick (force(state^i) + (-alpha massmatrix + beta stiffness) #velocity _(n+1)))
$

==== Solve for #velocity

Using the Schur complement (see @schur_complement_linear_system_y), we obtain the reduced equation in $velocity ^(i+1) - velocity ^i$:

$
((#backward_euler_rayleigh_dr2dvelocity) - (#backward_euler_rayleigh_dr2dposition)(-stepsize)) (velocity ^(i+1) - velocity ^i) = \
massmatrix(velocity^i - velocity_n) + stepsize thick (force(state^i) + (-alpha massmatrix + beta stiffness) #velocity _(n+1))
- (#backward_euler_rayleigh_dr2dposition)(-position^i + position_n + stepsize thick velocity^i)
$

Cleaning:

$
lr(((1+alpha stepsize) massmatrix - stepsize damping - stepsize (beta + stepsize) thick stiffness), size: #200%)
(velocity ^(i+1) - velocity ^i) = \
massmatrix(velocity^i - velocity_n) + stepsize thick (force(state^i) + (-alpha massmatrix + beta stiffness) #velocity _(n+1) + stiffness(-position^i + position_n + stepsize thick velocity^i))
$

=== Force Linearization <section_backward_euler_force_linearization>

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
massmatrix thick Delta velocity = stepsize ( force(#position _n, #velocity _n) + stiffness(position_n, velocity_n) Delta position + damping(position_n, velocity_n) Delta velocity)
$ <backward_euler_linearized>

==== Solving for $Delta velocity$

Replacing $Delta position$ from @backwardeuler_deltax in @backward_euler_linearized:

$
massmatrix thick Delta velocity = stepsize ( force(#position _n, #velocity _n) + stiffness(position_n, velocity_n) thick stepsize thick (Delta velocity + #velocity _n) + damping(position_n, velocity_n) Delta velocity)
$

Grouping terms in $Delta velocity$ in LHS:

$
(massmatrix - stepsize thick damping(position_n, velocity_n) - stepsize^2 thick stiffness(position_n, velocity_n)) Delta velocity = stepsize thick force(position _n, velocity _n) + stepsize^2 stiffness(position_n, velocity_n) velocity _n
$ <backward_euler_linearized_dv>

Defining $A= massmatrix - stepsize thick damping(position_n, velocity_n) - stepsize^2 thick stiffness(position_n, velocity_n)$ and $b=stepsize thick force(#position _n, #velocity _n) + stepsize^2 stiffness(position_n, velocity_n) #velocity _n$, we have a linear system to solve:

$
A thick Delta velocity = b
$

Then we use @backwardeuler_deltax to deduce $Delta position$.

==== Solving for $Delta position$

Replacing $Delta velocity$ from @backwardeuler_deltav in @backward_euler_linearized:

$
massmatrix thick (1/(stepsize) Delta position - #velocity _n) = stepsize ( force(#position _n, #velocity _n) + stiffness(position_n, velocity_n) Delta position + damping(position_n, velocity_n) (1/(stepsize) Delta position - #velocity _n))
$

Grouping terms in $Delta position$ in LHS:

$
(1/(stepsize) massmatrix - damping(position_n, velocity_n) - stepsize stiffness(position_n, velocity_n)) Delta position = stepsize thick force(#position _n, #velocity _n) + (massmatrix - stepsize thick damping(position_n, velocity_n)) #velocity _n
$ <backward_euler_linearized_dx>

Defining $A=1/(stepsize) massmatrix - damping(position_n, velocity_n) - stepsize stiffness(position_n, velocity_n)$ and $b=stepsize thick force(#position _n, #velocity _n) + (massmatrix - stepsize thick damping(position_n, velocity_n)) #velocity _n$, we have a linear system to solve:

$
A thick Delta position = b
$

Then we use @backwardeuler_deltav to deduce $Delta velocity$.

=== Force Linearization with Rayleigh Damping

$
F(#position _(n+1), #velocity _(n+1)) + F_("Rayleigh",n+1) approx & F(#position _n, #velocity _n) + F_("Rayleigh",n) \ &+ (underbrace((partial F)/(partial x),stiffness) + underbrace((partial F_"Rayleigh")/(partial x),0)) Delta x \ &+ (underbrace((partial F)/(partial v),B) + underbrace((partial F_"Rayleigh")/(partial v), -alpha massmatrix + beta stiffness)) Delta v
$ 

$
F(#position _(n+1), #velocity _(n+1)) + F_("Rayleigh",n+1)  approx & F(#position _n, #velocity _n) + (-alpha massmatrix + beta stiffness)#velocity _n \ &+ stiffness thick Delta x + (B-alpha massmatrix + beta stiffness) Delta v
$ <force_linearization_rayleigh>

@backward_euler becomes:

$
massmatrix thick Delta v = stepsize ( F(#position _n, #velocity _n) + (-alpha massmatrix + beta stiffness)#velocity _n + stiffness thick Delta x + (B-alpha massmatrix + beta stiffness) Delta v)
$ <backward_euler_linearized_rayleigh>

==== Solving for $Delta v$

Replacing $Delta x$ from @backwardeuler_deltax in @backward_euler_linearized_rayleigh:

$
massmatrix thick Delta v = & stepsize ( F(#position _n, #velocity _n) + (-alpha massmatrix + beta stiffness)#velocity _n + stiffness thick stepsize (Delta v + #velocity _n) + (B-alpha massmatrix + beta stiffness) Delta v)
$

Grouping terms in $Delta v$ in LHS:

$
((1+alpha stepsize )massmatrix - stepsize B - stepsize (stepsize + beta) stiffness) Delta v =& stepsize thick F(#position _n, #velocity _n) \ &+ stepsize thick (-alpha massmatrix + (beta + stepsize) stiffness)#velocity _n
$

==== Solving for $Delta x$

Replacing $Delta v$ from @backwardeuler_deltav in @backward_euler_linearized_rayleigh:

$
massmatrix thick (1/(stepsize) Delta x - #velocity _n) = \ stepsize ( F(#position _n, #velocity _n) + (-alpha massmatrix + beta stiffness)#velocity _n + stiffness thick Delta x + (B-alpha massmatrix + beta stiffness) (1/(stepsize) Delta x - #velocity _n))
$

Grouping terms in $Delta x$ in LHS:

$
(massmatrix thick (1/(stepsize)) - stepsize thick stiffness thick - (B-alpha massmatrix + beta stiffness)) Delta x = \ stepsize ( F(#position _n, #velocity _n) + (-alpha massmatrix + beta stiffness)#velocity _n - (B-alpha massmatrix + beta stiffness) #velocity _n) + massmatrix #velocity _n
$

$
(1/(stepsize)(1/(stepsize) + alpha)massmatrix - 1/(stepsize)B - (1+beta/(stepsize))) Delta x = F(#position _n, #velocity _n) + stepsize thick massmatrix #velocity _n - B #velocity _n
$

=== Optimization Form

In @h_backward_euler:

$
  r_1 = 0 <=> velocity = (position - position_n) / stepsize
$

Substituting into $r_2=0$:

$
  r_2(position, velocity)=0 & <=> 
  massmatrix(velocity - velocity_n) - stepsize force(position, velocity) = 0 \
  & <=> massmatrix((position - position_n) / stepsize - velocity_n) - stepsize force(position, (position - position_n) / stepsize) = 0 \
  & <=> massmatrix (position - position_n - stepsize velocity_n)/stepsize^2 - force(position, (position - position_n) / stepsize) = 0 \
  & <=> massmatrix (position - position_n - stepsize velocity_n)/stepsize^2 + (partial potentialenergy)/(partial position)(position, (position - position_n) / stepsize) = 0
$

Let's define $h(position) = massmatrix (position - position_n - stepsize velocity_n)/stepsize^2 + (partial potentialenergy)/(partial position)(position, (position - position_n) / stepsize)$.

Solving $h(position)=0$ is equivalent to minimize $norm(h(position))$. However, minimizing $norm(h(position))$ using the Newton-Raphson method requires the second derivative of $h$ (see @newton_raphson_optimization), hence the forces. The standard approach only requires the first derivative.

To rely only on the first derivative, $h$ is integrated to find an energy function $E = E(position)$, such that $h=(partial E)/(partial position)$.

$
  E(position) = 1/(2 stepsize^2) (position - position_n - stepsize velocity_n)^T massmatrix (position - position_n - stepsize velocity_n) + potentialenergy
$
