#import "variables.typ": *
#import "box.typ": *

= Constitutive Equations


== Invariants

=== First Invariant

#definition(title:"First invariant")[
$
  I_rightcauchygreen = tr(rightcauchygreen)
$

In index notation,

$
  I_rightcauchygreen = sum_i rightcauchygreen_(i i)
$

or,

$
  I_rightcauchygreen &= sum_i (deformationgradient^T deformationgradient)_(i i)\
  &= sum_i sum_j deformationgradient^T_(i j) deformationgradient_(j i) \
  &= sum_i sum_j deformationgradient_(j i) deformationgradient_(j i) \
$
]


#property(title:"Derivative w.r.t. " + $rightcauchygreen$)[
$
  (partial I_rightcauchygreen)/(partial rightcauchygreen) = tensor2(identity)
$
]

#property(title:"Derivative w.r.t. " + $deformationgradient$)[

In index notation:
$
  (partial I_rightcauchygreen)/(partial deformationgradient_(k l)) 
  &= (partial sum_i sum_j deformationgradient_(j i) deformationgradient_(j i))/(partial deformationgradient_(k l)) \
  &= sum_i sum_j (partial deformationgradient_(j i) deformationgradient_(j i))/(partial deformationgradient_(k l)) \
  &= 2 deformationgradient_(k l)
$

Therefore, in tensor notation:

$
  (partial I_rightcauchygreen)/(partial deformationgradient) = 2 deformationgradient
$
]

=== Third Invariant

#definition(title:"Third invariant")[
$
  I^3_rightcauchygreen = det(rightcauchygreen)
$
]

#property(title:"Derivative w.r.t. " + $deformationgradient$)[
  According to @derivative_determinant:

  $
    (partial det(rightcauchygreen))/(partial rightcauchygreen) = det(rightcauchygreen) [rightcauchygreen^(-1)]^T
  $

  Using chain rule:

  Finally,

  $
    (partial det(rightcauchygreen))/(partial deformationgradient) = 2 det(rightcauchygreen) deformationgradient rightcauchygreen^(-1)
  $

  And using the adjugate matrix:

  $
    (partial det(rightcauchygreen))/(partial deformationgradient) = 2 det(rightcauchygreen) text("adj")(deformationgradient)^T
  $

]

== Neo Hookean Material

$
  strainenergydensity = mu / 2 (I_C - d) - mu log J + lambda / 2 (log J)^2 
$

According to Bonet et al.

$
pk1 = (partial strainenergydensity) / (partial deformationgradient) 
&= mu/2 (partial I_rightcauchygreen)/(partial deformationgradient) - mu (partial log J)/(partial deformationgradient) + lambda log J (partial log J)/(partial deformationgradient) \
&= mu (deformationgradient - 1/J (partial J)/(partial deformationgradient)) + lambda / J log J (partial J)/(partial deformationgradient)
$

According to @derivative_determinant and @adjugate,

$
  (partial J)/(partial deformationgradient) = J [deformationgradient^(-1)]^T = J [1/J "adj"(F)]^T = "adj"(F)^T
$

Now the Hessian:

$
  (partial pk1)/(partial deformationgradient) = 
$