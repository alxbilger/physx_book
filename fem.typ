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
