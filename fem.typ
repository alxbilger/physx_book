#import "variables.typ": *
#import "box.typ": *




= Finite Element Method


$p$ dimension of the physical space

$r$ dimension of the reference space

$n_e$ number of nodes in the element

== Space Transformation

Reference coordinates: $referenceposition in bb(R)^r$

Physical coordinates: $position = position(referenceposition) in bb(R)^p$

The Jacobian matrix:
$
  tensor2(bold(J)) = (partial position)/(partial referenceposition) in bb(R)^(p times r)
$

== Shape functions

$
  N(referenceposition) = mat(N_1 (referenceposition), ..., N_n_e (referenceposition))^T
$

$
position^text("element") = mat(position^text("element")_1, ..., position^text("element")_N)^T
$

$
  position(referenceposition) = sum_i^(n_e) N_i (referenceposition) position^text("element")_i
$

$
tensor2(bold(J)) 
= (partial position)/(partial referenceposition) 
= (partial  sum_i N_i (referenceposition) position^text("element")_i)/(partial referenceposition)
= sum_i (partial  N_i (referenceposition) position^text("element")_i)/(partial referenceposition)
$

$
  J_(alpha beta) = (partial position_alpha)/(partial referenceposition_beta)
  = (partial sum_i N_i (referenceposition) position^text("element")_i_alpha)/(partial referenceposition_beta)
  = sum_i (partial N_i (referenceposition))/(partial referenceposition_beta) position^text("element")_i_alpha
$


$
  (partial N_i)/(partial position) in bb(R)^p
$

$
  (partial N_i)/(partial referenceposition) in bb(R)^r
$

$
  (partial N_i)/(partial position_j) = sum_k^r (partial N_i)/(partial referenceposition_k) (partial referenceposition_k)/(partial position_j)
$

In matrix form:

$
  (partial N_i)/(partial position) = ((partial referenceposition)/(partial position))^T (partial N_i)/(partial referenceposition) 
$

$
  ((partial referenceposition)/(partial position))^T in bb(R)^(p times r)
$

== Linear Tetrahedron

For a linear tetrahedron:

#definition(title: "Linear shape functions")[
$forall i in {1,2,3,4}$
$
  N_i (position) = a_i + b_i position_x + c_i position_y + d_i position_z
$
]

#property(title:"Derivative of shape functions")[
$
  (partial N_i)/(partial position_x) = b_i
$
$
  (partial N_i)/(partial position_y) = c_i
$
$
  (partial N_i)/(partial position_z) = d_i
$

Therefore:

$
  (partial N_i)/(partial position) = mat(b_i;c_i;d_i)
$
]

#definition(title: "Linear interpolation using shape functions")[
$
  displacement(position) = sum_(i=1)^4 N_i (position) dot displacement_i
$
]

$
& cases(
  displacement_1 = sum_(i=1)^4 N_i (position_1) dot displacement_i,
  displacement_2 = sum_(i=1)^4 N_i (position_2) dot displacement_i,
  displacement_3 = sum_(i=1)^4 N_i (position_3) dot displacement_i,
  displacement_4 = sum_(i=1)^4 N_i (position_4) dot displacement_i
) \
<=> & mat(
  N_1(position_1), N_2(position_1), N_3(position_1), N_4(position_1);
  N_1(position_2), N_2(position_2), N_3(position_2), N_4(position_2);
  N_1(position_3), N_2(position_3), N_3(position_3), N_4(position_3);
  N_1(position_4), N_2(position_4), N_3(position_4), N_4(position_4);
) mat(displacement_1; displacement_2; displacement_3; displacement_4)
= mat(displacement_1; displacement_2; displacement_3; displacement_4)\
<=> & mat(
  N_1(position_1), N_2(position_1), N_3(position_1), N_4(position_1);
  N_1(position_2), N_2(position_2), N_3(position_2), N_4(position_2);
  N_1(position_3), N_2(position_3), N_3(position_3), N_4(position_3);
  N_1(position_4), N_2(position_4), N_3(position_4), N_4(position_4);
) = mat(
    1,0,0,0;
    0,1,0,0;
    0,0,1,0;
    0,0,0,1
  )\
  <=> &
  mat(
  1, position_1_x, position_1_y, position_1_z;
  1, position_2_x, position_2_y, position_2_z;
  1, position_3_x, position_3_y, position_3_z;
  1, position_4_x, position_4_y, position_4_z;
  ) 
  mat(
    a_1, a_2, a_3, a_4;
    b_1, b_2, b_3, b_4;
    c_1, c_2, c_3, c_4;
    d_1, d_2, d_3, d_4
  )
  =
  mat(
    1,0,0,0;
    0,1,0,0;
    0,0,1,0;
    0,0,0,1
  )
