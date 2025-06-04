#import "@preview/cetz:0.2.0"
#import "box.typ": *

= Spring

== Linear Spring


#definition[
Hooke's law:

$
F=k x
$
]

$x$ is the amount by which the free end of the spring was displaced from its "relaxed" position.

Considering two points $a$ and $b$, $x=norm(b-a)$, and the force is exerted along the direction $b-a$.

// #align(center)[
// #cetz.canvas({
//   import cetz.draw: *
  
//   // Draw point a
//   circle((0, 0), radius: 0.05, fill: black)
//   content((0, -0.3), text(size: 10pt, $a$))
  
//   // Draw point b
//   circle((6, 3), radius: 0.05, fill: black)
//   content((6, 2.7), text(size: 10pt, $b$))

//   line((0, 0), (2, 1), mark: (end: "stealth"))
//   content((1, 0.2), text(size: 10pt, $F_a$))
  
//   line((6, 3), (4, 2), mark: (end: "stealth"))
//   content((5, 2), text(size: 10pt, $F_b$))
// })
// ]

Then:

$
F_a = k thick (||b - a|| - L_0)  (b - a) / norm(b - a)
$

$
F_b = k thick (||a - b|| - L_0)  (a - b) / norm(a - b) = -F_a
$

where:
- $k$ is the spring stiffness constant
- $a$ The position vector of the first end of the spring
- $b$ The position vector of the second end of the spring.
- $||b - a||$ is the distance between the two ends of the spring,
- $L_0$ is the rest length of the spring.

To compute the derivative of $F_a$ and $F_b$, we define $delta=norm(b-a)$

$
F_a &= k (delta - L_0) (b-a)/delta \
&= k(1 - L_0/delta) (b-a)\
&= k( b - a - L_0/delta (b - a))
$

$
(partial F_a)/(partial a)
&= k partial / (partial a) ( b - a - L_0/delta (b - a)) \
&= -k (I + L_0 partial / (partial a) ((b - a)/delta)) \
$

From @derivative_normalized_vetor_difference_b,

$
partial / (partial a) ((b - a)/delta) = -1/delta I + 1/delta^3 (b - a) times.circle (b - a)
$

Finally,

$
(partial F_a)/(partial a) &= -k (I + L_0 (-1/delta I + 1/delta^3 (b - a) times.circle (b - a))) \
&= -k((1-L_0/delta)I+L_0/delta^3(b-a)times.circle(b-a)) \
&= -k((1-L_0/delta)I+L_0/delta hat(b-a)times.circle hat(b-a))
$

#result(
$
(partial F_a)/(partial a) = -k((1-L_0/delta)I+L_0/delta hat(b-a)times.circle hat(b-a))
$
)

Similarly,

$
(partial F_a)/(partial b)
&= k partial / (partial b) ( b - a - L_0/delta (b - a)) \
&= k  ( I - L_0 partial / (partial b) ((b - a)/delta))
$

From @derivative_normalized_vetor_difference_a,

$
partial / (partial b) ((b - a)/delta) = 1/delta I - 1/delta^3 (b - a) times.circle (b - a)
$

Finally,

$
(partial F_a)/(partial b)
&= k  ( I - L_0 (1/delta I - 1/delta^3 (b - a) times.circle (b - a)))\
&= k  ( (1-L_0/delta) I - L_0/delta^3 (b - a) times.circle (b - a))\
&= k  ( (1-L_0/delta) I - L_0/delta hat(b - a) times.circle hat(b - a))
$

#result[
$
(partial F_a)/(partial b) = k  ( (1-L_0/delta) I - L_0/delta hat(b - a) times.circle hat(b - a))
$
]


== Nonlinear Spring

$
F = F(x)
$

=== Quadratic Spring

#definition(
$
F = k x^2
$
)

Considering two points $a$ and $b$, $delta=norm(b-a)$,


$
F_a &= k thick (||b - a|| - L_0)^2  (b - a) / norm(b - a) \
&= k (delta - L_0)^2 (b-a)/delta
$

$
F_b &= k thick (||a - b|| - L_0)^2  (a - b) / norm(a - b)\
&= -k (delta - L_0)^2 (b-a)/delta\
&= -F_a
$
