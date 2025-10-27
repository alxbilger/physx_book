#import "variables.typ": *
#import "box.typ": *

= Constitutive Equations


== Principal Invariants

=== Definition

#definition(title:"Principal Invariants")[
  The principal invariants of the second-order tensor $tensor2(A)$ are the coefficients of the characteristic polynomial:
  $
    p(lambda) = det(tensor2(A) - lambda tensor2(I))
  $
]

=== First Invariant of $rightcauchygreen$

#definition(title:"First invariant")[
$
  invariant1 = tr(rightcauchygreen)
$

In index notation,

$
  invariant1 = sum_i rightcauchygreen_(i i)
$

or,

$
  invariant1 &= sum_i (deformationgradient^T deformationgradient)_(i i)\
  &= sum_i sum_j deformationgradient^T_(i j) deformationgradient_(j i) \
  &= sum_i sum_j deformationgradient_(j i) deformationgradient_(j i) \
$
]


#property(title:"Derivative w.r.t. " + $rightcauchygreen$)[
$
  (partial invariant1)/(partial rightcauchygreen) = tensor2(identity)
$ <derivative_invariant1_wrt_rightcauchygreen>
]

#property(title:"Derivative w.r.t. " + $deformationgradient$)[

In index notation:
$
  (partial invariant1)/(partial deformationgradient_(k l)) 
  &= (partial sum_i sum_j deformationgradient_(j i) deformationgradient_(j i))/(partial deformationgradient_(k l)) \
  &= sum_i sum_j (partial deformationgradient_(j i) deformationgradient_(j i))/(partial deformationgradient_(k l)) \
  &= 2 deformationgradient_(k l)
$

Therefore, in tensor notation:

$
  (partial invariant1)/(partial deformationgradient) = 2 deformationgradient
$ <derivative_invariant1_wrt_deformationgradient>
]

=== Second Invariant of $rightcauchygreen$

#definition(title:"Second invariant")[
$
  invariant2 = 1/2 (tr(rightcauchygreen)^2 - tr(rightcauchygreen^2))
$
]

#property(title:"Derivative w.r.t. " + $rightcauchygreen$)[
  $
    (partial invariant2)/(partial rightcauchygreen) = tr(rightcauchygreen) tensor2(identity) - rightcauchygreen
  $ <derivative_invariant2_wrt_rightcauchygreen>
]

#property(title:"Derivative w.r.t. " + $deformationgradient$)[
  $
    (partial invariant2)/(partial deformationgradient) = 2 (tr(rightcauchygreen) deformationgradient - deformationgradient rightcauchygreen)
  $ <derivative_invariant2_wrt_deformationgradient>
]

#mybox(title:"Bonet et al.")[
In @bonet1997nonlinear, the second invariant is defined as:

$
  invariant2 = tr(rightcauchygreen^2)
$

and its derivative w.r.t. $rightcauchygreen$ is:

$
  (partial invariant2)/(partial rightcauchygreen) = 2 rightcauchygreen
$

It is important to know which $invariant2$ is used.
]

=== Third Invariant of $rightcauchygreen$

#definition(title:"Third invariant")[
$
  invariant3 = det(rightcauchygreen)
$
]

#property(title:"Derivative w.r.t. " + $rightcauchygreen$)[
  According to @derivative_determinant:

  $
    (partial invariant3)/(partial rightcauchygreen) = (partial det(rightcauchygreen))/(partial rightcauchygreen) = det(rightcauchygreen) [rightcauchygreen^(-1)]^T
  $

  Since $rightcauchygreen$ is symmetric, $rightcauchygreen$ is also symmetric:
  $
    rightcauchygreen^(-1) = (deformationgradient^T deformationgradient)^(-1) = deformationgradient^(-1) deformationgradient^(-T)
  $
  $
    [rightcauchygreen^(-1)]^T = (deformationgradient^(-1) deformationgradient^(-T))^T = deformationgradient^(-1) deformationgradient^(-T) = rightcauchygreen^(-1)
  $

  Since $[rightcauchygreen^(-1)]^T = rightcauchygreen^(-1)$:
  $
    (partial invariant3)/(partial rightcauchygreen) = (partial det(rightcauchygreen))/(partial rightcauchygreen) = det(rightcauchygreen) rightcauchygreen^(-1)
  $ <derivative_invariant3_wrt_rightcauchygreen>
]

#property(title:"Derivative w.r.t. " + $deformationgradient$)[

  $
    (partial det(rightcauchygreen))/(partial deformationgradient) = 2 det(rightcauchygreen) deformationgradient rightcauchygreen^(-1)
  $ <derivative_invariant3_wrt_deformationgradient>

  And using the adjugate matrix:

  $
    (partial det(rightcauchygreen))/(partial deformationgradient) = 2 det(rightcauchygreen) text("adj")(deformationgradient)^T
  $

]