$

#result(title:"Values of the constants in the shape functions")[
$
  mat(
    a_1, a_2, a_3, a_4;
    b_1, b_2, b_3, b_4;
    c_1, c_2, c_3, c_4;
    d_1, d_2, d_3, d_4
  ) = mat(
  1, position_1_x, position_1_y, position_1_z;
  1, position_2_x, position_2_y, position_2_z;
  1, position_3_x, position_3_y, position_3_z;
  1, position_4_x, position_4_y, position_4_z;
  )^(-1)
$
]

#property(title:"Linear strain in a linear tetrahedron")[

  Based on @voigt_linear_strain_3D:
  $
  tensor1(linearstraintensor) &= mat(
    (partial displacement_x)/(partial undefposition_x); (partial displacement_y)/(partial undefposition_y); (partial displacement_z)/(partial undefposition_z); 
    (partial displacement_z)/(partial undefposition_y) + (partial displacement_y)/(partial undefposition_z);
    (partial displacement_x)/(partial undefposition_z) + (partial displacement_z)/(partial undefposition_x); (partial displacement_x)/(partial undefposition_y) + (partial displacement_y)/(partial undefposition_x)) =
  mat(
    sum_(i=1)^4 (partial N_i)/(partial undefposition_x) dot displacement_i_x;
    sum_(i=1)^4 (partial N_i)/(partial undefposition_y) dot displacement_i_y;
    sum_(i=1)^4 (partial N_i)/(partial undefposition_z) dot displacement_i_z;
    sum_(i=1)^4 (partial N_i)/(partial undefposition_y) dot displacement_i_z + sum_(i=1)^4 (partial N_i)/(partial undefposition_z) dot displacement_i_y;
    sum_(i=1)^4 (partial N_i)/(partial undefposition_z) dot displacement_i_x + sum_(i=1)^4 (partial N_i)/(partial undefposition_x) dot displacement_i_z;
    sum_(i=1)^4 (partial N_i)/(partial undefposition_y) dot displacement_i_x + sum_(i=1)^4 (partial N_i)/(partial undefposition_x) dot displacement_i_y;
  ) \
  &= mat(
    (partial N_1)/(partial undefposition_x), 0, 0, (partial N_2)/(partial undefposition_x), 0, 0, (partial N_3)/(partial undefposition_x), 0, 0, (partial N_4)/(partial undefposition_x), 0, 0;
    0, (partial N_1)/(partial undefposition_y), 0, 0, (partial N_2)/(partial undefposition_y), 0, 0, (partial N_3)/(partial undefposition_y), 0, 0, (partial N_4)/(partial undefposition_y), 0;
    0, 0, (partial N_1)/(partial undefposition_z), 0, 0, (partial N_2)/(partial undefposition_z), 0, 0, (partial N_3)/(partial undefposition_z), 0, 0, (partial N_4)/(partial undefposition_z);
    0, (partial N_1)/(partial undefposition_z), (partial N_1)/(partial undefposition_y), 0, (partial N_2)/(partial undefposition_z), (partial N_2)/(partial undefposition_y), 0, (partial N_3)/(partial undefposition_z), (partial N_3)/(partial undefposition_y), 0, (partial N_4)/(partial undefposition_z), (partial N_4)/(partial undefposition_y);
    (partial N_1)/(partial undefposition_z), 0, (partial N_1)/(partial undefposition_x), (partial N_2)/(partial undefposition_z), 0, (partial N_2)/(partial undefposition_x), (partial N_3)/(partial undefposition_z), 0, (partial N_3)/(partial undefposition_x), (partial N_4)/(partial undefposition_z), 0, (partial N_4)/(partial undefposition_x);
    (partial N_1)/(partial undefposition_y), (partial N_1)/(partial undefposition_x), 0, (partial N_2)/(partial undefposition_y), (partial N_2)/(partial undefposition_x), 0, (partial N_3)/(partial undefposition_y), (partial N_3)/(partial undefposition_x), 0, (partial N_4)/(partial undefposition_y), (partial N_4)/(partial undefposition_x), 0
  ) 
  mat(u_1_1; u_1_2; u_1_3; u_2_1; u_2_2; u_2_3; u_3_1; u_3_2; u_3_3; u_4_1; u_4_2; u_4_3; ) \
  &= tensor2(straindisplacement) thick tensor1(bold(d))
  $
]

