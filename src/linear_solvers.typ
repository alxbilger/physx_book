#import "box.typ":*
#import "variables.typ": *

= Linear Solvers

In @linear_system_in_newton_raphson, a linear system needs to be solved in every iteration of Newton-Raphson. This chapter describes several methods to solve linear systems.

== Matrix Splitting Methods

=== Introduction

#definition(title:"Matrix Splitting")[
  Consider the linear system
  $
    A x = b
  $
  where $A in RR^(n times n)$, $x in RR^n$ and $b in RR^n$.

  A can be split:

  $
    A = M - N
  $ <generic_matrix_splitting>
  with $M$ nonsingular.
] 

The linear system is
$
  A x = b
    &<=> (M - N) x = b \
    &<=> M x = b + N x
$

#property(title:"Iterative Solution")[
The solution can be approximated iteratively as follows:

$
  M x^((k+1)) = b + N x^((k))
$

or, equivalently,

$
  x^((k+1)) = M^(-1) (b + N x^((k)))
$ <iteration_matrix_splitting>
]

=== Relaxed Matrix Splitting

#definition(title:"Relaxed Matrix Splitting")[
  Considering the matrix splitting from @generic_matrix_splitting, the matrix can also be split as follows:

  $
    A = M_omega - N_omega
  $

  with $M_omega = 1/omega M$ and $N_omega = 1/omega M - A$, $omega$ is the relaxation factor.
]

$N_omega$ can also be written in terms of $M$ and $N$:

$
N_omega = 1/omega M - A = 1/omega M - (M - N) = (1/omega -1) M + N
$


From @iteration_matrix_splitting, we have:
$
  x^((k+1)) = M_omega^(-1) (b + N_omega x^((k)))
$

- $1/omega M = omega M^(-1)$
- $M_omega^(-1) N_omega = omega M^(-1) ((1/omega -1) M + N) = (1-omega) I + omega M^(-1) N$

$
  x^((k+1)) = M_omega^(-1) b + M_omega^(-1) N_omega x^((k)))
  &<=> x^((k+1)) = omega M^(-1) b + ((1-omega) I + omega M^(-1) N)x^((k)) \
  &<=> x^((k+1)) = (1-omega) x^((k)) + omega M^(-1) (b + N x^((k))) \
$ <relaxed_iteration_matrix_splitting>

Compared to @iteration_matrix_splitting, it is relaxed, as a combination of the old iteration and the new one.

=== Jacobi

Matrix splitting:
$
  A = D + (L + U)
$

In @generic_matrix_splitting, $M = D$ and $N = -(L+U)$.

Substituting $M$ and $N$ in @iteration_matrix_splitting:
$
  x^((k+1)) = D^(-1) (b - (L+U) x^((k)))
$

=== Weighted Jacobi

Weighted Jacobi method is the relaxed version of the Jacobi method.

Substituting $M$ and $N$ in @relaxed_iteration_matrix_splitting:
$
  x^((k+1)) = (1-omega) x^((k)) + omega D^(-1) (b - (L+U) x^((k)))
$

=== Gauss-Seidel

Matrix splitting:

$
  A = (D + L) + U
$

In @generic_matrix_splitting, $M = D + L$ and $N = -U$.

Substituting $M$ and $N$ in @iteration_matrix_splitting:

$
  x^((k+1)) = (D+L)^(-1) (b - U x^((k)))
$

=== Successive over-relaxation

The successive over-relaxation (SOR) method is the relaxed version of the Gauss-Seidel method.

Substituting $M$ and $N$ in @relaxed_iteration_matrix_splitting:

$
  x^((k+1)) = (1-omega) x^((k)) + omega (D+L)^(-1) (b - U x^((k)))
$