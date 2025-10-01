#import "variables.typ": *
#import "box.typ": *

= Maths

== Outer Product

Given two vectors of size $m times 1$ and $n times 1$ respectively $u = (u_1,dots, u_n)$, $v = (v_1,dots, v_n)$,
their outer product, denoted $u times.circle v$, is defined as the $m times n$ matrix $A$ obtained by multiplying each element of $u$ by each element of $v$:

$
u times.circle v = A =
mat( 
u_1 v_1, u_1 v_2, dots, u_1 v_n;
u_2 v_1, u_2 v_2, dots, u_2 v_n;
dots.v, dots.v, dots.down, dots.v;
u_m v_1, u_m v_2, dots, u_m v_n
)
$

The outer product $u times.circle v$ is equivalent to a matrix multiplication $u v^T$.

== Double dot product <double_dot_product>

#definition(title:"Double dot product")[
The double dot product of two 2nd order tensors $tensor2(A)$ and $tensor2(B)$ is denoted $tensor2(A) : tensor2(B)$

It is also called double contraction, or the Frobenius inner product.
]

#property()[
  $
  tensor2(A) : tensor2(B) = sum_(i=1)^n sum_(j=1)^n A_(i j) B_(i j)
  $
]

#property()[
  $
  tensor2(A) : tensor2(B) = tr(tensor2(A)^T tensor2(B))
  $
]

#property(title:"Chain rule")[
  Suppose a scalar function $strainenergydensity$ depending on a 2nd order tensor $deformationgradient$. We want to derivate $strainenergydensity$ with respect to a vector $displacement_e$. Then,

  $
    (partial strainenergydensity)/(partial displacement_e) = (partial strainenergydensity)/(partial deformationgradient) : (partial deformationgradient) / (partial displacement_e)
  $ <chain_rule_double_dot_product>

  #emoji.warning Here the double dot product is generalized. $(partial deformationgradient) / (partial displacement_e)$ is a 3rd order tensor, so the definition of the double dot product does not apply. To be rigorous, we should write with the index notation:

  $
    (tensor2(A) : tensor3(B))_k = sum_(i=1)^n sum_(j=1)^n A_(i j) B_(i j k)
  $

  Then,

  $
    (partial strainenergydensity)/(partial displacement_e_k) = sum_(i=1)^n sum_(j=1)^n (partial strainenergydensity)/(partial deformationgradient_(i j)) : (partial deformationgradient_(i j)) / (partial displacement_e_k)
  $

  resulting in a vector.
]

== Determinant

#definition(title:"Determinant")[
Let $deformationgradient in RR^(n times n)$, the determinant of $deformationgradient$ is denoted $det(deformationgradient)$.

$
  det(deformationgradient) = 
  mat(delim:"|",
    f_(1,1), f_(1,2), ..., f_(1,n);
    f_(2,1), f_(2,2), ..., f_(2,n);
    dots.v, dots.v, dots.down, dots.v;
    f_(n,1), f_(n,2), ..., f_(n,n);
    )
$
]

#property(title:"In 2D")[
$
  mat(delim:"|",
    a,b;
    c,d
  ) = a d - b c
$
]

#property(title:"In 3D")[
$
  mat(delim:"|",
      a,b,c;
      d,e,f;
      g,h,i
    ) = a e i + b f g + c d h - c e g - b d i - a f h
$
]

#property(title:"Derivative")[
  It can be shown that for any 2nd order tensor $tensor2(S)$
  $
    (partial det(tensor2(S)))/(partial tensor2(S)) = det(tensor2(S)) [tensor2(S)^(-1)]^T
  $ <derivative_determinant>
]

== Adjugate Matrix

$
  bold(A) "adj"(bold(A)) = det(bold(A)) identity
$ <adjugate>

== Derivative of the 2-norm

The 2-norm of vector $x=(x_1,dots, x_n)$ is