#definition(title:"Displacement vector")[
$tensor1(bold(d))$ is the displacement vector
]

#definition(title:"Strain displacement matrix")[
$tensor2(straindisplacement)$ is the strain displacement matrix 
]

From the derivatives of the shape functions:

$
  tensor2(straindisplacement) = mat(
    b_1, 0, 0, b_2, 0, 0, b_3, 0, 0, b_4, 0, 0;
    0, c_1, 0, 0, c_2, 0, 0, c_3, 0, 0, c_4, 0;
    0, 0, d_1, 0, 0, d_2, 0, 0, d_3, 0, 0, d_4;
    0, d_1, c_1, 0, d_2, c_2, 0, d_3, c_3, 0, d_4, c_4;
    d_1, 0, b_1, d_2, 0, b_2, d_3, 0, b_3, d_4, 0, b_4;
    c_1, b_1, 0, c_2, b_2, 0, c_3, b_3, 0, c_4, b_4, 0
  ) 
$

== Forces in an Element (Total Lagrangian Formulation)

If we apply @total_deformation_energy_total_lagrangian to the finite element, the total internal strain energy in a finite element is

$
  potentialenergy_e = integral_(domain_e_0) undefstrainenergydensity(deformationgradient) dif undefvolume
$ <total_internal_strain_energy>

#definition(title:"Internal Force")[
The internal force in a finite element comes from the variation of the strain energy:

$
  forceelement (position) = (partial potentialenergy_e)/(partial position) = (partial potentialenergy_e)/(partial (undefposition + displacement)) = (partial potentialenergy_e)/(partial displacement)
$ <internal_force_element>
]

#examplebox(title:"4-nodes element")[
  In a 4-nodes elements:
  $
  forceelement (position) = mat(
    (partial undefstrainenergydensity_3)/(partial displacement_0),
    (partial undefstrainenergydensity_3)/(partial displacement_1),
    (partial undefstrainenergydensity_3)/(partial displacement_2),
    (partial undefstrainenergydensity_3)/(partial displacement_3)
  )^T
  $

  In 3D, displacement $displacement$ has 3 components $[displacement_x, displacement_y, displacement_z]$. It results in a force vector of (4 nodes $times$ 3 components) $=$ 12 scalars:

  $
  forceelement (position) = \ mat(
    (partial undefstrainenergydensity_3)/(partial displacement_0_x),
    (partial undefstrainenergydensity_3)/(partial displacement_0_y),
    (partial undefstrainenergydensity_3)/(partial displacement_0_z),
    (partial undefstrainenergydensity_3)/(partial displacement_1_x),
    (partial undefstrainenergydensity_3)/(partial displacement_1_y),
    (partial undefstrainenergydensity_3)/(partial displacement_1_z),
    (partial undefstrainenergydensity_3)/(partial displacement_2_x),
    (partial undefstrainenergydensity_3)/(partial displacement_2_y),
    (partial undefstrainenergydensity_3)/(partial displacement_2_z),
    (partial undefstrainenergydensity_3)/(partial displacement_3_x),
    (partial undefstrainenergydensity_3)/(partial displacement_3_y),
    (partial undefstrainenergydensity_3)/(partial displacement_3_z)
  )^T
  $
]

