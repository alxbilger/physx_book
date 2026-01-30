#import "variables.typ": *
#import "box.typ": *




= Finite Element Method <section_finite_element_method>

== Definitions

#definition(title:"Physical domain")[
  The physical domain $domain$ is the subset of physical space $RR^p$
  where the physical problem is defined. It is the region in $RR^p$ satisfying all boundary conditions and governing equations. $p$ denotes the dimension of the physical domain (e.g., $p=2$ for planar problems or $p=3$ for 3D problems).
]

#definition(title:"Boundary of the physical domain")[
  The boundary of the physical domain is denoted $boundary$ and is the subset of the physical space $RR^p$ containing points where the physical domain $domain$ meets its "edge". Crucially, $boundary subset RR^p$ and is the location where boundary conditions (e.g., fixed displacements, prescribed forces) are applied.
]

#definition(title:"Boundary conditions")[
  Boundary conditions are physical constraints applied to the boundary of the physical domain $boundary subset RR^p$. They specify the behavior of the solution (e.g., displacement, temperature, pressure) at $boundary$.
]

#definition(title:"Dirichlet boundary conditions")[
  Dirichlet boundary conditions specify fixed values of the solution (e.g., displacement) at the boundary of the physical domain $boundary$. 
]

#definition(title:"Neumann boundary conditions")[
  Neumann boundary conditions specify applied surface forces (e.g., pressure) at the boundary of the physical domain $boundary$.
]

#definition(title:"Finite Element Method")[
  The finite element method (FEM) is a numerical technique for solving complex physical problems governed by partial differential equations. It achieves this by decomposing the problem domain $domain$ into small, manageable subregions called elements, where simplified mathematical models can be constructed. These models collectively approximate the full solution with controlled accuracy and computational efficiency.
]

#definition(title: "Element")[
  In the FEM, an element is a small, well-defined subregion, denoted $domain_e$, of the physical domain $domain$ where the governing equations are approximated using a simplified mathematical model. Each element represents a localized portion of the solution space that, when combined with neighboring elements, collectively reconstructs the full physical behavior of the system:
]

#examplebox()[
  For two-dimensional problems, triangles are frequently used because they efficiently represent flat surfaces with minimal computational effort. In three-dimensional problems, tetrahedrons (four-sided polyhedrons) are common for modeling solid volumes, while quadrilaterals and hexahedrons (six-sided polyhedrons) offer higher accuracy for more complex regions like curved surfaces or intricate structures. Crucially, all these elements—whether triangular, tetrahedral, quadrilateral, or hexahedral—share the same foundational structure: each is a well-defined subregion.
]

#definition(title:"Node")[
  Each element is defined by a set of points called nodes, which connect to form the element's geometry and define its behavior during simulation. For a given type of element, the number of nodes in such an element is denoted $n_e$. 

  Continuous fields (e.g., temperature, displacement) cannot be stored as it would require infinite memory. In the FEM, physical values are stored at the node locations.
]

#examplebox()[
  - A triangular element has 3 nodes,
  - A tetrahedral element has 4 nodes,
  - A quadrilateral element has 4 nodes.
]

#definition(title:"Mesh")[
  A mesh is a discrete collection of elements $domain_e$ that together form a complete representation of the physical domain $domain$. Let's denote $nummeshelements$ the number of elements in the mesh, then we have:

  $
    domain approx union.big_(e=0)^(nummeshelements-1) domain_e
  $

  The elements cannot overlap, i.e. for all $e != e'$:
  $
    domain_e inter domain_e' = emptyset
  $
  
  In practical applications, meshes can be uniform (using only one type of element throughout the domain) or mixed (combining different element types in a single model).
]

#definition(title:"Level of discretization")[
  The level of discretization describes how finely a physical domain is divided into elements to model a system. It is determined by the number of elements used in the mesh: a coarse discretization uses fewer elements (e.g., 50 elements for a simple structure), while a fine discretization uses more elements (e.g., 50.000 elements for the same structure). This level directly impacts both accuracy and computational effort—fewer elements yield faster calculations but may miss critical details, while more elements produce more accurate results at greater computational cost. Crucially, the same mesh can be refined (increasing the number of elements) or coarsened (reducing the number) to balance precision and efficiency during simulation. In practice, engineers select the optimal level based on the problem’s needs, ensuring the model captures essential physics without unnecessary complexity.
]

