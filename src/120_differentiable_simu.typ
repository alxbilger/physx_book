#import "variables.typ": *
#import "box.typ": *
#import "@preview/algorithmic:1.0.0"
#import algorithmic: algorithm

= Differentiable Simulation <section_differentiable_simulation>

== Introduction

// Many scientific and engineering challenges involve solving *inverse problems*—that is, we observe the outcome ($state_"desired"$) and must infer the underlying cause (the optimal parameter $theta$). This requires calculating how a small change in $theta$ affects $x$, which means computing derivatives: $(partial state)/(partial theta)$.

// Differentiable simulation provides the mathematical framework and computational tools to overcome this black-box limitation. It transforms a standard, non-differentiable physical simulation into a *differentiable computation graph*. By doing so, we can propagate gradients backward through the entire system, allowing us to optimize parameters that govern the simulation model itself.

#definition(title:"Forward problem")[
  A Forward Problem is a predictive computational task that aims to determine the expected state or outcome of a physical system, given a complete set of known initial conditions, boundary conditions, and applied forcing functions.

  In simple terms: If you know the cause (the inputs), the forward problem predicts the effect (the output).
]

#definition(title:"Inverse problem")[

  An Inverse Problem is a computational task that aims to determine the unknown or underlying parameters, inputs, or forces required to produce an observed state, output, or measurement. It fundamentally reverses the process of modeling: rather than predicting an effect from known causes, it deduces the cause from the measured effect.

  In simple terms: If you know the outcome (the measurements), the inverse problem tries to figure out what initial conditions or parameters must have been responsible for that outcome.
]

#mybox(title:"Inverse problem as an optimization")[
  An inverse problem can be treated as an optimization where a parameter set $theta$ is optimized so it minimizes the difference between a model prediction and the actual measured data.
]

#definition(title:"Differentiable Simulation")[
  A differentiable simulation is a computational model that allows its output state ($state$) to be treated as a continuous, differentiable function of its input parameters ($theta$). Its defining feature is the ability to compute the derivative $(partial state)/(partial theta)$
  efficiently, enabling its use within optimization frameworks that rely on gradient information.
]


The capability to efficiently calculate $(partial state)/(partial theta)$ unlocks several crucial scientific domains:

-  *Parameter Estimation (Inverse Problems):* This is perhaps the most common use case. Instead of guessing the optimal material property or boundary condition, we define a loss function $L(x) = ||x - x_"desired"||$. We then optimize $theta$ using gradient descent to find the set of parameters that make the simulation output match our measurements.
- *Optimal Control:* Finding the control sequence (e.g., actuator forces over time) that minimizes a cost function while ensuring the simulated system dynamics are satisfied.
- *Physics-Informed Machine Learning (PINNs):* Integrating physical laws directly into the loss function of an artificial neural network, allowing ML models to predict solutions that adhere to established physical constraints.
- *Model Reduction and Sensitivity Analysis:* Quantifying how sensitive a simulation output is to variations in its input parameters, helping researchers identify which inputs are most critical for model stability or accuracy.

#mybox(title:"Challenge")[
  The core challenge in applying gradient descent to physical simulations stems from the fact that many physical laws and numerical schemes are defined implicitly. For instance, solving a system of differential equations at each time step often involves finding a state $state_{n+1}$ such that $f(state_(n+1), state_n, theta) = 0$. We cannot simply write $state_(n+1) = g(state_n, theta)$, as the relationship is implicit.

  To handle this mathematically, we rely on the implicit function theorem.
]

== Implicit Function Theorem

#property(title:"Implicit Function Theorem")[
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
]

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

The objective is to optimize a parameter $theta$ of the simulation, such as the Young's modulus $E$, using a gradient-based optimization, so it minimizes a task-specific loss function $loss(position^*, theta)$, where $position^* = position^*(theta)$ is a solution of an implicit function $f(state, theta)=0$.

An example of loss function can be $loss(position^*) = norm(position^* - position_d)$, where $position_d$ is a desired position.

The implicit function $f$ can be:
- The variation of the action (@action_principle)
- The Euler-Lagrange equation (@euler_lagrange_equation)
- The static equilibrium equation (@static_equation)
- A residual function when a numerical method is applied. For example, after applying the backward Euler method (@section_backward_euler), BDF-2 (@section_bdf2) etc.

