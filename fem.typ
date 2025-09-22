#import "variables.typ": *
#import "box.typ": *

= Continuum Mechanics

Affine map between initial position $undefposition$ and current position $position$:
$
  phi(undefposition) &= deformationgradient undefposition + bold(t) \
  &= position
$

Derivation with respect to the rest position:

$
  (partial phi(undefposition))/(partial undefposition) &= partial/(partial undefposition)(deformationgradient undefposition + bold(t)) \
  &= deformationgradient
$

$
  deformationgradient = (partial position)/(partial undefposition)
$

#property(title:"Deformation Gradient in 2D")[
$
  deformationgradient = mat(
    (partial position_x)/(partial undefposition_x), (partial position_x)/(partial undefposition_y);
    (partial position_y)/(partial undefposition_x), (partial position_y)/(partial undefposition_y);
  )
$
]

#property(title:"Deformation Gradient in 3D")[
$
  deformationgradient = mat(
    (partial position_x)/(partial undefposition_x), (partial position_x)/(partial undefposition_y), (partial position_x)/(partial undefposition_z);
    (partial position_y)/(partial undefposition_x), (partial position_y)/(partial undefposition_y), (partial position_y)/(partial undefposition_z);
    (partial position_z)/(partial undefposition_x), (partial position_z)/(partial undefposition_y), (partial position_z)/(partial undefposition_z);
  )
$
]

#definition(title:"Diplacement")[
$  
  displacement = position - undefposition
$
]

$
  position = undefposition + displacement
$

#property[
$
  deformationgradient = (partial position)/(partial undefposition) &= partial/(partial undefposition) (undefposition + displacement) \
  &= identity + (partial displacement)/(partial undefposition)
$
]

#definition(title:"Right Cauchy-Green tensor")[
$
  rightcauchygreen = deformationgradient^T deformationgradient
$
]

#definition(title:"Green's strain")[
$
  greenstrain = 1/2 (deformationgradient^T deformationgradient - identity)
$

$
  greenstrain &= 1/2 (deformationgradient^T deformationgradient - I) \
  &= 1/2 ((identity + (partial displacement)/(partial undefposition))^T (identity + (partial displacement)/(partial undefposition)) - identity) \
  &= 1/2 ( ((partial displacement)/(partial undefposition)) + ((partial displacement)/(partial undefposition))^T + ((partial displacement)/(partial undefposition))^T ((partial displacement)/(partial undefposition)))
$
]

#property(title:"Infinitesimal deformation")[
For infinitesimal deformation:

$
  greenstrain &= 1/2 ( ((partial displacement)/(partial undefposition)) + ((partial displacement)/(partial undefposition))^T + ((partial displacement)/(partial undefposition))^T ((partial displacement)/(partial undefposition))) \
  & approx 1/2 ( ((partial displacement)/(partial undefposition)) + ((partial displacement)/(partial undefposition))^T) 
$
]

#definition(title:"Linear strain tensor")[
$
  linearstraintensor = 1/2 ( ((partial displacement)/(partial undefposition)) + ((partial displacement)/(partial undefposition))^T)
$ <linear_strain_tensor>
]

#property(title:"Linear strain tensor in 2D")[
$
  linearstraintensor = mat(
    linearstraintensor_(11), linearstraintensor_(12);
    linearstraintensor_(21), linearstraintensor_(22);
  ) =
  mat(
    (partial displacement_x)/(partial undefposition_x), 1/2 ((partial displacement_x)/(partial undefposition_y) + (partial displacement_y)/(partial undefposition_x));
    1/2 ((partial displacement_x)/(partial undefposition_y) + (partial displacement_y)/(partial undefposition_x)), (partial displacement_y)/(partial undefposition_y);
  )
$ <linear_strain_tensor_2D>
]

#property(title:"Linear strain tensor in 3D")[
$
  linearstraintensor = mat(
    linearstraintensor_(11), linearstraintensor_(12), linearstraintensor_(13);
    linearstraintensor_(21), linearstraintensor_(22), linearstraintensor_(23);
    linearstraintensor_(31), linearstraintensor_(32), linearstraintensor_(33);
  ) =
  mat(
    (partial displacement_x)/(partial undefposition_x), 1/2 ((partial displacement_x)/(partial undefposition_y) + (partial displacement_y)/(partial undefposition_x)), 1/2 ((partial displacement_x)/(partial undefposition_z) + (partial displacement_z)/(partial undefposition_x));
    1/2 ((partial displacement_x)/(partial undefposition_y) + (partial displacement_y)/(partial undefposition_x)), (partial displacement_y)/(partial undefposition_y), 1/2 ((partial displacement_z)/(partial undefposition_y) + (partial displacement_y)/(partial undefposition_z));
    1/2 ((partial displacement_x)/(partial undefposition_z) + (partial displacement_z)/(partial undefposition_x)), 1/2 ((partial displacement_z)/(partial undefposition_y) + (partial displacement_y)/(partial undefposition_z)), (partial displacement_z)/(partial undefposition_z);
  )
$ <linear_strain_tensor_3D>
]

