#import "variables.typ": *
#import "box.typ": *

= Implicit Time Integration <section_implicit_time_integration>

== Backward Differentiation Formula

A family of implicit methods for the numerical integration of ordinary differential equations

$
sum_(k=0)^s acceleration _k y_(n+k) = Delta t thick beta thick f(t_(n+s), y_(n+s))
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
r(state) = r(position, velocity) = \ a_s mat( position; massmatrix velocity)
+ sum_(j=0)^(s-1) a_j mat( position_(n+j); massmatrix velocity_(n+j)) 
- stepsize (b_s 
mat( velocity; force(position, velocity))
+ sum_(j=0)^(s-1) b_j mat( velocity_(n+j); force(position_(n+j), velocity_(n+j)))
)\
= mat( r_1(state); r_2(state))
$

#mybox(title: "Computation of the Jacobian")[

We will need to compute the Jacobian $J_r = (partial r)/(partial x) = mat(
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
(partial r_2)/(partial velocity) = a_s massmatrix - stepsize thick b_s thick (partial force)/(partial velocity) = a_s massmatrix - stepsize thick b_s thick damping
$

The final expression of the Jacobian is:

$
J_r = mat(
a_s identity, quad -stepsize thick b_s thick identity;
 -stepsize thick b_s thick stiffness, quad a_s massmatrix - stepsize thick b_s thick damping)
$]

We define $stiffness^i = stiffness(position^i, velocity^i)$ and $damping^i = damping(position^i, velocity^i)$.

Newton-Raphson to solve $r(state)=0$:

$
mat(
a_s identity, quad -stepsize thick b_s thick identity;
 -stepsize thick b_s thick stiffness^i, quad a_s massmatrix - stepsize thick b_s thick damping^i)
 mat( #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) = -r(state^i)
$

=== Solve for #velocity

Using the Schur complement (see @schur_complement_linear_system_y), we obtain the reduced equation in $velocity ^(i+1) - velocity ^i$:

$
(a_s massmatrix - stepsize thick b_s thick damping^i - stepsize^2 b_s^2 / a_s stiffness^i)(velocity ^(i+1) - velocity ^i) = -r_2(position^i, velocity^i) - stepsize b_s/a_s stiffness^i r_1(position^i, velocity^i)
$ <detailed_linearmultistep_velocity_linearsystem>


@detailed_linearmultistep_velocity_linearsystem is a linear system of the form

$
A^i x^i=b^i
$ <linear_system>

where

$
cases(
  A^i = a_s massmatrix - stepsize thick b_s thick damping^i - stepsize^2 b_s^2 / a_s stiffness^i,
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
r(state) = r(position, velocity) = \ a_s mat( position; massmatrix velocity)
+ sum_(j=0)^(s-1) a_j mat( position_(n+j); massmatrix velocity_(n+j)) 
\ - stepsize (b_s 
mat( velocity; force(position, velocity) + (-alpha massmatrix + beta stiffness(position, velocity))velocity)
+\ sum_(j=0)^(s-1) b_j mat( velocity_(n+j); force(position_(n+j), velocity_(n+j)) + (-alpha massmatrix + beta stiffness(position_(n+j), velocity_(n+j))) velocity)
)\
= mat( r_1(state); r_2(state))
$

Only the second line is modified, so only the derivatives of $r_2$ must be computed:

$
(partial r_2)/(partial position) = -stepsize thick b_s thick (partial force)/(partial position) = -stepsize thick b_s thick stiffness
$

$
(partial r_2)/(partial velocity) &= a_s massmatrix - stepsize thick b_s thick ((partial force)/(partial velocity) - alpha massmatrix + beta stiffness) \ &= a_s massmatrix - stepsize thick b_s thick (damping - alpha massmatrix +beta stiffness) \
&= (a_s + stepsize thick b_s alpha) massmatrix -stepsize thick b_s (damping + beta stiffness)
$

The final expression of the Jacobian is:

$
J_r = mat(
a_s identity, quad -stepsize thick b_s thick identity;
 -stepsize thick b_s thick stiffness, quad (a_s + stepsize thick b_s alpha) massmatrix -stepsize thick b_s (damping + beta stiffness))
$

Newton-Raphson to solve $r(state)=0$:

$
mat(
a_s identity, quad -stepsize thick b_s thick identity;
 -stepsize thick b_s thick stiffness, quad (a_s + stepsize thick b_s alpha) massmatrix -stepsize thick b_s (damping + beta stiffness))
 mat( #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) = -r(state^i)
$

==== Solve for #velocity

Using the Schur complement (see @schur_complement_linear_system_y), we obtain the reduced equation in $velocity ^(i+1) - velocity ^i$:

$
((a_s + stepsize thick b_s alpha) massmatrix - stepsize thick b_s thick damping^i  -stepsize thick b_s (beta + stepsize b_s / a_s) stiffness^i)(velocity ^(i+1) - velocity ^i) =\ -r_2(position^i, velocity^i) - stepsize b_s/a_s stiffness^i r_1(position^i, velocity^i)
$

From @block_elimination_x, we can deduce $position^(i+1) - position^i$:

$
position^(i+1) - position^i &= 1/a_s (-r_1(state^i) + stepsize thick b_s (velocity ^(i+1) - velocity ^i))
$