#import "@preview/arkheion:0.1.0": arkheion, arkheion-appendices
#import "@preview/dashy-todo:0.0.2": todo

#show: arkheion.with(
  title: "Physics Simulation Cookbook",
  authors: (
  (
      name: "Alexandre Bilger", 
      email: "alexandre.bilger@inria.fr", 
      affiliation: "DEFROST/SED"),
  ),
  abstract: [Summary on physics simulation],
  keywords: ("Physics simulation",),
  date: datetime.today().display("[day] [month repr:long] [year]"),
)

#set math.equation(numbering: "(1)")

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

#outline(indent: auto)

#show heading.where(depth: 1): body => {    
  pagebreak(weak: true)
  body
}

#import "variables.typ": * 
#include "lagrangianmechanics.typ"

= Newton's Second Law of Motion

== Deduction from the Lagrangian <law_motion_deduced_from_lagrangian>

We apply the Euler-Lagrange equation on the Lagrangian defined in @the_lagrangian. It requires to compute $(partial lagrangian)/(partial position)$ and $d/(d t)((partial lagrangian)/(partial velocity))$:

$
(partial lagrangian)/(partial position) = (partial T) / (partial position) - (partial V)/(partial position)
$

The derivative of the kinetic energy $T$ with respect to the position is null as it does not depend on the position (only the rest position). Therefore,

$
(partial lagrangian)/(partial position) = - (partial V)/(partial position) = force(position, velocity)
$

The term $d/(d t)((partial lagrangian)/(partial velocity))$ is the time derivative of the momentum (@momentum).

The final form of the second Newton's law deduced from the Lagrangian is:

$
force(position, velocity) - (d momentum)/(d t) = 0
$

If we rearrange the terms:

$
(d momentum)/(d t) = force(position, velocity) 
$

If the potential energy does not depend on the velocity:

$
mass acceleration = force(position, velocity)
$ <second_newton_law>

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




#include "static.typ"

= Dynamic

$
mass(x) thick dot(v) = P(t) - F(x, v) + H^T lambda
$

- $mass : RR^n arrow.r.long.bar RR^(n times n) $: mass matrix
- $x in RR^n$: vector of degrees of freedom (e.g. position)
- $v$: vector of velocities
- $F$: internal forces
- $P$: external forces
- $t$: current time
- $H^T lambda in RR^n$: constraint forces


Short version:
$
mass(state) thick (d velocity)/(d t) = force(position, velocity)
$

or:
$
mass(state) thick acceleration = force(position, velocity)
$ <short_dynamic>

#include "spring.typ"

= Numerical Integration

== Definition

For any function $y=y(t)$, we call 

$
y_n=y(t_n)
$ <sequence>

with 

$
t_n = t_0 + n thick Delta t
$

Numerical methods for ordinary ordinary differential equation approximate solutions to initial value problems of the form:

$
y'=f(t,y), quad y(t_0) = y_0
$ <initial_value_problem>

== Linear Multistep Method

$
y_(n+s) + a_(s-1) y_(n+s-1) + a_(s-2) y_(n+s-2) + dots + a_0 y_n = \ stepsize ( b_s f(t_(n+s), y_(n+s)) + b_(s-1) f(t_(n+s-1), y_(n+s-1)) + dots + b_0 f(t_n, y_n))
$

or

$
sum_(j=0)^s a_j y_(n+j) = stepsize sum_(j=0)^s b_j f(t_(n+j),y_(n+j))
$ <linear_multistep_method>

If $b_s = 0$, the method is called "explicit": it is possible to compute $y_(n+s)$ directly.
If $b_s != 0$, the method is called "implicit": the value of $y_(n+s)$ depends on the value of $f(t_(n+s), y_(n+s))$.

== Backward Differentiation Formula

Given a set of $s+1$ nodes ${t_n, t_(n+1), ..., t_(n+s)}$, the Lagrange basis for polynomials of degree $<= s$ for those notes is the set of polynomials ${l_0(t), l_1(t), ..., l_s (t)}$:

$
l_j (t) = product_(0<=m<=s\ m!=j) (t-t_(n+m))/(t_(n+j)-t_(n+m))
$

The Lagrange interpolating polynomial for those nodes through the corresponding values ${y_(n), y_(n+1), ..., y_(n+s)}$ is the linear combination:

$
L(t) = sum_(j=0)^s y_(n+j) l_j (t)
$

=== Derivative:

$
L'(t) = sum_(j=0)^s y_(n+j) l'_j (t)
$

$
l'_j (t) = sum_(i = 0 \ i != j)^s [ 1 / (t_(n+j) - t_(n+i)) product_(m = 0 \ m != (i,j)) (t - t_(n+m)) / (t_(n+j) - t_(n+m))]
$

