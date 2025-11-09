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
$ <invariant1>

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
  invariant2 = 1/2 (tr(rightcauchygreen)^2 - tr(rightcauchygreen^2)) = 1/2 (invariant1^2 - tr(rightcauchygreen)^2)
$ <invariant2>
]

#property(title:"Derivative w.r.t. " + $rightcauchygreen$)[
  $
    (partial invariant2)/(partial rightcauchygreen) = tr(rightcauchygreen) tensor2(identity) - rightcauchygreen = invariant1 tensor2(identity) - rightcauchygreen
  $ <derivative_invariant2_wrt_rightcauchygreen>
]

#property(title:"Derivative w.r.t. " + $deformationgradient$)[

  Insert the following expression on https://www.matrixcalculus.org/:

  ```
  (1/2)*(tr(F'*F)^2 - tr((F'*F)*(F'*F)))
  ```

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
$ <invariant3>
]

#property(title:"Relation to the Jacobian")[
  $
    invariant3 = det(rightcauchygreen) = det(deformationgradient^T deformationgradient) = det(deformationgradient^T) det(deformationgradient) = det(deformationgradient)^2 = deformationjacobian^2
  $ <invariant3_deformation_jacobian>
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
$

From @derivative_invariant1_wrt_deformationgradient, @derivative_invariant2_wrt_deformationgradient and @derivative_invariant3_wrt_deformationgradient:
$
  pk1
    = 2(partial undefstrainenergydensity)/(partial invariant1) deformationgradient
    + 2(partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) deformationgradient - deformationgradient rightcauchygreen)
    + 2(partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) deformationgradient rightcauchygreen^(-1)
$ <pk1_as_function_of_invariants>

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


==== Tangent Modulus Tensor

Substituting the expression of $pk1$ into @tangent_modulus:

$
  tangentmodulus 
    &= (partial pk1(deformationgradient))/(partial deformationgradient) \
    &= (partial)/(partial deformationgradient)( 2(partial undefstrainenergydensity)/(partial invariant1) deformationgradient
    + 2(partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) deformationgradient - deformationgradient rightcauchygreen)
    + 2(partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) deformationgradient rightcauchygreen^(-1)) \
    &= 2(partial)/(partial deformationgradient)((partial undefstrainenergydensity)/(partial invariant1) deformationgradient
    + (partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) deformationgradient - deformationgradient rightcauchygreen)
    + (partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) deformationgradient rightcauchygreen^(-1)) \
    &= 2( (partial)/(partial deformationgradient)((partial undefstrainenergydensity)/(partial invariant1) deformationgradient)
    + (partial)/(partial deformationgradient)((partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) deformationgradient - deformationgradient rightcauchygreen))
    + (partial)/(partial deformationgradient)((partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) deformationgradient rightcauchygreen^(-1)))
$

3 terms to compute.

First term:

$
  (partial)/(partial deformationgradient)((partial undefstrainenergydensity)/(partial invariant1) deformationgradient) =

$
to be continued...

==== Elasticity Tensor

Recall that $elasticitytensor = 2 (partial pk2)/(partial rightcauchygreen)$ (@elasticity_tensor_rightcauchygreen).

$
  elasticitytensor = 2 (partial)/(partial rightcauchygreen) (2 (partial undefstrainenergydensity)/(partial invariant1) tensor2(identity)
   + 2 (partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) tensor2(identity) - rightcauchygreen)
   + 2 (partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) rightcauchygreen^(-1))
$

to be continued...

== Invariants of $tilde(rightcauchygreen)$

#mybox(title:"Isochoric first invariant")[
Substituting @isochoric_right_cauchy_green into @invariant1:

$
  invariant1 = tr(rightcauchygreen) = tr(deformationjacobian^(2/dimension) tilde(rightcauchygreen)) = deformationjacobian^(2/dimension) tr( tilde(rightcauchygreen)) = deformationjacobian^(2/dimension) isochoricinvariant1
$

Therefore,

$
  isochoricinvariant1 = deformationjacobian^(-2/dimension) invariant1
$
]


