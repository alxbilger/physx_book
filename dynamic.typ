#import "variables.typ": *

= Dynamic

$
mass(x) thick dot(v) = P(t) - F(x, v) + H^T lambda
$

- $mass : RR^n arrow.r.long.bar RR^(n times n) $: mass matrix
- $x in RR^n$: vector of degrees of freedom (e.g. position)
- $v$: vector of velocities
- $F$: internal forces
- $P$: external forces
- $t$: current time
- $H^T lambda in RR^n$: constraint forces


Short version:
$
mass(state) thick (d velocity)/(d t) = force(position, velocity)
$

or:
$
mass(state) thick acceleration = force(position, velocity)
$ <short_dynamic>