To apply a gradient descent, the gradient $(d loss)/(d theta)$ is required. Since $loss=loss(position^*(theta), theta)$ and $position^*(theta)$ is an implicit function, $(d loss)/(d theta)$ cannot be computed directly. Chain rule applies:

$
  (d loss)/(d theta) = (partial loss)/(partial position) (d position^*)/(d theta) + (partial loss)/(partial theta) 
$<derivative_loss_function>

The gradient $(d position*)/(d theta)$ is required, the implicit function theorem applies:

$
  (d position^*)/(d theta) = -((partial f)/(partial position))^(-1) (partial f)/(partial theta) 
$

Replacing in @derivative_loss_function:

#result(title:"Implicit differentiation")[
$
(d loss)/(d theta) = -(partial loss)/(partial position) ((partial f)/(partial position))^(-1) (partial f)/(partial theta) + (partial loss)/(partial theta) 
$ <implicit_differentiation>

This is implicit differentiation.
]

#mybox(title:"Adjoint Vector")[

To speed up the computation, the adjoint vector $lambda$ is introduced:

$
  lambda^T = (partial loss)/(partial position) ((partial f)/(partial position))^(-1)
$

Right product with $(partial f)/(partial position):$

$
  lambda^T (partial f)/(partial position) = (partial loss)/(partial position)
$

Transpose:

$
  ((partial f)/(partial position))^T lambda  = ((partial loss)/(partial position))^T
$ <adjoint_linear_system>
This is a linear system to solve:

Once the adjoint vector $lambda$ is found:

$
(d loss)/(d theta) = -lambda^T (partial f)/(partial theta) + (partial loss)/(partial theta) 
$ <gradient_loss>
]

=== Gradient Descent

The gradient from @gradient_loss can be used in a gradient-based optimization method, such as a gradient descent:

#algorithm(inset: 0.5em, {
  import algorithmic: *
  let Solve = Call.with("Solve")
  let Compute = Call.with("Compute")
  Procedure(
    "Gradient Descent",
    ($theta_0$, $loss$, $f$, $gamma$),
    {
      LineComment(Assign[$theta$][$theta_0$], $theta_0$ + " is the initial guess")
      While(
        "not converged",
        {
          LineComment(Assign[$position^*$][Solve $f(state, theta)=0$], "Newton-Raphson method can be used for example")
          Compute($(partial loss)/(partial position)$ + " evaluated at " + $(position^*, theta)$)
          Compute($(partial loss)/(partial theta)$ + " evaluated at " + $(position^*, theta)$)
          Compute($lambda^T$ + " from " + $(partial f)/(partial position) lambda^T = (partial loss)/(partial position)$)
          Compute($(partial f)/(partial theta)$ + " evaluated at " + $(position^*, theta)$)

          Assign($(d loss)/(d theta)$, $-lambda^T (partial f)/(partial theta) + (partial loss)/(partial theta) $)

          LineComment(Assign($theta$, $theta - gamma (d loss)/(d theta)$), "Move against the gradient")

          Compute("convergence criteria")
        }
        )
    }
  )
})

=== Quadratic Programming

If the loss function $loss$ is a quadratic function (can be written as $loss= 1/2 x^T Q x$), this falls into the category of quadratic optimization (or quadratic programming).

$
loss(position^*) = 1/2 norm(position^* - position_d)^2
$

=== Gradient-based Optimization for Static Equilibrium <optim_static>

The implicit function $f$ is @static_equation: $force(position, theta)=0$

To compute $(d loss)/(d theta)$ in @implicit_differentiation ($(d loss)/(d theta) = -(partial loss)/(partial position) ((partial f)/(partial position))^(-1) (partial f)/(partial theta) + (partial loss)/(partial theta) $), we need $(partial f)/(partial position)$:

$
  (partial f)/(partial position) = (partial force)/(partial position) = stiffness
$

and $(partial f)/(partial theta)$:

$
  (partial f)/(partial theta) = (partial force)/(partial theta)
$

The adjoint vector is computed by solving the linear system (@adjoint_linear_system):

