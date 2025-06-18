#import "variables.typ": *
#import "box.typ": *

= Constraints

== Definitions

#definition(title: "Holonomic Constraints")[
Holonomic constraints are relations between position variables:

$
constraint(position, t) = 0
$ <holonomic_definition>
]

#definition(title: "Non-Holonomic Constraints")[
Non-holonomic constraints are relations between velocity variables, or higher time-derivatives of position:

$
constraint(position, velocity, t) = 0
$
]

Solving both the ODE from @ODE and the constraint is a Differential-algebraic system of equations (DAE):

$
cases(
mat(
(d position)/(d t);
mass (d velocity)/(d t)
) &=
mat(
velocity;
force(position, velocity)
),
constraint(position, t) &= 0
)
$

=== Velocity-level equation

We assume that the constraints must be satisfied over time ($constraint(t)=0$ at all times):
$
constraint = 0 <=> dot(constraint) = 0
$

By chain rule:

$
dot(constraint) 
&= (partial constraint)/(partial t) \
&= (partial constraint)/(partial position) (partial position)/(partial t)\
&= constraintmatrix velocity
$ <velocity_level_constraint_equation>

This gives an alternative equation to the position-level constraint equation (@holonomic_definition).

=== Acceleration-level Equation

$
constraint = 0 <=> dot(constraint) = 0 <=> dot.double(constraint) = 0
$

By chain rule:

$
dot.double(constraint) = (partial dot(constraint))/(partial t) = (partial [constraintmatrix velocity])/(partial t) = dot(constraintmatrix)velocity + constraintmatrix acceleration
$

$dot(constraintmatrix)$ can also be written:

$
dot(constraintmatrix) = (partial dot(constraint)) / (partial position)
$

=== Linear Combination

Let's define
$
c(state, t) = alpha_acceleration dot.double(constraint)(state, t) + alpha_velocity dot(constraint)(state, t) + alpha_position constraint(state, t)
$

with $alpha_acceleration$, $alpha_velocity$ and $alpha_position$ constant factors.

Constraint equation:

$
c = 0
$ <linear_combination_constraint_equation>

$
cases(
  alpha_acceleration = 0 \, alpha_velocity = 0 \, alpha_position = 1 => "position-level constraint equation",
  alpha_acceleration = 0 \, alpha_velocity = 1 \, alpha_position = 0 => "velocity constraint equation",
  alpha_acceleration = 1 \, alpha_velocity = 0 \, alpha_position = 0 => "acceleration-level constraint equation",
)
$

== Lagrangian

We want to apply $C$ holonomic constraints $constraint_i$, for $0<i<C-1$. We introduce a Lagrange multiplier $lambda_i$ for each of the constraint.

The Lagrangian (@the_lagrangian) is modified by incorporating Lagrange multipliers $lambda$ on the holonomic constraints equation:

$
lagrangian'(position, velocity, t) = lagrangian(position, velocity, t) + sum_(i=0)^(C-1) lambda_i (t) constraint_i (position, t)
$

Definition:

$
lambda(t) = mat( lambda_0 (t); dots.v; lambda_(C-1)(t))
$

$
constraint(t) = mat( constraint_0 (position, t); dots.v; constraint_(C-1)(position, t))
$

Using the dot product $lambda dot constraint(position, t) = sum_(i=0)^(C-1) lambda_i constraint_i (position, t)$:
$
lagrangian'(position, velocity, t) = lagrangian(position, velocity, t) + lambda dot constraint(position, t)
$


We can apply the Euler-Lagrange equation (@euler_lagrange_equation) on the modified Lagrangian:

$
& (partial lagrangian')/(partial #position) - d/(d t)((partial lagrangian')/(partial #velocity)) = 0 \
=> & (partial lagrangian)/(partial #position) - d/(d t)((partial lagrangian)/(partial #velocity)) +  ((partial constraint)/(partial position))^T lambda = 0
$ <euler_lagrange_equation_with_constraints>

This is the Lagrange's equation of the first kind.

We introduce the Jacobian matrix of the constraints $constraintmatrix$ such that:

$
constraintmatrix(position, t) = (partial constraint(position ,t))/(partial position) \
$

With $n$ degrees of freedom and $m$ constraints, $constraintmatrix in RR^(m times n)$:

$
constraintmatrix(position, t) = mat(
(partial constraint_0)/(partial position_0), dots, (partial constraint_0)/(partial position_(n-1));
dots.v, dots.down, dots.v;
(partial constraint_(m-1))/(partial position_0), dots, (partial constraint_(m-1))/(partial position_(n-1));
)
$

== Static Equilibrium

In statics
$
(partial lagrangian)/(partial position) = force(position)
$

and

$
(partial lagrangian)/(partial velocity) = 0
$

@euler_lagrange_equation_with_constraints becomes:

$
cases(
force(position) + constraintmatrix^T lambda &= 0,
constraint(position) &= 0
)
$

This is a nonlinear set of equations of unknowns $(position, lambda)$ that can be solved using a Newton-Raphson algorithm.

Let's define the residual function $r$ such that:

$
r(position, lambda) = 
mat( force(position) + constraintmatrix^T lambda; constraint(position)) = mat( r_1(position, lambda); r_2(position, lambda))
$

We want to find the root $position_"eq", lambda_"eq"$ of $r$ such that $r(position_"eq", lambda_"eq") = 0$.


We will need to compute the Jacobian $J_r$ of $r$:

$
J_r = mat( 
(partial r_1)/(partial position), (partial r_1)/(partial lambda); 
(partial r_2)/(partial position), (partial r_2)/(partial lambda)
)
$

Let's compute each term:

$
(partial r_1)/(partial position) = stiffness + (partial [constraintmatrix^T lambda])/(partial position)
$

We introduce the geometric stiffness $geometricstiffness_lambda$ such as:

$
geometricstiffness_lambda(position, lambda) = (partial [constraintmatrix^T lambda])/(partial position)
$

Then,

$
(partial r_1)/(partial position) = stiffness + geometricstiffness_lambda
$

$
(partial r_1)/(partial lambda) = constraintmatrix^T
$

$
(partial r_2)/(partial position) = constraintmatrix
$

$
(partial r_2)/(partial lambda) = 0
$

The final expression of the Jacobian $J_r$ is:

$
J_r = mat(
stiffness + geometricstiffness_lambda, constraintmatrix(position)^T;
constraintmatrix(position), 0
)
$

Newton-Raphson iteration:

$
J_r mat( position^(i+1) - position^i; lambda^(i+1) - lambda^i) = -r(position^i, lambda^i)
$

or,

$
mat(
stiffness(position^i) + geometricstiffness_lambda (position^i, lambda^i), constraintmatrix(position^i)^T;
constraintmatrix(position^i), 0
) 
mat( position^(i+1) - position^i; lambda^(i+1) - lambda^i)
= -mat( force(position^i) + constraintmatrix(position^i)^T lambda^i; constraint(position^i))
$

=== 2-steps Solver

We denote $constraintmatrix^i = constraintmatrix(position^i)$

Using the Schur complement (@schur_complement_linear_system_y) on the previous equation, we obtain the reduced equation in $lambda^(i+1)-lambda^i$:

$
-underbrace(constraintmatrix^i (stiffness(position^i) + geometricstiffness_lambda(position^i, lambda^i))^(-1) constraintmatrix^i^T, compliancematrix) (lambda^(i+1)-lambda^i) \
= -constraint(position^i) + constraintmatrix^i (stiffness(position^i) + geometricstiffness_lambda(position^i))^(-1)  (force(position^i) + constraintmatrix^i^T lambda^i)
$

$compliancematrix = constraintmatrix^i (stiffness(position^i) + geometricstiffness_lambda(position^i, lambda^i))^(-1) constraintmatrix^i^T$ is the compliance matrix projected in the constraints space.

From @block_elimination_x, we can deduce:

$
position^(i+1) - position^i = (stiffness(position^i) + geometricstiffness_lambda(position^i))^(-1)  (-force(position^i) - constraintmatrix^i^T lambda^i) - constraintmatrix^i^T (lambda^(i+1)-lambda^i)
$

// In unconstrained static equilibrium, we compute $Delta position_"free" = position^(i+1)_"free" - position^i = -stiffness(position^i)^(-1) force(position^i)$.

// Solving a constrained static equilibrium is equivalent to solving the unconstrained static equilibrium and adding a corrective term:

// $
// position^(i+1) - position^i = Delta position_"free" + Delta position_"cor"
// $

// where

// $
// Delta position_"cor" = -stiffness(position^i)^(-1) constraintmatrix^i^T lambda^i - constraintmatrix^i^T (lambda^(i+1)-lambda^i)
// $

== Equation of Motion

Constraint Newton's second law of motion can be deduced from @euler_lagrange_equation_with_constraints (see also @law_motion_deduced_from_lagrangian):

$
force(position, velocity) - mass (d velocity)/(d t) + constraintmatrix(state)^T lambda = 0
$

By rearranging the terms:

$
mass (d velocity)/(d t) = force(position, velocity) + constraintmatrix(state)^T lambda
$ <second_newton_law_constraint>

=== Position-level Equation of Motion

$
cases(
  (d position)/(d t) = velocity\
  mass (d velocity)/(d t) = force(position, velocity) + constraintmatrix(state)^T lambda\
  constraint(position, t) = 0
)
$

=== Velocity-level Equation of Motion

$
cases(
  (d position)/(d t) = velocity\
  mass (d velocity)/(d t) = force(position, velocity) + constraintmatrix(state)^T lambda\
  constraintmatrix velocity = 0
)
$

== Linear Multistep Methods

Based on @second_newton_law_constraint, we add the constraint term in the residual function of the linear multistep methods (@linear_multistep_method_section):

$
tilde(r)(state, lambda) = tilde(r)(position, velocity, lambda) = \ a_s mat( position; mass velocity)
+ sum_(j=0)^(s-1) a_j mat( position_(n+j); mass velocity_(n+j)) \
- stepsize (b_s 
mat( velocity; force(position, velocity) + constraintmatrix(position, t)^T thick lambda)
+ sum_(j=0)^(s-1) b_j mat( velocity_(n+j); force(position_(n+j), velocity_(n+j)) + constraintmatrix(position_(n+j), t_(n+j))^T thick lambda_(n+j))
)\
= mat( r_1(state, lambda); tilde(r_2)(state, lambda))
$

$tilde(r_2)$ can be related to $r_2$ from @linear_multistep_method_section:
$
tilde(r_2) = r_2(state) - stepsize (b_s constraintmatrix(position, t)^T  lambda + sum_(j=0)^(s-1) b_j constraintmatrix(position_(n+j), t_(n+j))^T lambda_(n+j))
$

We know have more unknowns ($position$, $velocity$, $lambda$) than equations, so we add the constraint @holonomic_definition to $tilde(r)$:

$
tilde(r) = mat(
r_1(state);
tilde(r_2)(state);
constraint(state,t)
)
$

We need to compute the Jacobian $J_tilde(r)$ of $tilde(r)$:

$
J_tilde(r) = mat(
(partial r_1)/(partial position), (partial r_1)/(partial velocity), (partial r_1)/(partial lambda);
(partial tilde(r_2))/(partial position), (partial tilde(r_2))/(partial velocity), (partial tilde(r_2))/(partial lambda);
(partial constraint)/(partial position), (partial constraint)/(partial velocity), (partial constraint)/(partial lambda)
)
$

Let's compute each term:

$
(partial r_1)/(partial position) = a_s identity
$

$
(partial r_1)/(partial velocity) = -stepsize thick b_s thick identity
$

$
(partial r_1)/(partial lambda) = 0
$

$
(partial tilde(r_2))/(partial position) = -stepsize thick b_s (stiffness + (partial [constraintmatrix^T lambda])/(partial position)) = -stepsize thick b_s (stiffness + geometricstiffness_lambda)
$

$
(partial tilde(r_2))/(partial velocity) = a_s mass - stepsize thick b_s thick damping
$

$
(partial tilde(r_2))/(partial lambda) = -stepsize thick b_s constraintmatrix(position)^T 
$

$
(partial constraint)/(partial position) &= constraintmatrix(position)
$

$
(partial constraint)/(partial velocity) = 0
$

$
(partial c)/(partial lambda) = 0
$

The final expression of the Jacobian $J_tilde(r)$ is:

$
J_tilde(r) = 
mat(
a_s identity, -stepsize thick b_s thick identity, 0;

-stepsize thick b_s (stiffness(state) + geometricstiffness_lambda(position, lambda)),
a_s mass - stepsize thick b_s thick damping(state),
-stepsize thick b_s constraintmatrix(position)^T;

constraintmatrix(position), 0, 0
)
$

We denote $constraintmatrix^i = constraintmatrix(position^i)$.

Newton-Raphson to solve $tilde(r)(state)=0$:

$
mat(
a_s identity, -stepsize thick b_s thick identity, 0;

-stepsize thick b_s (stiffness + geometricstiffness_lambda),
a_s mass - stepsize thick b_s thick damping,
-stepsize thick b_s constraintmatrix^i^T;
constraintmatrix^i, 0, 0
)
mat( 
 position ^(i+1) - position ^i; 
 velocity ^(i+1) - velocity ^i;
 lambda^(i+1) - lambda^i) 
 = -tilde(r)(state^i)
$

We define a block division of the matrix such as:

$
mat(
A,B,0;
D,E,F;
G,0,0;
augment: #(hline:1, vline:1)) 
=
mat(
a_s identity, -stepsize thick b_s thick identity, 0;
-stepsize thick b_s (stiffness + geometricstiffness_lambda),
a_s mass - stepsize thick b_s thick damping,
-stepsize thick b_s constraintmatrix^i^T;
constraintmatrix^i, 0, 0;
augment: #(hline:1,vline:1),
)
$

Using the Schur complement (@schur_complement_linear_system_y), we obtain the reduced equation in $Delta velocity$ and $Delta lambda$:

$
(
mat(
E,F;0,0)
- mat(
D;G)
A^(-1)
mat( B, 0)
)
mat(
 velocity ^(i+1) - velocity ^i;
 lambda^(i+1) - lambda^i) 
 = - mat( tilde(r_2)(state^i); tilde(r_3)(state^i))
 + mat( D;G) A^(-1) r_1
$


$
<=>
mat(
E-1/a_s D B,F;-1/a_s G B,0)
mat(
 velocity ^(i+1) - velocity ^i;
 lambda^(i+1) - lambda^i) 
= - mat( tilde(r_2)(state^i); tilde(r_3)(state^i))
+ 1/a_s mat( D;G) r_1(state^i)
$

Finally:
$
mat(
a_s mass - stepsize thick b_s thick damping - stepsize^2 b_s^2/a_s (stiffness + geometricstiffness_lambda),
-stepsize thick b_s constraintmatrix^i^T;
stepsize thick b_s/a_s constraintmatrix^i,0;
augment: #(hline:1,vline:1))
mat(
 velocity ^(i+1) - velocity ^i;
 lambda^(i+1) - lambda^i) 
\ = - mat( tilde(r_2); constraint(state^i))
+ 1/a_s mat( 
-stepsize thick b_s (stiffness + geometricstiffness_lambda); constraintmatrix^ i) r_1(state^i)
$

We use the notations from @definition_Axb_linearsystem and define $A_lambda^i = A^i - stepsize^2 b_s^2/a_s geometricstiffness_lambda$ and 
$
b_lambda^i = b^i + stepsize (b_s constraintmatrix(position, t)^T  lambda + sum_(j=0)^(s-1) b_j constraintmatrix(position_(n+j), t_(n+j))^T lambda_(n+j)) - stepsize b_s / a_s geometricstiffness_lambda  r_1(state^i)
$
It yields:

$
mat(
A_lambda^i,
-stepsize thick b_s constraintmatrix^i^T;
stepsize thick b_s/a_s constraintmatrix^i,0;
)
mat(
 velocity ^(i+1) - velocity ^i;
 lambda^(i+1) - lambda^i) 
=
mat(
b_lambda^i;
constraint(state^i) + 1/a_s constraintmatrix^i r_1(state^i)
)
$ <constraint_linearmultistep_system>

This linear system can be solved directly, or in 2 steps:

=== 2-steps Solver

Using the Schur complement (@schur_complement_linear_system_y), we obtain the reduced equation in $lambda^(i+1) - lambda^i$:


$
b_s^2/a_s stepsize^2 constraintmatrix^i A_lambda^i^(-1) constraintmatrix^i^T (lambda^(i+1) - lambda^i) = -constraint^i - 1/a_s constraintmatrix^i r_1(state^i) - stepsize thick b_s/a_s constraintmatrix^i A_lambda^i^(-1)b_lambda^i
$ <compute_lambda>


The right-hand side is called constraint violation.

From @block_elimination_x, we can deduce:

$
& velocity ^(i+1) - velocity ^i = A_lambda^i^(-1) ( b_lambda^i + stepsize thick b_s constraintmatrix^i^T (lambda^(i+1) - lambda^i)) \
<=>
& velocity^(i+1) - velocity^i = 
underbrace(A_lambda^i^(-1) b_lambda^i, "free motion") + 
underbrace(A_lambda^i^(-1) stepsize thick b_s constraintmatrix^i^T (lambda^(i+1) - lambda^i), "corrective motion")
$

We define the free motion as:

$
Delta velocity_"free" (state^i, lambda^i) = A_lambda^i^(-1) b_lambda^i
$

It can be computed independently of the unknowns $lambda^(i+1)$.

The free motion allows to define a free unconstrained velocity $velocity_"free"^i = velocity^i + Delta velocity_"free"$

$compliancematrix^i = constraintmatrix^i A_lambda^i^(-1) constraintmatrix^i^T$ is the compliance matrix projected in the constraint space.

Assuming a single Newton step, $state^0 = state_n$, $lambda^0 = 0$, and with a backward Euler:

$
cases(
  stepsize^2 constraintmatrix_n A_lambda^(-1) constraintmatrix_n lambda = -constraint(position_n) - constraintmatrix_n stepsize velocity_n - stepsize constraintmatrix Delta velocity_"free",

  velocity_(n+1) - velocity_n = A_lambda^(-1) ( b + stepsize^2 geometricstiffness_lambda velocity_n + stepsize constraintmatrix^T lambda)
)
$

== Constraint Linearization


From @backward_euler_linearized_dv and @holonomic_definition:

$
cases(
  A thick Delta velocity = b + stepsize constraintmatrix(position_n)^T lambda,
  constraint(position_(n+1)) = 0
)
$ 

Taylor series expansion of $constraint$ around $position_n$:

$
constraint(position_(n+1)) = constraint(position_n + Delta position) = constraint(position_n) + constraintmatrix(position_n) Delta position + o(||Delta position||^2)
$

$constraint$ is approximated:

$
constraint(position_n + Delta position) approx constraint(position_n) + constraintmatrix(position_n) Delta position
$

Replacing $Delta position$ by @backwardeuler_deltax:

$
constraint(position_n + Delta position) &approx constraint(position_n) + constraintmatrix(position_n) stepsize (Delta velocity + velocity_n) \
& approx constraint(position_n) + stepsize constraintmatrix(position_n)  Delta velocity + stepsize constraintmatrix(position_n) velocity_n
$

Then,
$
cases(
  A thick Delta velocity = b + stepsize constraintmatrix(position_n)^T lambda,
  constraint(position_n) + stepsize constraintmatrix(position_n)  Delta velocity + stepsize constraintmatrix(position_n) velocity_n = 0
)
$ <position_level_constraint_equation>

In matrix format:

$
mat(
A, -stepsize constraintmatrix(position_n)^T;
stepsize constraintmatrix(position_n), 0
)
mat( Delta velocity; lambda) =
mat( b; -constraint(position_n) - stepsize constraintmatrix(position_n)velocity_n)
$

Using the Schur complement (@schur_complement_linear_system_y):

$
stepsize^2 constraintmatrix(position_n) A^(-1) constraintmatrix(position_n)^T lambda &= -constraint(position_n) - stepsize constraintmatrix(position_n) velocity_n - stepsize constraintmatrix(position_n) A^(-1) b \
&= -constraint(position_n) - stepsize constraintmatrix(position_n) (velocity_n + Delta velocity_"free") \
&approx -constraint(position_n + Delta position_"free") = -constraint(position_"free")
$

Then,

$
Delta velocity = A^(-1)(b + stepsize constraintmatrix(position_n)^T lambda)
$

Force and constraint linearization method is equivalent to a single Newton step, $state^0 = state_n$, $lambda^0 = 0$, and with a backward Euler.


=== Multiple Interacting Objects

If the matrix $A$ is made of multiple blocs:

$
A = mat( A_(00), A_(01); A_(10), A_(11))
$

We can also divide $A^(-1)$:

$
A = mat( A^(-1)_(00), A^(-1)_(01); A^(-1)_(10), A^(-1)_(11))
$

The Jacobian matric can also be divided:

$
constraintmatrix = mat( constraintmatrix_0, constraintmatrix_1) 
= mat( constraintmatrix_0,0) + mat( 0, constraintmatrix_1) 
$

And the compliance matrix projected into the constraint space:

$
compliancematrix = constraintmatrix A^(-1) constraintmatrix^T = &
(mat( constraintmatrix_0,0) + mat( 0,constraintmatrix_1) )
A^(-1)
(mat( constraintmatrix_0^T;0) + mat( 0;constraintmatrix_1^T) ) \
=
&
mat( constraintmatrix_0,0) A^(-1) mat( constraintmatrix_0^T;0)
+
mat( 0,constraintmatrix_1) A^(-1) mat( constraintmatrix_0^T;0)
+ \
& mat( constraintmatrix_0,0) A^(-1) mat( 0;constraintmatrix_1^T)
+
mat( 0,constraintmatrix_1) A^(-1) mat( 0;constraintmatrix_1^T)
$

Let's compute each term:

$
underbrace(mat( constraintmatrix_0,0), in RR^(m times n) )
underbrace(
  underbrace(A^(-1),  in RR^(n times n))
  underbrace(mat( constraintmatrix_0^T;0), in RR^(n times m))
, in RR^(n times m))
=

mat( constraintmatrix_0,0)
mat( A^(-1)_(00) constraintmatrix_0^T;A^(-1)_(10) constraintmatrix_0^T)

= constraintmatrix_0 A^(-1)_(00) constraintmatrix_0^T
$

Similarly

$
mat( 0,constraintmatrix_1) A^(-1) mat( constraintmatrix_0^T;0)
=
mat( 0,constraintmatrix_1)
mat( A^(-1)_(00) constraintmatrix_0^T;A^(-1)_(10) constraintmatrix_0^T)
=
constraintmatrix_1 A^(-1)_(10) constraintmatrix_0^T
$

All together:

$
constraintmatrix A^(-1) constraintmatrix^T =
constraintmatrix_0 A^(-1)_(00) constraintmatrix_0^T +
constraintmatrix_1 A^(-1)_(10) constraintmatrix_0^T +
constraintmatrix_0 A^(-1)_(01) constraintmatrix_1^T +
constraintmatrix_1 A^(-1)_(11) constraintmatrix_1^T
$




=== Relaxation

$relaxation lambda = -constraint$

@position_level_constraint_equation becomes:

$
cases(
  A thick Delta velocity = b + stepsize constraintmatrix(position_n)^T lambda,
  constraint(position_n) + stepsize constraintmatrix(position_n)  Delta velocity + stepsize constraintmatrix(position_n) velocity_n = -relaxation lambda
)
$

$
mat(
A, -stepsize constraintmatrix(position_n)^T;
stepsize constraintmatrix(position_n), relaxation
)
mat( Delta velocity; lambda) =
mat( b; -constraint(position_n) - stepsize constraintmatrix(position_n)velocity_n)
$

Using the Schur complement (@schur_complement_linear_system_y):

$
(relaxation +stepsize^2 constraintmatrix(position_n) A^(-1) constraintmatrix(position_n)^T) lambda &= -constraint(position_n) - stepsize constraintmatrix(position_n) velocity_n - stepsize constraintmatrix(position_n) A^(-1) b \
&= -constraint(position_n) - stepsize constraintmatrix(position_n) (velocity_n + Delta velocity_"free") \
&approx -constraint(position_n + Delta position_"free") = -constraint(position_"free")
$


== Models

=== Fixation

$
constraint(position) = position - position_0
$

$
constraintmatrix(position) = identity
$

$
geometricstiffness = (partial [constraintmatrix^T lambda])/(partial position) = 0
$

=== Bilteral

$
constraint(position_1, position_2) = position_2 - position_1 - (position_2_0 - position_1_0)
$

$
constraintmatrix(position_1, position_2)
& = mat( (partial constraint)/(partial position_1), (partial constraint)/(partial position_2)) \
& = mat( -identity, identity)
$

$
geometricstiffness = (partial [constraintmatrix^T lambda])/(partial position) = 0
$

$
constraint_"free"
$