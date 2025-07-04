#import "variables.typ": *
#import "box.typ": *
#import "@preview/algorithmic:1.0.0"
#import algorithmic: algorithm

= Differentiable Simulation

== Implicit Function Theorem

Let $f: RR^n times RR^m -> RR^n$ be continuously differentiable. Suppose there is a point $(x_0, theta_0) in RR^n times RR^m$ such that $f(x_0, theta_0) = 0$, and the Jacobian matrix of $f$ with respect to $x$, denoted $(d f)/(d x)(x_0, theta_0) in RR^n$, is invertible.

There exists:
- an open neighborhood $U subset RR^m$ around $theta_0$
- and a continuously differentiable function $x^*:U -> RR^n$
such that:
$
f(x^* (theta), theta) = 0 quad "for all " theta in U
$
and $x^* (theta_0)=x_0.$



The total derivative $(d x^*)/(d theta) in RR^(n times m)$ is given by:


$
(d x^*)/(d theta) = - ((partial f)/(partial x))^(-1) (partial f)/(partial theta)
$

evaluated at $(x^*(theta), theta)$.

#proof()[
$
f(x^* (theta), theta) = 0
<=> &
d/(d theta) f(x^*(theta), theta) = 0 \
<=> & (partial f)/(partial x) (d x^*)/(d theta) + (partial f)/(partial theta) = 0 \
<=> & (partial f)/(partial x) (d x^*)/(d theta) = -(partial f)/(partial theta)
$

Since $(partial f)/(partial x)$ is invertible,

$
  (d x^*)/(d theta) = - ((partial f)/(partial x))^(-1) (partial f)/(partial theta)
$
]

== Gradient-based Optimization

The objective is to optimize a parameter $theta$ of the simulation, such as the Young's modulus $E$, using a gradient-based optimization, so it minimizes a task-specific loss function $l(position^*, theta)$, where $position^* = position^*(theta)$ is a solution of an implicit function $f(state, theta)=0$.

An example of loss function can be $l(position^*) = norm(position^* - position_d)$, where $position_t$ is a desired position.

The implicit function $f$ can be:
- The variation of the action (@action_principle)
- The Euler-Lagrange equation (@euler_lagrange_equation)
- The static equilibrium equation (@static_equation)
- A residual function when a numerical method is applied. For example, after applying the backward Euler method (@section_backward_euler), BDF-2 (@section_bdf2) etc.

To apply a gradient descent, the gradient $(d l)/(d theta)$ is required. Since $l=l(position^*(theta), theta)$ and $position^*(theta)$ is an implicit function, $(d l)/(d theta)$ cannot be computed directly. Chain rule applies:

$
  (d l)/(d theta) = (partial l)/(partial position) (d position^*)/(d theta) + (partial l)/(partial theta) 
$<derivative_loss_function>

The gradient $(d position*)/(d theta)$ is required, the implicit function theorem applies:

$
  (d position^*)/(d theta) = -((partial f)/(partial position))^(-1) (partial f)/(partial theta) 
$

Replacing in @derivative_loss_function:

#result(title:"Implicit differentiation")[
$
(d l)/(d theta) = -(partial l)/(partial position) ((partial f)/(partial position))^(-1) (partial f)/(partial theta) + (partial l)/(partial theta) 
$ <implicit_differentiation>

This is implicit differentiation.
]

#mybox(title:"Adjoint Vector")[

To speed up the computation, the adjoint vector $lambda$ is introduced:

$
  lambda^T = (partial l)/(partial position) ((partial f)/(partial position))^(-1)
$

Right product with $(partial f)/(partial position):$

$
  lambda^T (partial f)/(partial position) = (partial l)/(partial position)
$

Transpose:

$
  ((partial f)/(partial position))^T lambda  = ((partial l)/(partial position))^T
$ <adjoint_linear_system>
This is a linear system to solve:

Once the adjoint vector $lambda$ is found:

$
(d l)/(d theta) = -lambda^T (partial f)/(partial theta) + (partial l)/(partial theta) 
$
]

This gradient can now be used in a gradient-based optimization method, such as a gradient descent:


#algorithm(inset: 0.5em, {
  import algorithmic: *
  let Solve = Call.with("Solve")
  let Compute = Call.with("Compute")
  Procedure(
    "Gradient Descent",
    ($theta_0$, $l$, $f$, $gamma$),
    {
      LineComment(Assign[$theta$][$theta_0$], $theta_0$ + " is the initial guess")
      While(
        "not converged",
        {
          LineComment(Assign[$position^*$][Solve $f(state, theta)=0$], "Newton-Raphson method can be used for example")
          Compute($(partial l)/(partial position)$ + " evaluated at " + $(position^*, theta)$)
          Compute($(partial l)/(partial theta)$ + " evaluated at " + $(position^*, theta)$)
          Compute($lambda^T$ + " from " + $(partial f)/(partial position) lambda^T = (partial l)/(partial position)$)
          Compute($(partial f)/(partial theta)$ + " evaluated at " + $(position^*, theta)$)

          Assign($(d l)/(d theta)$, $-lambda^T (partial f)/(partial theta) + (partial l)/(partial theta) $)

          LineComment(Assign($theta$, $theta - gamma (d l)/(d theta)$), "Move against the gradient")

          Compute("convergence criteria")
        }
        )
    }
  )
})

=== Gradient-based Optimization for Static Equilibrium <optim_static>

The implicit function is @static_equation: $force(position, theta)=0$

To compute $(d l)/(d theta)$ in @implicit_differentiation ($(d l)/(d theta) = -(partial l)/(partial position) ((partial f)/(partial position))^(-1) (partial f)/(partial theta) + (partial l)/(partial theta) $), we need $(partial f)/(partial position)$:

$
  (partial f)/(partial position) = (partial force)/(partial position) = stiffness
$

and $(partial f)/(partial theta)$:

$
  (partial f)/(partial theta) = (partial force)/(partial theta)
$

The adjoint vector is computed by solving the linear system (@adjoint_linear_system):

$
((partial f)/(partial position))^T lambda  = ((partial l)/(partial position))^T <=>
  stiffness^T lambda = ((partial l)/(partial position))^T
$

Finally,
$
(d l)/(d theta) = -lambda^T (partial force)/(partial theta) + (partial l)/(partial theta)
$

If $force$ results from a mapping, such as $force_"in" = force_"out"$, then:

$
  (partial force_"in")/(partial theta) &= (partial jacobianmapping^T force_"out")/(partial theta) \
  &= (partial jacobianmapping^T)/(partial theta) force_"out" + jacobianmapping^T (partial force_"out")/(partial theta)
$

It is unlikely that both $J$ and $force_"out"$ depend on $theta$, so:

$
  (partial force_"in")/(partial theta) = jacobianmapping^T (partial force_"out")/(partial theta)
$