#definition(title:"Reference element")[
  The reference element is a standardized geometric template (e.g., a unit triangle or unit cube) used to define the shape and behavior of every element in a mesh. It is not the physical domain—it is a simplified, dimensionless model that ensures all elements of the same type (e.g., all triangles) follow identical mathematical rules.
]

#warning()[
  In practical applications, the physical space (where the real-world system exists) and the reference space (the simplified template used for each element) may have different dimensions. For example, when modeling a three-dimensional bridge, the physical space has three dimensions (length, width, and height), but each triangular element in the mesh uses only two reference coordinates to define its shape.
]

#definition(title:"Dimension of the reference space")[
  $r$ denotes the dimension of the reference space (e.g., $r=2$ for a triangle or $r=3$ for a tetrahedron).
]

#definition(title:"Reference coordinates")[
  Reference coordinates $referenceposition$ are the standardized positions in $RR^r$ within a reference element that define each node’s location. For example, in a triangular element, the three corners of the reference triangle are labeled with reference coordinates—these positions are fixed and identical for all triangular elements in the mesh.
]

#definition(title:"Mapping between reference and physical coordinates")[

  Given a reference position $referenceposition in RR^r$, the physical position is defined as $position = position(referenceposition) in RR^p$.

  This can be viewed as a mapping that transforms a reference coordinate (a position in the reference space) into the corresponding physical coordinate (a position in the actual system being modeled).

  The Jacobian matrix of this mapping is:
  $
    tensor2(bold(J)) = (partial position)/(partial referenceposition) in bb(R)^(p times r)
  $ <eq_mapping_reference_physical>
]

== Shape functions

#definition(title:"Shape functions")[
  The FEM stores solution values at nodes. However, to evaluate the solution at points between nodes (where no node exists), interpolation is required. This is where shape functions come in: they are interpolation functions that use the values at all nodes within an element to compute an approximate solution at any target point.

  Shape functions can be defined in the physical element or the reference element. Definition in the reference element to keep them constant over time, in case of deformation of the physical element. It also allows code reuse.

  If shape functions are defined in the physical element, they are denoted:
  $
    shapefunction(position) = mat(shapefunction_0 (position), ..., shapefunction_(n_e-1) (position))^T
  $

  If shape functions are defined in the reference element, they are denoted:
  $
    referenceshapefunction(referenceposition) = mat(referenceshapefunction_0 (referenceposition), ..., referenceshapefunction_(n_e-1) (referenceposition))^T
  $
]

#property(title:"Shape functions properties")[
  Shape functions are designed to match the exact node values at the nodes. If a node $i$ has a known physical value $u_i$, the interpolated value at that node must be $u_i$. This is denoted with the Kronecker delta (@kronecker_delta), for all nodes $0 <= i < n_e$:

  $
    referenceshapefunction_i (referenceposition_j) = delta_(i j)
  $

  or,

  $
    shapefunction_i (position_j) = delta_(i j)
  $

  Such a property leads to the following equations, for all nodes $0 <= i < n_e$:

  $
    sum_(i=0)^(n_e - 1) referenceshapefunction_i (referenceposition_j) u_i = u_j
  $

  or,

  $
    sum_(i=0)^(n_e - 1) shapefunction_i (position_j) u_i = u_j
  $
]

#property(title:"Shape functions applied on the geometry")[
  For all nodes $0 <= i < n_e$:
  $
    position(referenceposition_i) = position_i
  $

  and,

  $
    position (referenceposition) = sum_(i=0)^(n_e - 1) referenceshapefunction_i (referenceposition) position_i
  $
]

Based on the previous equation and the definition of the mapping between reference and physical coordinates (@eq_mapping_reference_physical):

$
tensor2(bold(J)) 
= (partial position)/(partial referenceposition) 
= (partial  sum_i referenceshapefunction_i (referenceposition) position_i)/(partial referenceposition)
= sum_i (partial  referenceshapefunction_i (referenceposition) position_i)/(partial referenceposition)
$

Entries of this Jacobian matrix are, for $0 <= alpha < p$ and $0 <= beta < r$ :

$
  J_(alpha beta) = (partial position_alpha)/(partial referenceposition_beta)
  = (partial sum_i referenceshapefunction_i (referenceposition) position_i_alpha)/(partial referenceposition_beta)
  = sum_i (partial referenceshapefunction_i (referenceposition))/(partial referenceposition_beta) position_i_alpha