#mybox(title:"Isochoric second invariant")[
  Substituting @isochoric_right_cauchy_green into @invariant2:

  $
    invariant2 
    &= 1/2 (invariant1^2 - tr(rightcauchygreen^2))\
    &= 1/2 ((deformationjacobian^(2/dimension) isochoricinvariant1)^2 - tr((deformationjacobian^(2/dimension) tilde(rightcauchygreen))^2))\
    &= 1/2 (deformationjacobian^(4/dimension) isochoricinvariant1^2 - deformationjacobian^(4/dimension) tr(tilde(rightcauchygreen)^2))\
    &= deformationjacobian^(4/dimension) [ 1/2 (isochoricinvariant1^2 - tr(tilde(rightcauchygreen)^2))]\
    &= deformationjacobian^(4/dimension) isochoricinvariant2
  $

  Therefore,

  $
    isochoricinvariant2 = deformationjacobian^(-4/dimension) invariant2
  $
]

#mybox(title:"Nearly incompressible materials")[
  A common form of the strain energy density is:

  $
    undefstrainenergydensity(invariant1, invariant2, invariant3) = undefstrainenergydensity_"isochoric" (isochoricinvariant1, isochoricinvariant2) + undefstrainenergydensity_"volumetric" (deformationjacobian)
  $ <nearly_incompressible>

  - $undefstrainenergydensity_"isochoric"$ captures distortional (shape-changing) behavior
  - $undefstrainenergydensity_"volumetric"$ penalizes changes in volume and enforces near-incompressibility
]

#mybox(title:"Common forms for " + $undefstrainenergydensity_"volumetric"$ )[
1. Quadratic in $log deformationjacobian$:

$
  undefstrainenergydensity_"volumetric" = bulkmodulus/2 (log(deformationjacobian))^2
$ <volumetric_energy_log>

2. Quadratic in $(deformationjacobian - 1)$

$
  undefstrainenergydensity_"volumetric" = bulkmodulus/2 (deformationjacobian - 1)^2
$
]

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
    &= mu (delta_(i k) delta_(j l) + delta_(i l) delta_(j k)) + lambda delta_(i j) sum_p delta_(p k) delta_(p l) \
    &= mu (delta_(i k) delta_(j l) + delta_(i l) delta_(j k)) + lambda delta_(i j) delta_(k l)
$

]

Due to the minor symmetries of the elasticity tensor (@elasticity_tensor_minor_symmetry_1 and @elasticity_tensor_minor_symmetry_2), it can be written using the Voigt notation. Using the mapping in @voigt_3d,

$
  elasticitytensor_"Voigt" &=
  mat(
      elasticitytensor_(0 0 0 0),elasticitytensor_(0 0 1 1),elasticitytensor_(0 0 2 2),elasticitytensor_(0 0 1 2),elasticitytensor_(0 0 0 2),elasticitytensor_(0 0 0 1);

      elasticitytensor_(1 1 0 0),elasticitytensor_(1 1 1 1),elasticitytensor_(1 1 2 2),elasticitytensor_(1 1 1 2),elasticitytensor_(1 1 0 2),elasticitytensor_(1 1 0 1);

      elasticitytensor_(2 2 0 0),elasticitytensor_(2 2 1 1),elasticitytensor_(2 2 2 2),elasticitytensor_(2 2 1 2),elasticitytensor_(2 2 0 2),elasticitytensor_(2 2 0 1);

      elasticitytensor_(1 2 0 0),elasticitytensor_(1 2 1 1),elasticitytensor_(1 2 2 2),elasticitytensor_(1 2 1 2),elasticitytensor_(1 2 0 2),elasticitytensor_(1 2 0 1);

      elasticitytensor_(0 2 0 0),elasticitytensor_(0 2 1 1),elasticitytensor_(0 2 2 2),elasticitytensor_(0 2 1 2),elasticitytensor_(0 2 0 2),elasticitytensor_(0 2 0 1);

      elasticitytensor_(0 1 0 0),elasticitytensor_(0 1 1 1),elasticitytensor_(0 1 2 2),elasticitytensor_(0 1 1 2),elasticitytensor_(0 1 2 0 2),elasticitytensor_(0 1 0 1);
    )\
    &= mat(
      2 mu + lambda, lambda, lambda, 0, 0, 0;
      lambda, 2 mu + lambda, lambda, 0, 0, 0;
      lambda, lambda, 2 mu + lambda, 0, 0, 0;
      0, 0, 0, 2 mu, 0, 0;
      0, 0, 0, 0, 2 mu, 0;
      0, 0, 0, 0, 0, 2 mu;
    )
