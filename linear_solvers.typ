#import "box.typ":*
#import "variables.typ": *

= Linear Solvers

== Conjugate Gradient

== Jacobi

Matrix splitting:
$
  A = D + L + U
$

Solving the linear system:

$
  A x = b & <=> (D + L + U) x = b \
  & <=> D x + (L + U) x = b \
  & <=> D x = b - (L + U) x
$

Iterative process:
$
  D x^((k+1)) = b - (L + U) x^((k))
$

== Gauss-Seidel

=== Projected Gauss-Seidel