$
norm(x)_2 := sqrt(sum_(i=1)^ n x_i^2)
$

The partial derivative of the 2-norm is given by

$
partial/(partial x_k) norm(x)_2 = x_k / norm(x)_2
$

The derivative with respect to $x$ is

#result[
$
(partial norm(x)_2) / (partial x) = x / norm(x)_2
$ <derivative_norm2>
]

Result can be found in @petersen2012matrix.

Considering two points $a$ and $b$, and $gamma = a - b$:

$
(partial norm(a-b)) / (partial a) &= (partial norm(gamma))/(partial gamma) dot (partial gamma) / (partial a) \
&= gamma / norm(gamma)_2 dot 1 \
&= (a-b)/norm(a-b)_2
$ <derivative_norm2_difference>

and 

$
(partial norm(a-b)) / (partial a) = (b-a)/norm(b-a)_2
$




== Derivative of a normalized vector

The normalized vector of $x$ is a vector in the same direction but with norm 1. It is denoted $hat(x)$ and given by

$
hat(x) = x/norm(x)_2
$

Using the quotient rule, the partial derivative of the normalized vector is given by

$
(partial hat(x))/(partial x) &= ( norm(x)_2 (partial x)/(partial x) - x (partial norm(x)_2)/(partial x)) / norm(x)_2^ 2
$

Using @derivative_norm2,

$
(partial hat(x))/(partial x) = (norm(x)_2 I - x  x / norm(x)_2) / norm(x)_2^ 2
$

Finally,

#result[
$
(partial hat(x))/(partial x) = 1/norm(x)_2 I - 1/norm(x)_2^3 x times.circle x
$ <derivative_normalized_vetor>
]

Considering two points $a$ and $b$, and $gamma = a - b$:

$
(partial hat(a-b))/(partial a) = (partial hat(gamma))/(partial a)
&= (partial hat(gamma))/(partial gamma) dot (partial gamma)/(partial a) \
&= 1/norm(gamma)_2 I - 1/norm(gamma)_2^3 gamma times.circle gamma
$  <derivative_normalized_vetor_difference_a>

$
(partial hat(a-b))/(partial b) = (partial hat(gamma))/(partial b)
&= (partial hat(gamma))/(partial gamma) dot (partial gamma)/(partial b) \
&= -1/norm(gamma)_2 I + 1/norm(gamma)_2^3 gamma times.circle gamma \
&= -(partial hat(a-b))/(partial a)
$  <derivative_normalized_vetor_difference_b>


== Schur Complement

The following is a linear system of equations in the matrix form using a 2x2 partition:

$
mat( A, B; C, D) mat( x; y) = mat( u;v)
$

Suppose $p$, $q$ are nonnegative integers such that $p + q > 0$, and suppose $A$, $B$, $C$, $D$ are respectively $p times p$, $p times q$, $q times p$, and $q times q$ matrices.

$
cases(A x + B y &= u, C x + D y &= v)
$

Using the first line, we can express $x$ in terms of $y$:
$
x = A^(-1)(u - B y)
$ <block_elimination_x>

Substituting this expression into the second line of the equation:

$
(D - C A^(-1) B) y = v - C A^(-1) u
$ <schur_complement_linear_system_y>

$(D - C A^(-1) B)$ is the Schur complement of the block $A$.

Similarly, we can express $y$ in terms of $x$ using the first line:

$
y = B^(-1) (u - A x)
$ <block_elimination_y>

Substituting this expression into the second line of the equation:

$
(C - D B^(-1) A) x = v - D B^(-1) u
$ <schur_complement_linear_system_x>


== Integration by parts

$
integral_a^b u(x) v'(x) thick dif x &= [u(x) v(x)]_a^b - integral_a^b u'(x) v(x) thick dif x \
&= u(b)v(b) - u(a)v(a) - integral_a^b u'(x) v(x) thick dif x
$ <integration_by_parts>