$

== Neo Hookean Material

#mybox(title:"Strain Energy")[
$
  undefstrainenergydensity = mu / 2 (invariant1 - dimension) - mu log J + lambda / 2 (log J)^2 
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
  (partial J)/(partial deformationgradient) = J deformationgradient^(-T) = J [1/J "adj"(F)]^T = "adj"(F)^T
$

Substituting $(partial J)/(partial deformationgradient)$:

$
  pk1 &= mu (deformationgradient - 1/J J deformationgradient^(-T)) + lambda / J (log J) J deformationgradient^(-T) \
  &= mu (deformationgradient - deformationgradient^(-T)) + lambda  (log J) deformationgradient^(-T)
$ <pk1_neo_hookean>
]

#mybox(title: "Second Piola-Kirchhoff Stress Tensor")[
  Recall that $invariant3 = deformationjacobian^2$ (@invariant3_deformation_jacobian).

  Then, the strain energy density function (@strain_energy_neohookean) can be written in terms of invariants:

  $
    undefstrainenergydensity = mu / 2 (invariant1 - d) - mu log sqrt(invariant3) + lambda / 2 (log sqrt(invariant3))^2 
  $

  From @pk2_as_function_of_invariants:
  $
    pk2 &= 2 (partial undefstrainenergydensity)/(partial invariant1) tensor2(identity)
   + 2 (partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) tensor2(identity) - rightcauchygreen)
   + 2 (partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) rightcauchygreen^(-1) \
   &= mu (tensor2(identity) - rightcauchygreen^(-1)) + lambda (log deformationjacobian) rightcauchygreen^(-1)
  $ <pk2_neo_hookean>
]

#property(title:"Relationship between Piola-Kirchhoff tensors")[
  If we left-multiply $pk2$ by $deformationgradient$ in @pk2_neo_hookean:
  $
    deformationgradient dot pk2 &= deformationgradient ( mu (tensor2(identity) - rightcauchygreen^(-1)) + lambda (log deformationjacobian) rightcauchygreen^(-1)) \
    &= mu (deformationgradient - deformationgradient rightcauchygreen^(-1)) + lambda (log J) deformationgradient rightcauchygreen^(-1)
  $

  $deformationgradient rightcauchygreen^(-1) = deformationgradient (deformationgradient^T deformationgradient)^(-1) = deformationgradient deformationgradient^(-1) deformationgradient^(-T)= deformationgradient^(-T)$

  Therefore:

  $
    deformationgradient dot pk2 = mu (deformationgradient - deformationgradient^(-T)) + lambda (log J) deformationgradient^(-T)
  $

  Which is the first Piola-Kirchhoff that is computed in @pk1_neo_hookean.

  @pk2 holds.
]

Let's derive the Lagrangian elasticity tensor in index notation. Recall that $elasticitytensor = 2 (partial pk2)/(partial rightcauchygreen)$ (@elasticity_tensor_rightcauchygreen). In index notation, $elasticitytensor_(i j k l) = 2 (partial pk2_(i j))/(partial rightcauchygreen_(k l))$. And the second Piola-Kirchhoff stress tensor (@pk2_neo_hookean) in index notation is $mu (tensor2(identity)_(i j) - rightcauchygreen^(-1)_(i j)) + lambda (log deformationjacobian) rightcauchygreen^(-1)_(i j)$.

$
  elasticitytensor_(i j k l)
    &= 2 (partial pk2_(i j))/(partial rightcauchygreen_(k l)) \
    &= 2 (partial)/(partial rightcauchygreen_(k l))(mu (tensor2(identity)_(i j) - rightcauchygreen^(-1)_(i j)) + lambda (log deformationjacobian) rightcauchygreen^(-1)_(i j)) \
    &= -2 mu (partial rightcauchygreen^(-1)_(i j))/(partial rightcauchygreen_(k l)) + 2 lambda ((partial log deformationjacobian)/(partial rightcauchygreen_(k l)) rightcauchygreen^(-1)_(i j) + log deformationjacobian (partial rightcauchygreen^(-1)_(i j))/ (partial rightcauchygreen_(k l))) \
    &= 2 (-mu + lambda log deformationjacobian) (partial rightcauchygreen^(-1)_(i j))/ (partial rightcauchygreen_(k l)) + 2 lambda (partial log deformationjacobian)/(partial rightcauchygreen_(k l)) rightcauchygreen^(-1)_(i j)
