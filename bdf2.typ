#import "variables.typ": * 
#import "box.typ": *

== 2-step BDF

In @initial_value_problem, the time derivative can be approximated such as:

$
y'_(n+2) approx (3 y_(n+2) - 4 y_(n+1) + y_n)/(2 stepsize)
$

@initial_value_problem becomes:

$
& (3 y_(n+2) - 4 y_(n+1) + y_n)/(2 stepsize) &&= f(t_(n+2),y_(n+2)) \
<=>& y_(n+2) - 4/3 y_(n+1) + 1/3 y_n &&= 2/3 stepsize thick f(t_(n+2),y_(n+2))
$

We observe that the method enters into the category of linear multistep methods (@linear_multistep_method) with:

$
cases(s &= 2,
a_2 &= 1,
a_1 &= -4/3,
a_0 &= 1/3,
b_2 &= 2/3,
b_1 &= 0,
b_0 &= 0
)
$

We apply this equation on $y$ from @definition_y and $f$ from @definition_f:

$
mat(
position_(n+2) - 4/3 position_(n+1) + 1/3 position_n;
velocity_(n+2) - 4/3 velocity_(n+1) + 1/3 velocity_n
) = 
2/3 stepsize
mat(
velocity_(n+2);
mass^(-1) force(position_(n+2), velocity_(n+2))
)
$

We multiply the second line by $mass$ to get rid of the inverse:

$
mat(
position_(n+2) - 4/3 position_(n+1) + 1/3 position_n;
mass(velocity_(n+2) - 4/3 velocity_(n+1) + 1/3 velocity_n)
) = 
2/3 stepsize
mat(
velocity_(n+2);
force(position_(n+2), velocity_(n+2))
)
$ <bdf2>

#mybox(title: "Residual Function")[
Definition of the residual function $r$:

$
r(position, velocity) =
mat(
position- 4/3 position_(n+1) + 1/3 position_(n) - 2/3 stepsize thick velocity;
mass (velocity- 4/3 velocity_(n+1) + 1/3 velocity_(n)) - 2/3 Delta t thick force(position, velocity)
)
= mat( r_1(state);r_2(state))
$
]

Based on @bdf2, we want to find the root $state_(n+1) = mat( position_(n+1); velocity_(n+1))$ of $r$ such that $r(state_(n+1))=0$.

#mybox(title: "Computation of the Jacobian")[
We will need to compute the Jacobian $J_r = (partial r)/(partial x) = mat(
(partial r_1)/(partial #position), (partial r_1)/(partial #velocity);
(partial r_2)/(partial #position), (partial r_2)/(partial #velocity);
)$ of $r$. Let's compute each term:

$
(partial r_1)/(partial position) = identity
$

$
(partial r_1)/(partial velocity) = - 2/3 stepsize thick identity
$

$
(partial r_2)/(partial position) = - 2/3 stepsize (partial force)/(partial position) = - 2/3 stepsize thick stiffness
$

$
(partial r_2)/(partial velocity) = mass - 2/3 stepsize (partial F)/(partial velocity) = mass - 2/3 stepsize thick damping
$

The final expression of the Jacobian is:

$
J_r = mat(
identity, quad - 2/3 stepsize thick identity;
- 2/3 stepsize thick stiffness, quad mass - 2/3 stepsize thick damping)
$
]

Newton-Raphson to solve $r(state)=0$:

$
mat(
identity, quad - 2/3 stepsize thick identity;
- 2/3 stepsize thick stiffness, quad mass - 2/3 stepsize thick damping)
mat( #position ^(i+1) - #position ^i; #velocity ^(i+1) - #velocity ^i) =
mat(
-r_1(state^i);
-r_2(state^i)
)
$