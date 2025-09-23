#import "variables.typ": *
#import "box.typ": *

= Numerical Integration

== Definition

#definition[
For any function $y=y(t)$, we call 

$
y_n=y(t_n)
$ <sequence>

with 

$
t_n = t_0 + n thick Delta t
$
]

#definition(title: "Initial Value Problem")[
Numerical methods for ordinary ordinary differential equation approximate solutions to initial value problems of the form:

$
y'=f(t,y), quad y(t_0) = y_0
$ <initial_value_problem>
]

== Linear Multistep Method

$
y_(n+s) + a_(s-1) y_(n+s-1) + a_(s-2) y_(n+s-2) + dots + a_0 y_n = \ stepsize ( b_s f(t_(n+s), y_(n+s)) + b_(s-1) f(t_(n+s-1), y_(n+s-1)) + dots + b_0 f(t_n, y_n))
$

or

$
sum_(j=0)^s a_j y_(n+j) = stepsize sum_(j=0)^s b_j f(t_(n+j),y_(n+j))
$ <linear_multistep_method>

If $b_s = 0$, the method is called "explicit": it is possible to compute $y_(n+s)$ directly.
If $b_s != 0$, the method is called "implicit": the value of $y_(n+s)$ depends on the value of $f(t_(n+s), y_(n+s))$.

== Backward Differentiation Formula

Given a set of $s+1$ nodes ${t_n, t_(n+1), ..., t_(n+s)}$, the Lagrange basis for polynomials of degree $<= s$ for those notes is the set of polynomials ${l_0(t), l_1(t), ..., l_s (t)}$:

$
l_j (t) = product_(0<=m<=s\ m!=j) (t-t_(n+m))/(t_(n+j)-t_(n+m))
$

The Lagrange interpolating polynomial for those nodes through the corresponding values ${y_(n), y_(n+1), ..., y_(n+s)}$ is the linear combination:

$
L(t) = sum_(j=0)^s y_(n+j) l_j (t)
$

=== Derivative:

$
L'(t) = sum_(j=0)^s y_(n+j) l'_j (t)
$

$
l'_j (t) = sum_(i = 0 \ i != j)^s [ 1 / (t_(n+j) - t_(n+i)) product_(m = 0 \ m != (i,j)) (t - t_(n+m)) / (t_(n+j) - t_(n+m))]
$

=== Lagrange polynomials to solve an ODE
We approximate $y'$ by $L'$ in @initial_value_problem:

$
sum_(j=0)^s y_(n+j) l'_j (t) = f(t,y)
$

We want to find $y(t_(n+s))$, therefore

$
sum_(j=0)^s y_(n+j) l'_j (t_(n+s)) = f(t_(n+s),y_(n+s))
$


$
sum_(j=0)^s y_(n+j) (sum_(i = 0 \ i != j)^s [ 1 / (t_(n+j) - t_(n+i)) product_(m = 0 \ m != (i,j)) (t_(n+s) - t_(n+m)) / (t_(n+j) - t_(n+m))]) = f(t_(n+s),y_(n+s))
$

=== Constant Step Size

$
t_(n+j) = t_n + j thick stepsize
$

So, for all $i,j$

$
t_(n+j) - t_(n+i) 
&= t_n + j thick stepsize - (t_n + i thick stepsize)\
&= (j-i) stepsize
$

$
sum_(j=0)^s y_(n+j) (sum_(i = 0 \ i != j)^s [ 1 / (j - i) product_(m = 0 \ m != (i,j)) (s - m) / (j - m)]) = stepsize thick f(t_(n+s),y_(n+s))
$

==== BDF1

For $s=1$:

$j=0$:
$
l'_0 (t_(n+1)) = sum_(i = 0 \ i != 0)^1 [ 1 / (0 - i) product_(m = 0 \ m != (i,0)) (1 - m) / (- m)] =  1 / (-1) product_(m = 0 \ m !=(1,0)) (1 - m) / (- m) = -1
$

$j=1$:

$
l'_1 (t_(n+1)) = sum_(i = 0 \ i != 1)^1 [ 1 / (1 - i) product_(m = 0 \ m != (i,1)) (1 - m) / (1 - m)] =  1 / (1) product_(m = 0 \ m != (0,1)) (1 - m) / (1 - m) = 1
$

Finally, for $s = 1$:

$
y_(n+1) - y_(n) = stepsize thick f(t_(n+1), y_(n+1))
$

==== BDF2

For $s=2$:

$j = 0$:
$
l'_0 (t_(n+2)) & = sum_(i = 0 \ i != 0)^2 [ 1 / ( - i) product_(m = 0 \ m != (i,0)) (2 - m) / (- m)] \ 
&= ( 1 / ( - 1) product_(m = 0 \ m != (1,0)) (2 - m) / (- m)) + ( 1 / ( - 2) product_(m = 0 \ m != (2,0)) (2 - m) / (- m)) \ 
&= -1/2 ((2-1)/(-1)) = 1/2
$

$j=1$:

$
l'_1 (t_(n+2)) & = sum_(i = 0 \ i != 1)^2 [ 1 / (1 - i) product_(m = 0 \ m != (i,1)) (2 - m) / (1 - m)] \
&= ( 1 / (1) product_(m = 0 \ m != (0,1)) (2 - m) / (1 - m)) + ( 1 / (1 - 2) product_(m = 0 \ m != (2,1)) (2 - m) / (1 - m)) \
&= -2
$

$j=2$:

$
l'_2 (t_(n+2)) & = sum_(i = 0 \ i != 2)^2 [ 1 / (2 - i) product_(m = 0 \ m != (i,2)) (2 - m) / (2 - m)] \
&= ( 1 / (2 ) product_(m = 0 \ m != (0,2)) (2 - m) / (2 - m)) + ( 1 / (2 - 1) product_(m = 0 \ m != (1,2)) (2 - m) / (2 - m))\
&= 3/2
$

Finally, for $s = 1$:

$
3/2 y_(n+2) -2 y_(n+1) + 1/2 y_(n) = stepsize thick f(t_(n+2), y_(n+2))
$

which can be written:

$
y_(n+2) - 4/3 y_(n+1) + 1/3 y_(n) = 2/3 stepsize thick f(t_(n+2), y_(n+2))
$


== Numerical Integration of ODE

=== Newton's Second Law of Motion

The second Newton's law (@ODE) is a first-order ordinary differential equation of the form of @initial_value_problem ($y'=f(t,y), quad y(t_0) = y_0$) where:

$
y(t) = mat( position(t); velocity(t))
$ <definition_y>

$
f(t,y) = mat( velocity(t); massmatrix^(-1) (force(position, velocity) - coriolismatrix velocity))
$ <definition_f>

In case of Rayleigh damping (@F_rayleigh):

$
f(t,y) = mat( velocity(t); massmatrix^(-1) (force(position, velocity) - coriolismatrix velocity + (-alpha massmatrix + beta stiffness(position, velocity)) velocity))
$

=== Heat Equation

@heat_equation is of the form of @initial_value_problem where:

$
y(t) = u(t)
$

$
f(t,y) = diffusivity laplace u
$

== Newton-Raphson

For implicit methods, @linear_multistep_method is nonlinear. Newton-Raphson algorithm can be used to solve it.

=== Nonlinear function


Find the root $x_r$ of a nonlinear function $r:RR^k arrow RR^k$ such that:

$
r(x_r) = 0
$ <nonlinear_equation>

Let's define $x^0$ the first estimate of the solution of this equation, called the initial guess.

$
Delta x^0 = x_r - x_0
$

Taylor series expansion of $r$ around $x^0$

$
r(x_r)&= r(x_0 + Delta x_0) \
&=r(x_0) + lr((partial r)/(partial x)|)_(x^0) Delta x^0 + O(norm(Delta x^0)^2)
$

If we neglect second-order terms and higher:

$
r(x_r) approx r(x_0) + lr((partial r)/(partial x)|)_(x^0) Delta x^0
$

If we use this approximation to solve the equation @nonlinear_equation, it leads to:

$
r(x^0) + lr((partial r)/(partial x)|)_(x^0) Delta x^0 = 0
$

This is a linear system to solve for the unknown $Delta x^0$:

$
lr((partial r)/(partial x)|)_(x^0) Delta x^0 = -r(x^0)
$

Once $Delta x^0$ is found, $x^1$ can be deduced:

$
x^1 = Delta x^0 + x^0
$

The process is repeated as

$
lr((partial r)/(partial x)|)_(x^i) (x^(i+1)-x^i) = -r(x^i)
$

=== Optimization <newton_raphson_optimization>

Newton-Raphson method can also be used in optimization problems.

Given a twice-differentiable function $r = r(x)$, optimizing $r$ is equivalent to finding the roots of $nabla r = (partial r)/(partial x)$, i.e. solving $nabla r(x)=0$. This can be done using the Newton-Raphson method.

The solution may be a minima, maxima, or saddle point.

Note that applying the Newton-Raphson method on $nabla r$ requires the Hessian matrix $nabla^2 r = (partial^2 r)/(partial x^2)$.

The iteration process is:

$
  lr((partial^2 r)/(partial x^2)|)_(x^i) (x^(i+1)-x^i) = -lr((partial r)/(partial x)|)_(x^i)
$