$

We have two terms to derive: $(partial log deformationjacobian)/(partial rightcauchygreen_(k l))$ and $(partial rightcauchygreen^(-1)_(i j))/ (partial rightcauchygreen_(k l))$

$
  (partial log deformationjacobian)/(partial rightcauchygreen_(k l)) 
    &= (partial log sqrt(det(rightcauchygreen)))/(partial rightcauchygreen_(k l))\
    &= 1/2 (partial log det(rightcauchygreen))/(partial rightcauchygreen_(k l))\
    &= 1/2 1/det(rightcauchygreen) (partial det(rightcauchygreen))/(partial rightcauchygreen_(k l))\
$

From @derivative_determinant, $(partial det(rightcauchygreen))/(partial rightcauchygreen) = det(rightcauchygreen) rightcauchygreen^(-T)$. Using indices:

$
  (partial det(rightcauchygreen))/(partial rightcauchygreen_(k l)) = det(rightcauchygreen) rightcauchygreen^(-T)_(k l) = det(rightcauchygreen) rightcauchygreen^(-1)_(l k)
$

Finally,

$
  (partial log deformationjacobian)/(partial rightcauchygreen_(k l)) = 1/2 1/det(rightcauchygreen) det(rightcauchygreen) rightcauchygreen^(-1)_(l k) = 1/2 rightcauchygreen^(-1)_(l k)
$ <derivative_logJ_rightcauchy>

The second term:

$
  (partial rightcauchygreen^(-1)_(i j))/ (partial rightcauchygreen_(k l)) 
  = -1/2 (rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j))
$

Substituting $(partial log deformationjacobian)/(partial rightcauchygreen_(k l))$ and $(partial rightcauchygreen^(-1)_(i j))/ (partial rightcauchygreen_(k l))$:

$
  elasticitytensor_(i j k l)
    &= 2 (-mu + lambda log deformationjacobian) (-1/2 (rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j))) + 2 lambda 1/2 rightcauchygreen^(-1)_(l k) rightcauchygreen^(-1)_(i j) \
    &= (mu - lambda log deformationjacobian)(rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j)) + lambda rightcauchygreen^(-1)_(l k) rightcauchygreen^(-1)_(i j) 
$

#mybox(title:"Lagrangian Elasticity Tensor")[
$
  elasticitytensor_(i j k l) 
    &= (mu - lambda log deformationjacobian)(rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j)) + lambda rightcauchygreen^(-1)_(l k) rightcauchygreen^(-1)_(i j) 
$
]

== Polynomial Hyperelastic Model

#mybox(title:"Strain Energy")[
$
  undefstrainenergydensity = sum_(r,s >= 0) mu_(r s) (invariant1 - dimension)^r (invariant2 - dimension)^s 
$ <strain_energy_polynomial>

According to @bonet1997nonlinear.
]
  
The first Piola-Kirchhoff stress tensor is defined as (@pk1):
$
  pk1 = (partial undefstrainenergydensity) / (partial deformationgradient)
$

Using the chain rule for partial derivatives of $undefstrainenergydensity$ with respect to $deformationgradient$, we compute:

$
  pk1 = &sum_(r,s >= 0) mu_(r s) r(invariant1 - dimension)^(r-1)(invariant2 - dimension)^s (partial invariant1)/(partial deformationgradient) 
    \ + &sum_(r,s >= 0) mu_(r s) s(invariant1 - dimension)^r (invariant2 - dimension)^(s-1) (partial invariant2)/(partial deformationgradient) 
$

Substituting the expressions of the derivatives of the invariants (@derivative_invariant1_wrt_deformationgradient and @derivative_invariant2_wrt_deformationgradient), we obtain:

$
  pk1 = &sum_(r,s >= 0) mu_(r s) r(invariant1 - dimension)^(r-1)(invariant2 - dimension)^s 2 deformationgradient
    \ + &sum_(r,s >= 0) mu_(r s) s(invariant1 - dimension)^r (invariant2 - dimension)^(s-1) 2 (tr(rightcauchygreen) deformationgradient - deformationgradient rightcauchygreen)
$


#mybox(title:"First Piola-Kirchhoff Stress Tensor")[
]

Insert the following expression on https://www.matrixcalculus.org/:

```
a*(tr(F'*F)-3) + b*(1/2*(tr(F'*F)^2-tr(F'*F*F'*F)))
```

== Incompressible Mooney-Rivlin

#mybox(title:"Strain Energy")[
Mooney-Rivlin material is a special case of the polynomial material where only $mu_(01)$ and $mu_(10) != 0$. It results in:

$
  undefstrainenergydensity = mu_(10) (invariant1 - dimension) + mu_(01) (invariant2 - dimension)
$ <incompressible_mooney_rivlin>
]

This energy is defined in terms of invariants. @pk1_as_function_of_invariants applies:

$
  pk1
    = 2(partial undefstrainenergydensity)/(partial invariant1) deformationgradient
    + 2(partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) deformationgradient - deformationgradient rightcauchygreen)
    + 2(partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) deformationgradient rightcauchygreen^(-1)
$

Let's compute the 3 terms $(partial undefstrainenergydensity)/(partial invariant1)$, $(partial undefstrainenergydensity)/(partial invariant2)$ and $(partial undefstrainenergydensity)/(partial invariant3)$:

$
  (partial undefstrainenergydensity)/(partial invariant1) = mu_(10)
$

$
  (partial undefstrainenergydensity)/(partial invariant2) = mu_(01)
$

$
  (partial undefstrainenergydensity)/(partial invariant3) = 0
$

Substituting the 3 terms into the expression of the first Piola-Kirchhoff stress tensor (@pk1_as_function_of_invariants):


#mybox(title:"First Piola-Kirchhoff Stress Tensor")[

$
pk1
  = 2 mu_(10) deformationgradient
  + 2 mu_(01) (tr(rightcauchygreen) deformationgradient - deformationgradient rightcauchygreen)
$
]

Similarly, @pk2_as_function_of_invariants applies:

$
  pk2 = 2 (partial undefstrainenergydensity)/(partial invariant1) tensor2(identity)
   + 2 (partial undefstrainenergydensity)/(partial invariant2) (tr(rightcauchygreen) tensor2(identity) - rightcauchygreen)
   + 2 (partial undefstrainenergydensity)/(partial invariant3) det(rightcauchygreen) rightcauchygreen^(-1)
$

Substituting the 3 terms into the expression of the first Piola-Kirchhoff stress tensor (@pk2_as_function_of_invariants):

#mybox(title:"Second Piola-Kirchhoff Stress Tensor")[

$
pk2 = 2 mu_(10) tensor2(identity)
   + 2 mu_(01) (tr(rightcauchygreen) tensor2(identity) - rightcauchygreen)
$

]

Elasticity Tensor (@elasticity_tensor_rightcauchygreen):
$
  elasticitytensor 
    &= 2(partial pk2)/(partial rightcauchygreen) \
    &= 4 mu_(01) (partial)/(partial rightcauchygreen)(tr(rightcauchygreen) tensor2(identity) - rightcauchygreen)
$

The first term in index notation:

$
  ((partial)/(partial rightcauchygreen)(tr(rightcauchygreen) tensor2(identity)))_(i j k l) 
  &= (partial (tr(rightcauchygreen) identity)_(i j))/(partial rightcauchygreen_(k l)) \
  &= (partial delta_(i j) sum_p rightcauchygreen_(p p))/(partial rightcauchygreen_(k l)) \
  &= delta_(i j) sum_p (partial rightcauchygreen_(p p))/(partial rightcauchygreen_(k l)) \
  &= delta_(i j) sum_p delta_(p k) delta_(p l) \
  &= delta_(i j) delta_(k l)
$

The second term in index notation:

$
  ((partial rightcauchygreen)/(partial rightcauchygreen))_(i j k l) = (partial rightcauchygreen_(i j))/(partial rightcauchygreen_(k l)) 
  = 1/2 (delta_(i k) delta_(j l) + delta_(i l) delta_(j k))