#definition(title:"Index Notation")[
  $
    forceelement_b_k = (partial undefstrainenergydensity)/(partial displacement_b_k)
  $ <index_notation_force>

  $b$ is the index of the node in the element. $k$ is the index of the coordinate in the vector $u_b$
]

Substituting the internal strain energy (@total_internal_strain_energy) in the expression of the internal force (@internal_force_element):
$
  forceelement (position) = (partial)/(partial displacement) integral_(domain_e) undefstrainenergydensity(deformationgradient) dif V_0
$

Moving the derivative inside the integral:

$
  forceelement (position) =  integral_(Omega_e_0) (partial undefstrainenergydensity(deformationgradient))/(partial displacement)  dif V_0
$

From the chain rule (@chain_rule_double_dot_product):

$
  (partial undefstrainenergydensity)/(partial displacement) = (partial undefstrainenergydensity) / (partial deformationgradient) : (partial deformationgradient) / (partial displacement)
$

So,

$
  forceelement (position) =  integral_(Omega_e_0) (partial undefstrainenergydensity) / (partial deformationgradient) : (partial deformationgradient) / (partial displacement) dif V_0
$

$(partial undefstrainenergydensity) / (partial deformationgradient)$ is the first Piola-Kirchhoff stress tensor $pk1$ (@pk1).

$
  forceelement (position) = integral_(Omega_e_0) pk1(deformationgradient) : (partial deformationgradient) / (partial displacement) dif V_0
$

$(partial deformationgradient) / (partial displacement)$ is a third-order tensor.

Using @tensor3_double_contraction, it can be written:

$
  forceelement (position) = integral_(Omega_e_0) "vec"((partial deformationgradient) / (partial displacement))^T "vec"(pk1) dif V_0
$


In index notation (see @index_notation_force and @double_dot_product_tensor3):

$
  forceelement_b_k (position) = integral_(Omega_e_0) sum_i sum_j pk1_(i j)(deformationgradient) (partial deformationgradient_(i j)) / (partial displacement_b_k) dif V_0
$

Let's focus on the term $(partial deformationgradient) / (partial displacement)$.

Recall that, in the element:

$
  displacement(undefposition) = sum_i^(n_e) N_i (undefposition) displacement_i
$

Replacing $displacement$ in @deformation_gradient_displacement:

$
  deformationgradient &= tensor2(identity) + (partial )/(partial undefposition)(sum_i^(n_e) N(undefposition) displacement_i) \
  &= tensor2(identity) + sum_i^(n_e) displacement_i (partial N_i (undefposition))/(partial undefposition)
$

In index notation,

$
  deformationgradient_(i j) = delta_(i j) + sum_a^(n_e) displacement_a_i (partial N_a (undefposition))/(partial undefposition_j)
$

Now we want to derivate this expression of $deformationgradient$ with respect to the displacement $displacement_k$ of the nodes in the element:

$
  (partial deformationgradient_(i j))/(partial displacement_b_k) &= (partial)/(partial displacement_b_k) sum_a^(n_e) displacement_a_i (partial N_a (undefposition))/(partial undefposition_j) \
  &=sum_a^(n_e)  (partial)/(partial displacement_b_k) (displacement_a_i (partial N_a (undefposition))/(partial undefposition_j)) \
  &=sum_a^(n_e)  delta_(a b) delta_(i k) (partial N_a (undefposition))/(partial undefposition_j) \
  &= delta_(i k) (partial N_b (undefposition))/(partial undefposition_j)
$ <derivative_deformation_gradient_wrt_displacement_index_notation>

Insert back this expression into the force expression:

$
  forceelement_b_k (position) &= integral_(Omega_e_0) sum_i sum_j pk1_(i j)(deformationgradient) delta_(i k) (partial N_b (undefposition))/(partial undefposition_j) dif V_0 \
  &= integral_(Omega_e_0) sum_j pk1_(k j)(deformationgradient) (partial N_b (undefposition))/(partial undefposition_j) dif V_0 \
  &= integral_(Omega_e_0) (pk1(deformationgradient) (partial N_b (undefposition))/(partial undefposition))_k dif V_0
