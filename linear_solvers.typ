#import "box.typ":*
#import "variables.typ": *

= Linear Solvers

In @linear_system_in_newton_raphson, a linear system needs to be solved in every iteration of Newton-Raphson. This chapter describes several methods to solve linear systems.

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

== Successive over-relaxation

Matrix splitting:
$
  A = D + L + U
$

Solving the linear system:

$
  A x = b & <=> omega A x = omega b \
  & <=> omega (D + L + U) x = omega b \
  & <=> (omega (D + L + U) + D - D) x = omega b \
  & <=> (D + omega L) x = omega b - (omega U + (omega - 1) D) x
$

Iterative process:

$
  (D + omega L) x^((k+1)) &= omega b - (omega U + (omega - 1) D) x^((k)) \
  <=>  x^((k+1)) &= (D + omega L)^(-1)(omega b - (omega U + (omega - 1) D) x^((k)))
$