#definition(title:"Voigt notation in 2D")[

$
  tensor1(linearstraintensor) = mat(linearstraintensor_(11); linearstraintensor_(22); 2 linearstraintensor_(12))
$ <voigt_notation_2D>
]

#definition(title:"Voigt notation in 3D")[

$
  tensor1(linearstraintensor) = mat(linearstraintensor_(11); linearstraintensor_(22); linearstraintensor_(33); 2 linearstraintensor_(23); 2 linearstraintensor_(13); 2 linearstraintensor_(12))
$ <voigt_notation_3D>
]

#property(title:"Voigt notation of the linear strain in 3D")[
  Based on @linear_strain_tensor_3D and @voigt_notation_3D:
  $
  tensor1(linearstraintensor) = mat(
    (partial displacement_1)/(partial undefposition_1); (partial displacement_2)/(partial undefposition_2); (partial displacement_3)/(partial undefposition_3); 
    (partial displacement_3)/(partial undefposition_2) + (partial displacement_2)/(partial undefposition_3);
    (partial displacement_1)/(partial undefposition_3) + (partial displacement_3)/(partial undefposition_1); (partial displacement_1)/(partial undefposition_2) + (partial displacement_2)/(partial undefposition_1))
$<voigt_linear_strain_3D>
] 


#definition(title:"Cauchy stress tensor")[
$
  tensor2(cauchystress)
$
is a 2nd-order tensor
]

#definition(title: "Hooke's law")[
$
  cauchystresscomponent_(i j) = sum_k sum_l C_(i j k l) linearstraintensorcomponent_(k l)
$

$tensor4(bold(C))$ is a 4th-order elasticity tensor.

Using Einstein summation notation:

$
  cauchystresscomponent_(i j) = C_(i j k l) linearstraintensorcomponent_(k l)
$
]

#property(title:"Symmetries of the elasticity tensor")[
  Minor symmetries:
  $
    C_(i j k l) = C_(j i k l) = C_(i j l k)
  $

  Major symmetry:
  $
    C_(i j k l) = C_(k l i j)
  $

  Due to these symmetries, $tensor4(bold(C))$ has only 21 independent components.

  Then, the elasticity tensor can be expressed using the Voigt notation:

  $
    tensor2(bold(C)) = mat(
      C_(1111) , C_(1122) , C_(1133) , C_(1123) , C_(1131) , C_(1112); 
      C_(2211) , C_(2222) , C_(2233) , C_(2223) , C_(2231) , C_(2212); 
      C_(3311) , C_(3322) , C_(3333) , C_(3323) , C_(3331) , C_(3312); 
      C_(2311) , C_(2322) , C_(2333) , C_(2323) , C_(2331) , C_(2312); 
      C_(3111) , C_(3122) , C_(3133) , C_(3123) , C_(3131) , C_(3112); 
      C_(1211) , C_(1222) , C_(1233) , C_(1223) , C_(1231) , C_(1212)
    )
  $

  $tensor2(bold(C))$ is a symmetric $6 times 6$ matrix.

  Hooke's law can be written in terms of tensors:

  $
    tensor1(cauchystress) = tensor2(bold(C)) thick tensor1(linearstraintensor)
  $
]

#definition(title:"Orthotropic materials")[
  $
    tensor2(bold(C)) = mat(
      C_(1111) , C_(1122) , C_(1133) , 0 , 0 , 0; 
      C_(2211) , C_(2222) , C_(2233) , 0 , 0 , 0; 
      C_(3311) , C_(3322) , C_(3333) , 0 , 0 , 0; 
      0 , 0 , 0 , C_(2323) , 0 , 0; 
      0 , 0 , 0 , 0, C_(3131) , 0; 
      0 , 0 , 0 , 0 , 0 , C_(1212)
    )
  $
]

#definition(title:"Isotropic materials")[
$
  tensor2(bold(C)) = youngmodulus / ((1 + poissonratio)(1-2 poissonratio)) mat(
      1 - poissonratio, poissonratio , poissonratio , 0 , 0 , 0; 
      poissonratio , 1 - poissonratio , poissonratio , 0 , 0 , 0; 
      poissonratio , poissonratio , 1 - poissonratio , 0 , 0 , 0; 
      0 , 0 , 0 , (1-2 poissonratio)/2 , 0 , 0; 
      0 , 0 , 0 , 0, (1-2 poissonratio)/2 , 0; 
      0 , 0 , 0 , 0 , 0 , (1-2 poissonratio)/2
    )
$
]

$
  mu &= youngmodulus / (2 ( 1 + poissonratio)) \
  lambda &= (youngmodulus poissonratio )/ ( (1+poissonratio)(1-(d-1)poissonratio))
$

$
  lambda^((2)) &= (youngmodulus poissonratio )/ ( (1+poissonratio)(1-poissonratio))\
  lambda^((3)) &= (youngmodulus poissonratio )/ ( (1+poissonratio)(1-2 poissonratio))
$

$
  tensor2(bold(C)) = lambda tensor2(bold(I)_text("vol")) + 2 mu tensor2(bold(I)_text("dev"))
$




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
