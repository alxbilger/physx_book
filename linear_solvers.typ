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
  D x^((k+1)) = b - (L + U) x^((k)) <=> x^((k+1)) = D^(-1) (b - (L + U) x^((k)))
$

== Gauss-Seidel

Matrix splitting:

$
  A = L + U
$

$L$ contains the diagonal:

$
  A = 
  underbrace(
  mat(
    a_(11), 0, ..., 0;
    a_(21), a_(22), ..., 0;
    dots.v, dots.v, dots.down, dots.v;
    a_(n 1), a_(n 2), ..., a_(n n)
  ), L) +
  underbrace(
  mat(
    0, a_(1 2), ..., a_(1 n);
    0, 0, ..., a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    0,0,0,0
  ), U)
$

Solving the linear system:

$
  A x = b & <=> (L + U) x = b \
  &<=> L x + U x = b \
  &<=> L x = b - U x
$

Iterative process:

$
  L x^((k+1)) = b - U x^((k)) <=>  x^((k+1)) = L^(-1) (b - U x^((k)))
$

=== Projected Gauss-Seidel