=== Isotropic Materials

#definition(title:"Isotropic materials")[
  $
    undefstrainenergydensity(rightcauchygreen) = undefstrainenergydensity(invariant1, invariant2, invariant3)
  $
]

==== First Piola-Kirchhoff Stress Tensor

From @pk1:

$
  pk1 &= (partial undefstrainenergydensity)/(partial deformationgradient) \
    &= (partial undefstrainenergydensity)/(partial invariant1) (partial invariant1)/(partial deformationgradient)
     + (partial undefstrainenergydensity)/(partial invariant2) (partial invariant2)/(partial deformationgradient)
     + (partial undefstrainenergydensity)/(partial invariant3) (partial invariant3)/(partial deformationgradient)
$ <pk1_as_function_of_invariants>

From @derivative_invariant1_wrt_deformationgradient, @derivative_invariant2_wrt_deformationgradient and @derivative_invariant3_wrt_deformationgradient:
$
  pk1
    = (partial undefstrainenergydensity)/(partial invariant1) 2 deformationgradient
    + (partial undefstrainenergydensity)/(partial invariant2) 2 (tr(rightcauchygreen) deformationgradient - deformationgradient rightcauchygreen)
    + (partial undefstrainenergydensity)/(partial invariant3) 2 det(rightcauchygreen) deformationgradient rightcauchygreen^(-1)
$

==== Second Piola-Kirchhoff Stress Tensor

From @pk2:

$
  pk2 &= 2 (partial undefstrainenergydensity)/(partial rightcauchygreen) \ 
  &= 2 (partial undefstrainenergydensity)/(partial invariant1) (partial invariant1)/(partial rightcauchygreen)
   + 2 (partial undefstrainenergydensity)/(partial invariant2) (partial invariant2)/(partial rightcauchygreen)
   + 2 (partial undefstrainenergydensity)/(partial invariant3) (partial invariant3)/(partial rightcauchygreen)
$

From @derivative_invariant1_wrt_rightcauchygreen, @derivative_invariant2_wrt_rightcauchygreen and @derivative_invariant3_wrt_rightcauchygreen:

$
  pk2 = 2 (partial undefstrainenergydensity)/(partial invariant1) tensor2(identity)
   + 2 (partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) tensor2(identity) - rightcauchygreen)
   + 2 (partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) rightcauchygreen^(-1)
$ <pk2_as_function_of_invariants>

We can observe that @pk1_as_function_of_invariants and @pk2_as_function_of_invariants are consistant with @pk2.

== St Venant-Kichhoff Material

#mybox(title:"Strain Energy")[
$
  undefstrainenergydensity = 1/2 lambda thin tr(greenstrain)^2 + mu thin greenstrain : greenstrain
$ <strain_energy_stvenantkirchhoff>

Based on @double_dot_product_trace, it can also be written as:

$
  undefstrainenergydensity = 1/2 lambda thin tr(greenstrain)^2 + mu thin tr(greenstrain^2)
$
]

#mybox(title: "First Piola-Kirchhoff Stress Tensor")[
  $
    pk1 = 2 mu deformationgradient greenstrain + lambda (tr(greenstrain)) deformationgradient
  $
]

Insert the following expression on https://www.matrixcalculus.org/:

```
1/2*lambda*tr(1/2*(F'*F-eye))^2 + mu*tr((1/2*(F'*F-eye))*(1/2*(F'*F-eye)))
```

#mybox(title: "Second Piola-Kirchhoff Stress Tensor")[
  $
    pk2 = 2 mu greenstrain + lambda (tr(greenstrain)) tensor2(identity)
  $

  In index notation:

  $
    pk2_(i j) = 2 mu greenstrain_(i j) + lambda delta_(i j) sum_k greenstrain_(k k) 
  $
]

#mybox(title: "Lagrangian Elasticity Tensor")[
$
  elasticitytensor_(i j k l) 
    &= (partial pk2_(i j))/(partial greenstrain_(k l)) \
    &= (partial)/(partial greenstrain_(k l))(2 mu greenstrain_(i j) + lambda delta_(i j) sum_p greenstrain_(p p) ) \
    &= 2 mu (partial greenstrain_(i j))/(partial greenstrain_(k l)) + lambda delta_(i j) sum_p (partial greenstrain_(p p))/(partial greenstrain_(k l)) \
$

If $greenstrain$ were independent, we would have $(partial greenstrain_(i j))/(partial greenstrain_(k l)) = delta_(i k) delta_(j l)$. However, due to the symmetry of $greenstrain$, $(partial greenstrain_(i j))/(partial greenstrain_(k l)) = 1/2(delta_(i k) delta_(j l) + delta_(i l) delta_(j k))$

