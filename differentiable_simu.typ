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

== Gradient-based Optimization for Static Equilibrium



The objective is to optimize a parameter $theta$ of the simulation, such as the Young's modulus $E$, using a gradient-based optimization, so it minimizes a loss function $l(position^*, theta)$, where $position^* = position^*(theta)$ is the solution of $force(position, theta) = 0$.

An example of loss function can be $l(position^*) = norm(position^* - position_d)$, where $position_t$ is a desired position.

To apply a gradient descent, the gradient $(d l)/(d theta)$ is required. Since $l=l(position^*(theta), theta)$ and $position^*(theta)$ is an implicit function, $(d l)/(d theta)$ cannot be computed directly. Chain rule applies:

$
  (d l)/(d theta) &= (partial l)/(partial position) (d position^*)/(d theta) + (partial l)/(partial theta) 
$

The gradient $(d position*)/(d E)$ is required,  the implicit function theorem applies:

$
  (d position^*)/(d theta) = &-((partial force)/(partial position))^(-1) (partial force)/(partial theta) \
  =& - stiffness^(-1) (partial force)/(partial theta)
$

Finally,

$
  (d l)/(d theta) = -(partial l)/(partial position) stiffness^(-1) (partial force)/(partial theta) + (partial l)/(partial theta) 
$

#algorithm(inset: 0.5em, {
  import algorithmic: *
  let Solve = Call.with("Solve")
  let Compute = Call.with("Compute")
  Procedure(
    "Gradient Descent",
    ($theta_0$, $l$, $gamma$),
    {
      LineComment(Assign[$theta$][$theta_0$], $theta_0$ + " is the initial guess")
      While(
        "not converged",
        {
          LineComment(Assign[$position^*$][Solve $force(position)=0$], "Newton-Raphson method can be used for example")
          Compute($(partial l)/(partial position)$ + " evaluated at " + $(position^*, theta)$)
          Compute($(partial l)/(partial theta)$ + " evaluated at " + $(position^*, theta)$)
          Compute($(partial force)/(partial position)$ + " evaluated at " + $(position^*, theta)$)
          Compute($(partial force)/(partial theta)$ + " evaluated at " + $(position^*, theta)$)

          LineComment(Assign($(d position^*)/(d theta)$, $-((partial force)/(partial position))^(-1) (partial force)/(partial theta)$), "From the implicit function theorem")

          Assign($(d l)/(d theta)$, $(partial l)/(partial position) (d position^*)/(d theta) + (partial l)/(partial theta)$)

          LineComment(Assign($theta$, $theta - gamma (d l)/(d theta)$), "Move against the gradient")

          Compute("convergence criteria")
        }
        )
    }
  )
})