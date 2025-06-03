#import "define.typ": result

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
integral_a^b u(x) v'(x) thick d x &= [u(x) v(x)]_a^b - integral_a^b u'(x) v(x) thick d x \
&= u(b)v(b) - u(a)v(a) - integral_a^b u'(x) v(x) thick d x
$ <integration_by_parts>