$
((partial f)/(partial position))^T lambda  = ((partial loss)/(partial position))^T <=>
  stiffness^T lambda = ((partial loss)/(partial position))^T
$

Finally,
$
(d loss)/(d theta) = -lambda^T (partial force)/(partial theta) + (partial loss)/(partial theta)
$

#mybox(title: "Mapping")[
If $force$ results from a mapping, such as $force_"in" = force_"out"$, then:

$
  (partial force_"in")/(partial theta) &= (partial jacobianmapping^T force_"out")/(partial theta) \
  &= (partial jacobianmapping^T)/(partial theta) force_"out" + jacobianmapping^T (partial force_"out")/(partial theta)
$

It is unlikely that both $J$ and $force_"out"$ depend on $theta$, so:

$
  (partial force_"in")/(partial theta) = jacobianmapping^T (partial force_"out")/(partial theta)
$
]

// === Gradient-based Optimization for Implicit Methods

// #todo[Verifier si c'est plus simple en intégration explicite]

// Suppose we simulate a dynamical system with an implicit method, that relies on an implicit time-step equation:

// $
// f(state_(n+1), state_n, theta) = 0  
// $

// #mybox(title:"Example")[
// An example of such a function is the backward Euler residual function (@h_backward_euler):

// $
//   mat( position_(n+1) - position _n - stepsize thick velocity_(n+1) ; massmatrix(velocity_(n+1) -velocity _n) - stepsize thick force(state_(n+1))) = 0
// $
// ]

// The goal is to compute $(d loss)/(d theta)$ where $loss=loss(state_N, theta)$, a scalar loss function depending on the final state (after $N$ time steps) and parameter $theta$.

// $
// (d loss)/(d theta) = (partial loss)/(partial state_N) (d state_N)/(d theta) + (partial loss)/(partial theta)
// $

// $(d state_N)/(d theta)$ is not known. Let's compute it.

// By differentiation of $f$:

// $
//   f(state_(n+1), state_n, theta) = 0  
//   <=>& d/(d theta) f(state_(n+1), state_n, theta) = 0 \
//   <=>& (partial f)/(partial state_(n+1)) (d state_(n+1))/(d theta) 
//     + (partial f)/(partial state_n) (d state_n)/(d theta)
//     + (partial f)/(partial theta) = 0
// $

// Since $(partial f)/(partial state_(n+1))$ is invertible:

// $
//  (d state_(n+1))/(d theta) = - ((partial f)/(partial state_(n+1)))^(-1)
//     ((partial f)/(partial state_n) (d state_n)/(d theta)
//     + (partial f)/(partial theta))
// $

// We can deduce:

// $
//  (d state_N)/(d theta) = - (lr((partial f)/(partial state_(n+1))|)_(state_N, theta))^(-1)
//     lr((partial f)/(partial state_n)|)_(state_N, theta) (d state_(N-1))/(d theta)
//     + (partial f)/(partial theta))
// $

// #algorithm(inset: 0.5em, {
//   import algorithmic: *
//   let Solve = Call.with("Solve")
//   let Compute = Call.with("Compute")
//   Procedure(
//     "Forward-mode propagation",
//     ($theta_0$, $loss$, $f$, $gamma$),
//     {
//       Assign[$state_0$][$text("initial_state")(theta)$]
//       Assign[$(d state)/(d theta)$][$(d text("initial_state"))/(d theta)$]
//       Assign[$t$][$0$]
//       For($t < N$, {
//         LineComment(Assign[$state_(t+1)$][Solve $f(state_(t+1), state_t, theta)=0$], "Newton-Raphson method can be used for example")

//         Compute($(partial f)/(partial state_(n+1))$ + " evaluated at " + $state_(t+1),theta$)

//         Compute($(partial f)/(partial state_(n))$ + " evaluated at " + $state_(t+1),theta$)

//         Assign[$(d state)/(d theta)$][$- ((partial f)/(partial state_(n+1)))^(-1) ((partial f)/(partial state_n) (d state)/(d theta)
//     + (partial f)/(partial theta))$]
//       })

//       Assign($(d loss)/(d theta)$, $(partial loss)/(partial state_N) (d state_N)/(d theta) + (partial loss)/(partial theta)$)
//     }
//   )
// })