$

Previous equations requires derivatives of the shape functions $(partial referenceshapefunction_i)/(partial referenceposition) in bb(R)^r$:

$
  (partial referenceshapefunction_i)/(partial position_j) = sum_k^r (partial referenceshapefunction_i)/(partial referenceposition_k) (partial referenceposition_k)/(partial position_j)
$

In matrix form:

$
  (partial referenceshapefunction_i)/(partial position) = ((partial referenceposition)/(partial position))^T (partial referenceshapefunction_i)/(partial referenceposition) 
$

$
  ((partial referenceposition)/(partial position))^T in bb(R)^(p times r)
$

== Variational Formulation

$
  cal(L)(u) = f
$

$
  v cal(L)(u) = v f
$

$
  integral_Omega v cal(L)(u) thick dif Omega= integral_Omega v f thick dif Omega
$

Integration by parts:

== Weak form

#definition(title:"Strong form")[
  The strong form of a physical law (e.g., balance of linear momentum) is the original partial differential equation (PDE) expressed in physical space $RR^p$
]

#definition(title:"Weak form")[
  The weak form is derived by:
  1. Multiplying the strong form by a test function $v$
  2. Integrating over the physical domain $domain$
]

To get the weak form of the balance of linear momentum (@eq_balance_linear_momentum), let's multiply by a test function $v$ and integrate over $domain$:

Multiplication by $v$:
$
  v dot density dot.double(displacement) = v dot (nabla dot cauchystress) + v dot density bodyforce
$

Integration over $domain$:

$
  integral_domain v dot density dot.double(displacement) dif domain = 
  integral_domain v dot (nabla dot cauchystress) dif domain
  + integral_domain v dot density bodyforce dif domain
$

Using the divergence theorem:

$
  integral_domain v dot (nabla dot cauchystress) dif domain =
  integral_boundary v dot (cauchystress bold(n)) dif boundary -
  integral_domain nabla v : cauchystress dif domain
$

#todo()[
  Give more details. Introduce $bold(n)$.
]

Substituting:

$
  integral_domain v dot density dot.double(displacement) dif domain = 
  integral_boundary v dot (cauchystress bold(n)) dif boundary -
  integral_domain nabla v : cauchystress dif domain
  + integral_domain v dot density bodyforce dif domain
$

Reducing the boundary integral:

$
  integral_boundary v dot (cauchystress bold(n)) dif boundary =
  integral_boundary_t v dot overline(bold(t)) dif boundary
$

#todo()[
  Give more details.
]



#result(title: "Weak form of the balance of linear momentum")[
  Substituting:

  $
    integral_domain v dot density dot.double(displacement) dif domain = 
    integral_boundary_t v dot overline(bold(t)) dif boundary -
    integral_domain nabla v : cauchystress dif domain
    + integral_domain v dot density bodyforce dif domain
  $ <eq_weak_balance_linear_momentum>
]

#definition(title:"Galerkin method")[
  $v = delta displacement$

  $
    integral_domain delta displacement dot density dot.double(displacement) dif domain = 
    integral_boundary_t delta displacement dot overline(bold(t)) dif boundary -
    integral_domain nabla delta displacement : cauchystress dif domain
    + integral_domain delta displacement dot density bodyforce dif domain
  $
]

#property(title:"Integral approximation")[
  $
    integral_domain (dot) dif domain 
    approx
    sum_(e = 0)^(nummeshelements-1) integral_domain_e (dot) dif domain_e
  $
]

== Mass

#definition(title:"Density field")[
  Density field is a scalar function $density : domain subset RR^p -> RR$ such that:
  - $density(position)$ represent the mass density at position $position in domain$
  - $density$ is continuous and well-defined across elements (ensuring no abrupt jumps at nodes)
]

#property(title:"Density field in an element")[
  $
    density(position) = sum_(i=0)^(n_e - 1) shapefunction_i (position) dot density_i
  $

  where $density_i$ are the nodal density values for $0 <= i < n_e$.
]

In @eq_balance_linear_momentum, the density is involved in two terms $density dot.double(displacement)$ and $density bodyforce$, and they are found later in the weak form with the terms $integral_domain v dot density dot.double(displacement) dif domain$ and $integral_domain v dot density bodyforce dif domain$.

Let's focus on $integral_domain v dot density dot.double(displacement) dif domain$:



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
