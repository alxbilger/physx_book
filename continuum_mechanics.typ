#import "variables.typ": *
#import "box.typ": *

= Continuum Mechanics

A particle $particle$ defined in the body $body$.

Location of a particle $particle$ from $body$ is given as $position=configurationmapping(particle)$.

Motion is a series of configurations. The location of a particle $particle$ at time $t$ is

$
  position = configurationmapping(particle, t)
$

Reference configuration when $t=0$:

$
  undefposition = configurationmapping(particle, 0)
$

We deduce:

$
  position = configurationmapping(configurationmapping^(-1)(undefposition, 0), t)
$

It is often assumed that the configuration of $body$ at the begining of the simulation is equivalente to the reference configuration ($particle=undefposition$). Therefore:

$
  position = configurationmapping(undefposition, t)
$

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

#definition(title:"Jacobian")[
  $
    deformationjacobian = det(deformationgradient)
  $
]

#property(title:"Not-null jacobian")[
  $configurationmapping$ is a one-to-one mapping, so:
  $
    J != 0
  $
]

#property(title:"Self penetration")[
  To prevent self penetration of the body:
  $
    J > 0
  $
]

#property(title:"Inversion")[
  Because of the previous properties, the inverse of $deformationgradient$ exists.
]

#definition(title:"Diplacement")[
$  
  displacement(t, undefposition) = position(t) - undefposition
$
]

$
  position(t, undefposition) = undefposition + displacement(t, undefposition)
$

#property[
$
  deformationgradient = (partial position)/(partial undefposition) &= partial/(partial undefposition) (undefposition + displacement) \
  &= identity + (partial displacement)/(partial undefposition)
$ <deformation_gradient_displacement>
]

#definition(title:"Displacement gradient")[
  From the previous property, $(partial displacement)/(partial undefposition)$ is called the displacement gradient.
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

== Balance of Mass

No change of mass: $dot(mass)=0$

$
  cases(
    d mass(undefposition) = density_0 d V \
    d mass(position) = density d v
  ) &<=>  density_0 d V = density d v\
  & <=> density_0 = deformationjacobian density
$

== Balance of Linear and Angular Momentum

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

#definition(title:"Strain energy density")[
  We introduce the strain energy density function $strainenergydensity(undefposition)$ which measures the strain energy per unit of undeformed volume on an infinitesimal domain $dif V$ around the material point $undefposition$.
]

#property(title:"Function of deformation gradient")[
  It is expected that strain energy density function $strainenergydensity$ is a function of the deformation gradient $deformationgradient$.
]

#property(title:"Total Deformation Energy")[
  $
    potentialenergy = integral_domain_0 strainenergydensity(deformationgradient) dif undefposition
  $ <total_deformation_energy>
]

#definition(title:"Force from strain energy")[
  $
    force = - (partial potentialenergy)/(partial displacement)
  $
]