=== Lagrange polynomials to solve an ODE
We approximate $y'$ by $L'$ in @initial_value_problem:

$
sum_(j=0)^s y_(n+j) l'_j (t) = f(t,y)
$

We want to find $y(t_(n+s))$, therefore

$
sum_(j=0)^s y_(n+j) l'_j (t_(n+s)) = f(t_(n+s),y_(n+s))
$


$
sum_(j=0)^s y_(n+j) (sum_(i = 0 \ i != j)^s [ 1 / (t_(n+j) - t_(n+i)) product_(m = 0 \ m != (i,j)) (t_(n+s) - t_(n+m)) / (t_(n+j) - t_(n+m))]) = f(t_(n+s),y_(n+s))
$

=== Constant Step Size

$
t_(n+j) = t_n + j thick stepsize
$

So, for all $i,j$

$
t_(n+j) - t_(n+i) 
&= t_n + j thick stepsize - (t_n + i thick stepsize)\
&= (j-i) stepsize
$

$
sum_(j=0)^s y_(n+j) (sum_(i = 0 \ i != j)^s [ 1 / (j - i) product_(m = 0 \ m != (i,j)) (s - m) / (j - m)]) = stepsize thick f(t_(n+s),y_(n+s))
$

==== BDF1

For $s=1$:

$j=0$:
$
l'_0 (t_(n+1)) = sum_(i = 0 \ i != 0)^1 [ 1 / (0 - i) product_(m = 0 \ m != (i,0)) (1 - m) / (- m)] =  1 / (-1) product_(m = 0 \ m !=(1,0)) (1 - m) / (- m) = -1
$

$j=1$:

$
l'_1 (t_(n+1)) = sum_(i = 0 \ i != 1)^1 [ 1 / (1 - i) product_(m = 0 \ m != (i,1)) (1 - m) / (1 - m)] =  1 / (1) product_(m = 0 \ m != (0,1)) (1 - m) / (1 - m) = 1
$

Finally, for $s = 1$:

$
y_(n+1) - y_(n) = stepsize thick f(t_(n+1), y_(n+1))
$

==== BDF2

For $s=2$:

$j = 0$:
$
l'_0 (t_(n+2)) & = sum_(i = 0 \ i != 0)^2 [ 1 / ( - i) product_(m = 0 \ m != (i,0)) (2 - m) / (- m)] \ 
&= ( 1 / ( - 1) product_(m = 0 \ m != (1,0)) (2 - m) / (- m)) + ( 1 / ( - 2) product_(m = 0 \ m != (2,0)) (2 - m) / (- m)) \ 
&= -1/2 ((2-1)/(-1)) = 1/2
$

$j=1$:

$
l'_1 (t_(n+2)) & = sum_(i = 0 \ i != 1)^2 [ 1 / (1 - i) product_(m = 0 \ m != (i,1)) (2 - m) / (1 - m)] \
&= ( 1 / (1) product_(m = 0 \ m != (0,1)) (2 - m) / (1 - m)) + ( 1 / (1 - 2) product_(m = 0 \ m != (2,1)) (2 - m) / (1 - m)) \
&= -2
$

$j=2$:

$
l'_2 (t_(n+2)) & = sum_(i = 0 \ i != 2)^2 [ 1 / (2 - i) product_(m = 0 \ m != (i,2)) (2 - m) / (2 - m)] \
&= ( 1 / (2 ) product_(m = 0 \ m != (0,2)) (2 - m) / (2 - m)) + ( 1 / (2 - 1) product_(m = 0 \ m != (1,2)) (2 - m) / (2 - m))\
&= 3/2
$

Finally, for $s = 1$:

$
3/2 y_(n+2) -2 y_(n+1) + 1/2 y_(n) = stepsize thick f(t_(n+2), y_(n+2))
$

which can be written:

$
y_(n+2) - 4/3 y_(n+1) + 1/3 y_(n) = 2/3 stepsize thick f(t_(n+2), y_(n+2))
$


== Numerical Integration of Newton's Second Law of Motion

The second Newton's law (@ODE) is a first-order ordinary differential equation of the form of @initial_value_problem where:

$
y(t) = mat(delim:"[", position(t); velocity(t))
$ <definition_y>

$
f(t,y) = mat(delim: "[", velocity(t); mass^(-1) force(position, velocity))
$ <definition_f>

In case of Rayleigh damping (@F_rayleigh):

$
f(t,y) = mat(delim: "[", velocity(t); mass^(-1) (force(position, velocity) + (-alpha mass + beta stiffness(position, velocity)) velocity))
$



== Newton-Raphson

For implicit methods, @linear_multistep_method is nonlinear. Newton-Raphson algorithm can be used to solve it.

=== Nonlinear function