Therefore:

$
elasticitytensor_(i j k l) 
    &= 2 mu 1/2(delta_(i k) delta_(j l) + delta_(i l) delta_(j k)) + lambda delta_(i j) sum_p (partial greenstrain_(p p))/(partial greenstrain_(k l)) \
    &= mu (delta_(i k) delta_(j l) + delta_(i l) delta_(j k)) + 1/2 lambda delta_(i j) sum_p delta_(p k) delta_(p l) \
    &= mu (delta_(i k) delta_(j l) + delta_(i l) delta_(j k)) + 1/2 lambda delta_(i j) delta_(k l)
$

]

== Neo Hookean Material

#mybox(title:"Strain Energy")[
$
  undefstrainenergydensity = mu / 2 (invariant1 - d) - mu log J + lambda / 2 (log J)^2 
$ <strain_energy_neohookean>

According to @bonet1997nonlinear.
]

#mybox(title: "First Piola-Kirchhoff Stress Tensor")[
$
pk1 = (partial undefstrainenergydensity) / (partial deformationgradient) 
&= mu/2 (partial invariant1)/(partial deformationgradient) - mu (partial log J)/(partial deformationgradient) + lambda log J (partial log J)/(partial deformationgradient) \
&= mu (deformationgradient - 1/J (partial J)/(partial deformationgradient)) + lambda / J log J (partial J)/(partial deformationgradient)
$

According to @derivative_determinant and @adjugate,

$
  (partial J)/(partial deformationgradient) = J [deformationgradient^(-1)]^T = J [1/J "adj"(F)]^T = "adj"(F)^T
$
]

#mybox(title: "Second Piola-Kirchhoff Stress Tensor")[
  Recall that:
  $
    invariant3 &= det(rightcauchygreen) \ &= det(deformationgradient^T deformationgradient) \ &= det(deformationgradient^T )det(deformationgradient)\ &= det(deformationgradient) det(deformationgradient)\ &= det(deformationgradient)^2\ &= deformationjacobian^2
  $

  Then @strain_energy_neohookean, the strain energy density function can be written in terms of invariants:

  $
    undefstrainenergydensity = mu / 2 (invariant1 - d) - mu log sqrt(invariant3) + lambda / 2 (log sqrt(invariant3))^2 
  $

  From @pk2_as_function_of_invariants:
  $
    pk2 &= 2 (partial undefstrainenergydensity)/(partial invariant1) tensor2(identity)
   + 2 (partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) tensor2(identity) - rightcauchygreen)
   + 2 (partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) rightcauchygreen^(-1) \
   &= mu (tensor2(identity) - rightcauchygreen^(-1)) + lambda (log deformationjacobian) rightcauchygreen^(-1)
  $
]

Let's derive the Lagrangian elasticity tensor:

$
  elasticitytensor_(i j k l) 
    &= (partial)/(partial rightcauchygreen_(k l))(mu (tensor2(identity)_(i j) - rightcauchygreen^(-1)_(i j)) + lambda (log deformationjacobian) rightcauchygreen^(-1)_(i j)) \
    &= -mu (partial rightcauchygreen^(-1)_(i j))/(partial rightcauchygreen_(k l)) + lambda ((partial log deformationjacobian)/(partial rightcauchygreen_(k l)) rightcauchygreen^(-1)_(i j) + log deformationjacobian (partial rightcauchygreen^(-1)_(i j)/ (partial rightcauchygreen_(k l)))) \
    &= (-mu + lambda log deformationjacobian) (partial rightcauchygreen^(-1)_(i j))/ (partial rightcauchygreen_(k l)) + lambda (partial log deformationjacobian)/(partial rightcauchygreen_(k l)) rightcauchygreen^(-1)_(i j)
$

We have two terms to derive: $(partial log deformationjacobian)/(partial rightcauchygreen_(k l))$ and $(partial rightcauchygreen^(-1)_(i j))/ (partial rightcauchygreen_(k l))$

$
  (partial log deformationjacobian)/(partial rightcauchygreen_(k l)) 
    &= (partial log sqrt(det(rightcauchygreen)))/(partial rightcauchygreen_(k l))\
    &= 1/2 (partial log det(rightcauchygreen))/(partial rightcauchygreen_(k l))\
    &= 1/2 rightcauchygreen^(-1)_(k l)
$

and

$
  (partial rightcauchygreen^(-1)_(i j))/ (partial rightcauchygreen_(k l)) = -1/2 (rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j))
$

Then,
#mybox(title:"Lagrangian Elasticity Tensor")[
$
  elasticitytensor_(i j k l) 
    &=(-mu + lambda log deformationjacobian) /2 rightcauchygreen^(-1)_(k l) - lambda /2 (rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j)) rightcauchygreen^(-1)_(i j)
$
]