$

Finally, the elasticity tensor in index notation:

$
  elasticitytensor_(i j k l) = 4 mu_(01) (delta_(i j) delta_(k l) - 1/2 (delta_(i k) delta_(j l) + delta_(i l) delta_(j k)))
$

== Compressible Mooney-Rivlin

#mybox(title:"Strain Energy")[

The strain energy density function is based on the isochoric/volumetric decomposition from @nearly_incompressible, where $undefstrainenergydensity_"isochoric"$ is the incompressible strain energy density function (@incompressible_mooney_rivlin) applied on the isochoric invariants.

$
undefstrainenergydensity_"isochoric" 
&= mu_(10) (isochoricinvariant1 - dimension) + mu_(01) (isochoricinvariant2 - dimension)\
&= mu_(10) (deformationjacobian^(-2/dimension) invariant1 - dimension) + mu_(01) (deformationjacobian^(-4/dimension) invariant2 - dimension)
$

where $deformationjacobian$ is the Jacobian (@deformation_jacobian).

$undefstrainenergydensity_"volumetric"$ is defined in @volumetric_energy_log.

It result in:

$
  undefstrainenergydensity = mu_(10) (deformationjacobian^(-2/dimension) invariant1 - dimension) + mu_(01) (deformationjacobian^(-4/dimension) invariant2 - dimension) + kappa/2 log(deformationjacobian)^2
$ <strain_energy_mooney_rivlin>

]

We compute the second Piola-Kirchhoff stress tensor (@pk2_properties) from the strain energy (@strain_energy_mooney_rivlin):

$
  pk2 
  &= 2 (partial undefstrainenergydensity)/(partial rightcauchygreen) \ 
  &= 2 (partial)/(partial rightcauchygreen) (mu_(10) (deformationjacobian^(-2/dimension) invariant1 - dimension) + mu_(01) (deformationjacobian^(-4/dimension) invariant2 - dimension) + kappa/2 log(deformationjacobian)^2) \
  &= 2 (partial)/(partial rightcauchygreen) (mu_(10) deformationjacobian^(-2/dimension) invariant1 + mu_(01) deformationjacobian^(-4/dimension) invariant2 + kappa/2 log(deformationjacobian)^2) \
  &= 2 (mu_(10) (partial deformationjacobian^(-2/dimension) invariant1)/(partial rightcauchygreen) + mu_(01) (partial deformationjacobian^(-4/dimension) invariant2)/(partial rightcauchygreen) + kappa/2 (partial log(deformationjacobian)^2)/(partial rightcauchygreen))
$

We must compute 3 terms.

For the $mu_10$ and $mu_01$ terms, we need the following derivative. For any power $deformationjacobian^alpha$:

$
  (partial deformationjacobian^alpha)/(partial rightcauchygreen) = alpha deformationjacobian^(alpha-1) (partial deformationjacobian)/(partial rightcauchygreen)
$

Since $deformationjacobian = sqrt(invariant3)$ (@invariant3_deformation_jacobian), 
$
  (partial deformationjacobian)/(partial rightcauchygreen) 
  &= (partial sqrt(det(rightcauchygreen)))/(partial rightcauchygreen) \
  &= 1/2 1/sqrt(det(rightcauchygreen)) (partial det(rightcauchygreen))/(partial rightcauchygreen) \
  &= 1/2 1/sqrt(det(rightcauchygreen)) det(rightcauchygreen) rightcauchygreen^(-1) \
  &= 1/2 sqrt(det(rightcauchygreen)) rightcauchygreen^(-1) \
  &= 1/2 deformationjacobian rightcauchygreen^(-1)
$

Substituting into the derivative of $deformationjacobian^alpha$:
$
  (partial deformationjacobian^alpha)/(partial rightcauchygreen) = 1/2 alpha deformationjacobian^(alpha-1) deformationjacobian rightcauchygreen^(-1) = 1/2 alpha deformationjacobian^alpha rightcauchygreen^(-1)
$