Find the root $x_r$ of a nonlinear function $r:RR^k arrow RR^k$ such that:

$
r(x_r) = 0
$ <nonlinear_equation>

Let's define $x^0$ the first estimate of the solution of this equation, called the initial guess.

$
Delta x^0 = x_r - x_0
$

Taylor series expansion of $r$ around $x^0$

$
r(x_r)&= r(x_0 + Delta x_0) \
&=r(x_0) + lr((partial r)/(partial x)|)_(x^0) Delta x^0 + O(norm(Delta x^0)^2)
$

If we neglect second-order terms and higher:

$
r(x_r) approx r(x_0) + lr((partial r)/(partial x)|)_(x^0) Delta x^0
$

If we use this approximation to solve the equation, it leads to:

$
r(x^0) + lr((partial r)/(partial x)|)_(x^0) Delta x^0 = 0
$

This is a linear system to solve for the unknown $Delta x^0$:

$
lr((partial r)/(partial x)|)_(x^0) Delta x^0 = -r(x^0)
$

Once $Delta x^0$ is found, $x^1$ can be deduced:

$
x^1 = Delta x^0 + x^0
$

The process is repeated as

$
lr((partial r)/(partial x)|)_(x^i) (x^(i+1)-x^i) = -r(x^i)
$

#include "ExplicitTimeIntegration/explicitTimeIntegration.typ"

= Implicit Time Integration

== Backward Differentiation Formula

A family of implicit methods for the numerical integration of ordinary differential equations

$
sum_(k=0)^s #acceleration _k y_(n+k) = Delta t thick beta thick f(t_(n+s), y_(n+s))
$ <BDF>

- For any $n >= 0$, $t_(n) = t_0 + n thick Delta t$
- $y_n$ denotes the state at time $t_n$
- $#acceleration _k$ and $beta$ are coefficients that depend on the order $s$ of the method
- $f$ the function of the ODE

Coefficients @suli2003introduction:

#align(center)[
#table(
  columns: 9,
  table.header[*Order*][$#acceleration _0$][$#acceleration _1$][$#acceleration _2$][$#acceleration _3$][$#acceleration _4$][$#acceleration _5$][$#acceleration _6$][$beta$],
  [1], [-1],[1],[],[],[],[],[],[1],
  [2], [1],[-4],[3],[],[],[],[],[2],
  [3], [-2],[9],[-18],[11],[],[],[],[6],
  [4], [3],[-16],[36],[-48],[25],[],[],[12],
  [5], [-12],[75],[-200],[300],[-300],[137],[],[60],
  [6], [10],[-72],[225],[-400],[450],[-360],[147],[60],
)
]



#include "bdf1.typ"
#include "trapezoidal.typ"
#include "bdf2.typ"
#include "newmark.typ"

== Implicit Linear Multistep Methods <linear_multistep_method_section>

Based on @linear_multistep_method, let's define the residual function as:

$
r(x) = a_s x + sum_(j=0)^(s-1) a_j y_(n+j) - stepsize (b_s f(t_(n+s),x) + sum_(j=0)^(s-1) b_j f(t_(n+j),y_(n+j)))
$

To find the next unknown state $y_(n+s)$, we need to compute the root $x_r$ of $r$ such that $r(x_r) = 0$. Newton-Raphson algorithm can be applied.

In the case of the Newton's second law (@ODE),

$
r(state) = r(position, velocity) = \ a_s mat(delim:"[", position; mass velocity)
+ sum_(j=0)^(s-1) a_j mat(delim:"[", position_(n+j); mass velocity_(n+j)) 
- stepsize (b_s 
mat(delim:"[", velocity; force(position, velocity))
+ sum_(j=0)^(s-1) b_j mat(delim:"[", velocity_(n+j); force(position_(n+j), velocity_(n+j)))
)\
= mat(delim:"[", r_1(state); r_2(state))
$