$

In vector form:
$
  forceelement_b = integral_(Omega_e_0) pk1(deformationgradient) (partial N_b (undefposition))/(partial undefposition) dif V_0
$

Finally, we change the variable to compute the force in the reference element:

$
  forceelement_b = integral_hat(Omega_e) pk1(deformationgradient) (partial N_b (undefposition))/(partial undefposition) det(tensor2(J)) dif hat(V)
$

Using Gauss quadrature:

$
  forceelement_b approx sum_i omega_i pk1(deformationgradient) (partial N_b (undefposition))/(partial undefposition) det(tensor2(J)) 
$

== Hessian

The Hessian (consistent tangent) is the derivative of the force w.r.t. nodal displacements:

$
  stiffness_((b k), (c l)) &= (partial force_b_k)/(partial displacement_(c l)) \
  &= (partial)/(partial displacement_(c l)) integral_(Omega_e_0) sum_j thick pk1_(k j)(deformationgradient) (partial N_b (undefposition))/(partial undefposition_j) dif V_0 \
  &= integral_(Omega_e_0) sum_j thick (partial pk1_(k j)(deformationgradient))/(partial displacement_(c l))  (partial N_b (undefposition))/(partial undefposition_j) dif V_0 \
$

Using the chain rule:

$
  (partial pk1_(k j)(deformationgradient))/(partial displacement_(c l)) = 
  sum_p sum_q (partial pk1_(k j)(deformationgradient))/(partial deformationgradient_(p q)) (partial deformationgradient_(p q))/(partial displacement_(c l))
$

We apply @derivative_deformation_gradient_wrt_displacement_index_notation:

$
  (partial pk1_(k j)(deformationgradient))/(partial displacement_(c l)) &= 
  sum_p sum_q (partial pk1_(k j)(deformationgradient))/(partial deformationgradient_(p q)) delta_(p l) (partial N_c (undefposition))/(partial undefposition_q) \
  &= 
  sum_q (partial pk1_(k j)(deformationgradient))/(partial deformationgradient_(l q)) (partial N_c (undefposition))/(partial undefposition_q)
$

Insert back into the Hessian:

$
  stiffness_((b k), (c l)) 
  &= 
  integral_(Omega_e_0) sum_j thick sum_q (partial pk1_(k j)(deformationgradient))/(partial deformationgradient_(l q)) (partial N_c (undefposition))/(partial undefposition_q)  (partial N_b (undefposition))/(partial undefposition_j) dif V_0 \
  &= 
  integral_(Omega_e_0) sum_j thick sum_q tangentmodulus_(k j l q) (partial N_c (undefposition))/(partial undefposition_q)  (partial N_b (undefposition))/(partial undefposition_j) dif V_0 \
$

For a matrix $A$ and two vectors $u$ and $v$, $u^T A v$ is a scalar:
$
  u^T A v = sum_p sum_q u_p A_(p q) v_q
$

If $u = (partial N_b (undefposition))/(partial undefposition)$ and $v = (partial N_c (undefposition))/(partial undefposition)$, then for a matrix $A$:

$
  u^T A v = sum_j sum_q (partial N_b (undefposition))/(partial undefposition_j) A_(j q) (partial N_c (undefposition))/(partial undefposition_q)
$

If we define $A$ such that $A_(j q) = tangentmodulus_(k j l q)$, then

$
  stiffness_((b k), (c l))
  &= 
  integral_(Omega_e_0) ((partial N_b (undefposition))/(partial undefposition))^T A (partial N_c (undefposition))/(partial undefposition) dif V_0 \
$

This matrix $A$ depends on $k$ and $l$, so let's denote it $tensor2(A)^(k l)$:

$
  stiffness_((b k), (c l))
  &= 
  integral_(Omega_e_0) ((partial N_b (undefposition))/(partial undefposition))^T tensor2(A)^(k l) (partial N_c (undefposition))/(partial undefposition) dif V_0 \
$

$
tensor2(A)^(k l)_(i j) = tangentmodulus_(k i l j) = (partial pk1_(k i))/(partial deformationgradient_(l j))
$