By applying the product rule on the $mu_10$-term:
$
  (partial deformationjacobian^(-2/dimension) invariant1)/(partial rightcauchygreen) 
  &= (partial deformationjacobian^(-2/dimension) )/(partial rightcauchygreen) invariant1 + deformationjacobian^(-2/dimension) (partial invariant1)/(partial rightcauchygreen) \
  &= -1/2 2/dimension deformationjacobian^(-2/dimension) rightcauchygreen^(-1) invariant1 + deformationjacobian^(-2/dimension) tensor2(identity) \
  &= deformationjacobian^(-2/dimension)(tensor2(identity) - 1/dimension invariant1 rightcauchygreen^(-1))
$

By applying the product rule on the $mu_01$-term:
$
  (partial deformationjacobian^(-4/dimension) invariant2)/(partial rightcauchygreen)
  &= (partial deformationjacobian^(-4/dimension))/(partial rightcauchygreen) invariant2 + deformationjacobian^(-4/dimension) (partial invariant2)/(partial rightcauchygreen) \
  &= -1/2 4/dimension deformationjacobian^(-4/dimension) rightcauchygreen^(-1) invariant2 + deformationjacobian^(-4/dimension) (tr(rightcauchygreen) tensor2(identity) - rightcauchygreen) \
  &= deformationjacobian^(-4/dimension) (invariant1 tensor2(identity) - rightcauchygreen - 2/dimension rightcauchygreen^(-1) invariant2)
$

Finally, the $bulkmodulus$-term:

$
  (partial log(deformationjacobian)^2)/(partial rightcauchygreen) = 2 log(deformationjacobian) (partial log(deformationjacobian))/(partial rightcauchygreen)
$

Recall that $(partial log(deformationjacobian))/(partial rightcauchygreen) = 1/2 rightcauchygreen^(-T)$ (@derivative_logJ_rightcauchy). Then,

$
  (partial log(deformationjacobian)^2)/(partial rightcauchygreen) = log(deformationjacobian) rightcauchygreen^(-T)
$

Putting all together:

#mybox(title:"Second Piola-Kirchhoff Stress Tensor")[
$
  pk2 = 
  & 2 mu_(10) deformationjacobian^(-2/dimension)(tensor2(identity) - 1/dimension invariant1 rightcauchygreen^(-1)) \ 
  &+ 2 mu_(01) deformationjacobian^(-4/dimension) (invariant1 tensor2(identity) - rightcauchygreen - 2/dimension rightcauchygreen^(-1) invariant2) \
  &+ bulkmodulus log(deformationjacobian) rightcauchygreen^(-T)
$
]

Now we compute the elasticity tensor (@elasticity_tensor_rightcauchygreen).

Let's define

- $pk2^((mu_10)) = deformationjacobian^(-2/dimension)(tensor2(identity) - 1/dimension invariant1 rightcauchygreen^(-1))$
- $pk2^((mu_01)) = deformationjacobian^(-4/dimension) (invariant1 tensor2(identity) - rightcauchygreen - 2/dimension rightcauchygreen^(-1) invariant2)$
- $pk2^((bulkmodulus)) = log(deformationjacobian) rightcauchygreen^(-T)$

such that $pk2 = 2 mu_(10) pk2^((mu_10)) + 2 mu_(01) pk2^((mu_01)) + bulkmodulus pk2^((bulkmodulus))$.

Similarly, we will have $elasticitytensor = 2 mu_(10) elasticitytensor^((mu_10)) + 2 mu_(01) elasticitytensor^((mu_01)) + bulkmodulus elasticitytensor^((bulkmodulus))$ with:
- $elasticitytensor^((mu_(10)))_(i j k l) = 2 (partial pk2^((mu_10))_(i j)) / (partial rightcauchygreen_(k l))$,
- $elasticitytensor^((mu_(01)))_(i j k l) = 2 (partial pk2^((mu_01))_(i j)) / (partial rightcauchygreen_(k l))$,
- $elasticitytensor^((bulkmodulus))_(i j k l) = 2 (partial pk2^((bulkmodulus))_(i j)) / (partial rightcauchygreen_(k l))$

Let's start by differentiating $pk2^((mu_10))$ in index notation:

$
  (partial pk2^((mu_10))_(i j))/(partial rightcauchygreen_(k l))
  &= ((partial deformationjacobian^(-2/dimension) delta_(i j))/(partial rightcauchygreen_(k l))) - 1/dimension ((partial deformationjacobian^(-2/dimension) invariant1 rightcauchygreen^(-1)_(i j))/(partial rightcauchygreen_(k l))) \
  &= -1/dimension delta_(i j) deformationjacobian^(-2/dimension) rightcauchygreen^(-1)_(k l) - 1/dimension ((partial deformationjacobian^(-2/dimension))/(partial rightcauchygreen_(c k)) invariant1 rightcauchygreen^(-1)_(i j) + deformationjacobian^(-2/dimension) (partial invariant1)/(partial rightcauchygreen_(k l)) rightcauchygreen^(-1)_(i j) + deformationjacobian^(-2/dimension) invariant1 (partial rightcauchygreen^(-1)_(i j))/(partial rightcauchygreen_(c k)) ) \
  &= -1/dimension delta_(i j) deformationjacobian^(-2/dimension) rightcauchygreen^(-1)_(k l) - 1/dimension (-1/dimension deformationjacobian^(-2/dimension) rightcauchygreen^(-1)_(k l) invariant1 rightcauchygreen^(-1)_(i j) + deformationjacobian^(-2/dimension) delta_(k l) rightcauchygreen^(-1)_(i j) + deformationjacobian^(-2/dimension) invariant1 (-1/2 (rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j))) ) \
  &= -1/dimension deformationjacobian^(-2/dimension) (delta_(i j) rightcauchygreen^(-1)_(k l) + (delta_(k l) - 1/dimension rightcauchygreen^(-1)_(k l) invariant1) rightcauchygreen^(-1)_(i j) - 1/2 invariant1 (rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j)))
$

Now we differentiate $pk2^((mu_10))$ in index notation:
$
  (partial pk2^((mu_01))_(i j))/(partial rightcauchygreen_(k l))
  &= (partial deformationjacobian^(-4/dimension))/(partial rightcauchygreen_(k l))(invariant1 delta_(i j) - rightcauchygreen_(i j) - 2/dimension rightcauchygreen^(-1)_(i j) invariant2)
  + deformationjacobian^(-4/dimension) (partial)/(partial rightcauchygreen_(k l))(invariant1 delta_(i j) - rightcauchygreen_(i j) - 2/dimension rightcauchygreen^(-1)_(i j) invariant2) \
  &= -2/dimension deformationjacobian^(-4/dimension) rightcauchygreen^(k l) (invariant1 delta_(i j) - rightcauchygreen_(i j) - 2/dimension rightcauchygreen^(-1)_(i j) invariant2)
  + deformationjacobian^(-4/dimension) ( delta_(i j) - delta_(i k) delta_(j l) - 2/dimension ((partial rightcauchygreen^(-1)_(i j))/(partial rightcauchygreen_(k l)) invariant2 + rightcauchygreen^(-1)_(i j) (partial invariant2)/(partial rightcauchygreen_(k l))) \
  &= deformationjacobian^(-4/dimension)(-2/dimension  rightcauchygreen^(k l) (invariant1 delta_(i j) - rightcauchygreen_(i j) - 2/dimension rightcauchygreen^(-1)_(i j) invariant2) +  delta_(i j) - delta_(i k) delta_(j l) \ &- 2/dimension (-1/2 (rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j)) invariant2 + rightcauchygreen^(-1)_(i j) (invariant1 delta_(k l) - rightcauchygreen_(k l))))
$

Finally, the differentiation of $pk2^((bulkmodulus))$:

$
  (partial pk2^((bulkmodulus)))/(partial rightcauchygreen_(k l))
  &= (partial log deformationjacobian rightcauchygreen^(-1)_(i j))/(partial rightcauchygreen_(k l)) \
  &= (partial log deformationjacobian)/(partial rightcauchygreen_(k l)) rightcauchygreen^(-1)_(i j) + log deformationjacobian (partial rightcauchygreen^(-1)_(i j))/(partial rightcauchygreen_(k l)) \
  &= 1/2 rightcauchygreen^(-1)_(k l) rightcauchygreen^(-1)_(i j) + log deformationjacobian (-1/2 (rightcauchygreen^(-1)_(i k) rightcauchygreen^(-1)_(l j) + rightcauchygreen^(-1)_(i l) rightcauchygreen^(-1)_(k j))) \
$