We will need to compute the Jacobian $J_r = (partial r)/(partial x) = mat(delim:"[",
(partial r_1)/(partial #position), (partial r_1)/(partial #velocity);
(partial r_2)/(partial #position), (partial r_2)/(partial #velocity);
)$ of $r$. Let's compute each term:

$
(partial r_1)/(partial position) = a_s identity
$

$
(partial r_1)/(partial velocity) = -stepsize thick b_s thick identity
$

$
(partial r_2)/(partial position) = -stepsize thick b_s thick (partial force)/(partial position) = -stepsize thick b_s thick stiffness
$

$
(partial r_2)/(partial velocity) = a_s mass - stepsize thick b_s thick (partial force)/(partial velocity) = a_s mass - stepsize thick b_s thick damping
$

The final expression of the Jacobian is:

$
J_r = mat(delim:"[",
a_s identity, quad -stepsize thick b_s thick identity;
 -stepsize thick b_s thick stiffness, quad a_s mass - stepsize thick b_s thick damping)
$

We define $stiffness^i = stiffness(position^i, velocity^i)$ and $damping^i = damping(position^i, velocity^i)$.

Newton-Raphson to solve $r(state)=0$:

$
mat(delim:"[",
a_s identity, quad -stepsize thick b_s thick identity;
 -stepsize thick b_s thick stiffness^i, quad a_s mass - stepsize thick b_s thick damping^i)
 mat(delim:"[", #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) = -r(state^i)
$

=== Solve for #velocity

Using the Schur complement (see @schur_complement_linear_system_y), we obtain the reduced equation in $velocity ^(i+1) - velocity ^i$:

$
(a_s mass - stepsize thick b_s thick damping^i - stepsize^2 b_s^2 / a_s stiffness^i)(velocity ^(i+1) - velocity ^i) = -r_2(position^i, velocity^i) - stepsize b_s/a_s stiffness^i r_1(position^i, velocity^i)
$ <detailed_linearmultistep_velocity_linearsystem>


@detailed_linearmultistep_velocity_linearsystem is a linear system of the form

$
A^i x^i=b^i
$ <linear_system>

where

$
cases(
  A^i = a_s mass - stepsize thick b_s thick damping^i - stepsize^2 b_s^2 / a_s stiffness^i,
  x^i = velocity ^(i+1) - velocity ^i,
  b^i = -r_2(position^i, velocity^i) - stepsize b_s/a_s stiffness^i r_1(position^i, velocity^i)
)
$ <definition_Axb_linearsystem>

From @block_elimination_x, we can deduce $position^(i+1) - position^i$:

$
position^(i+1) - position^i &= 1/a_s (-r_1(state^i) + stepsize thick b_s (velocity ^(i+1) - velocity ^i))
$



=== Rayleigh Damping

$
r(state) = r(position, velocity) = \ a_s mat(delim:"[", position; mass velocity)
+ sum_(j=0)^(s-1) a_j mat(delim:"[", position_(n+j); mass velocity_(n+j)) 
\ - stepsize (b_s 
mat(delim:"[", velocity; force(position, velocity) + (-alpha mass + beta stiffness(position, velocity))velocity)
+\ sum_(j=0)^(s-1) b_j mat(delim:"[", velocity_(n+j); force(position_(n+j), velocity_(n+j)) + (-alpha mass + beta stiffness(position_(n+j), velocity_(n+j))) velocity)
)\
= mat(delim:"[", r_1(state); r_2(state))
$

Only the second line is modified, so only the derivatives of $r_2$ must be computed:

$
(partial r_2)/(partial position) = -stepsize thick b_s thick (partial force)/(partial position) = -stepsize thick b_s thick stiffness
$

$
(partial r_2)/(partial velocity) &= a_s mass - stepsize thick b_s thick ((partial force)/(partial velocity) - alpha mass + beta stiffness) \ &= a_s mass - stepsize thick b_s thick (damping - alpha mass +beta stiffness) \
&= (a_s + stepsize thick b_s alpha) mass -stepsize thick b_s (damping + beta stiffness)
$

The final expression of the Jacobian is:

$
J_r = mat(delim:"[",
a_s identity, quad -stepsize thick b_s thick identity;
 -stepsize thick b_s thick stiffness, quad (a_s + stepsize thick b_s alpha) mass -stepsize thick b_s (damping + beta stiffness))
$

Newton-Raphson to solve $r(state)=0$:

$
mat(delim:"[",
a_s identity, quad -stepsize thick b_s thick identity;
 -stepsize thick b_s thick stiffness, quad (a_s + stepsize thick b_s alpha) mass -stepsize thick b_s (damping + beta stiffness))
 mat(delim:"[", #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) = -r(state^i)
$

==== Solve for #velocity

Using the Schur complement (see @schur_complement_linear_system_y), we obtain the reduced equation in $velocity ^(i+1) - velocity ^i$:

$
((a_s + stepsize thick b_s alpha) mass - stepsize thick b_s thick damping^i  -stepsize thick b_s (beta + stepsize b_s / a_s) stiffness^i)(velocity ^(i+1) - velocity ^i) =\ -r_2(position^i, velocity^i) - stepsize b_s/a_s stiffness^i r_1(position^i, velocity^i)
$

From @block_elimination_x, we can deduce $position^(i+1) - position^i$:

$
position^(i+1) - position^i &= 1/a_s (-r_1(state^i) + stepsize thick b_s (velocity ^(i+1) - velocity ^i))
$

#include "constraints.typ"

#include "maths.typ"

= Other Resources

@li2024physics


#bibliography("refs.bib")