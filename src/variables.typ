#import "variables_index.typ": *

#let tensor1 = math.underline
#let tensor2(body) = math.underline(tensor1(body))
#let tensor3(body) = math.underline(tensor2(body))
#let tensor4(body) = math.underline(tensor3(body))

#let forcesymbol = $bold(upright(f))$
#let positionsymbol = $bold(q)$
#let stiffnesssymbol = $bold(cal(K))$
#let linearstraintensorcomponentsymbol = $epsilon$
#let cauchystresscomponentsymbol = $sigma$
#let domainsymbol = $Omega$
#let rightcauchygreensymbol = $tensor2(C)$
#let shapefunctionsymbol = $N$
#let testfunctionsymbol = $v$

#let register-symbols = {
  def-sym("dimension", "dim", [Dimension])
  def-sym("stepsize", $Delta t$, [The time step])
  def-sym("odemassmatrix", $MM$, [The ODE mass matrix])
  def-sym("odeenergy", $bold(epsilon)$, [ODE energy])
  def-sym("position", positionsymbol, [Generalized coordinate])
  def-sym("velocity", $dot(positionsymbol)$, [Generalized velocity])
  def-sym("acceleration", $dot.double(positionsymbol)$, [Generalized acceleration])
  def-sym("state", $bold(x_positionsymbol)$, [State])
  def-sym("volume", $V$, [Volume])
  def-sym("undefvolume", $V_0$, [Undeformed volume])
  def-sym("force", $forcesymbol$, [Force])
  def-sym("bodyforce", $bold(b)$, [Body force])
  def-sym("gravity", $bold(g)$, [Gravity])
  def-sym("forceelement", $forcesymbol^"element"$, [Element force])
  def-sym("momentum", $bold(p)$, [Momentum])
  def-sym("mass", $m$, [Mass])
  def-sym("density", $rho$, [Density])
  def-sym("massmatrix", $bold(cal(M))$, [Mass matrix])
  def-sym("stiffness", $stiffnesssymbol$, [Stiffness matrix])
  def-sym("damping", $bold(cal(B))$, [Damping matrix])
  def-sym("identity", $bold(I)$, [Identity matrix])
  def-sym("lagrangiandensity", $cal(L)$, [Lagrangian density])
  def-sym("lagrangian", $L$, [Lagrangian])
  def-sym("kineticenergy", $cal(T)$, [Kinetic energy])
  def-sym("constraint", $delta$, [Constraint])
  def-sym("constraintmatrix", $bold(cal(H))$, [Constraint matrix])
  def-sym("potentialenergy", $cal(V)$, [Potential energy])
  def-sym("geometricstiffness", $tilde(stiffnesssymbol)$, [Geometric stiffness matrix])
  def-sym("compliancematrix", $bold(cal(W))$, [Compliance matrix])
  def-sym("relaxation", $bold(cal(C))$, [Relaxation])
  def-sym("mapping", $bold(cal(F))$, [Mapping function])
  def-sym("jacobianmapping", $bold(cal(J))$, [Mapping Jacobian matrix])
  def-sym("coriolismatrix", $bold(cal(C))$, [Coriolis matrix])
  def-sym("diffusivity", $alpha$, [Diffusivity])
  def-sym("loss", $cal(l)$, [Loss function])
  def-sym("deformationgradient", $tensor2(F)$, [Deformation gradient])
  def-sym("greenstrain", $tensor2(E)$, [Gree strain tensor])
  def-sym("rightcauchygreen", $rightcauchygreensymbol$, [Right Cauchy-Green tensor])
  def-sym("displacement", $bold(u)$, [Displacement])
  def-sym("strain", $tensor2(epsilon)$, [Strain tensor])
  def-sym("linearstraintensorcomponent", $linearstraintensorcomponentsymbol$, [Linear strain tensor component])
  def-sym("linearstraintensor", $tensor2(linearstraintensorcomponentsymbol)$, [Linear strain tensor])
  def-sym("straindisplacement", $bold(B)$, [Strain-displacement matrix])
  def-sym("undefposition", $bold(Q)$, [Position in undeformed configuration])
  def-sym("cauchystresscomponent", $cauchystresscomponentsymbol$, [Cauchy stress tensor component])
  def-sym("cauchystress", $bold(cauchystresscomponentsymbol)$, [Cauchy stress tensor])
  def-sym("elasticitymatrix", $bold(C)$, [Elasticity matrix])
  def-sym("youngmodulus", $E$, [Young's modulus])
  def-sym("poissonratio", $nu$, [Poisson's ratio])
  def-sym("referenceposition", $xi$, [Position in the reference element])
  def-sym("particle", $q$, [Particle])
  def-sym("body", $B$, [Body])
  def-sym("configurationmapping", $phi$, [Configuration mapping])
  def-sym("deformationjacobian", $J$, [Deformation jacobian])
  def-sym("strainenergydensity", $psi$, [Strain energy density function])
  def-sym("undefstrainenergydensity", $Psi$, [Strain energy density function in the undeformed configuration])
  def-sym("domain", $domainsymbol$, [Domain])
  def-sym("boundary", $partial domainsymbol$, [Boundary])
  def-sym("referencedomain", $hat(domainsymbol)$, [Reference domain])
  def-sym("pk1", $tensor2(P)$, [First Piola-Kirchhoff stress tensor])
  def-sym("pk2", $tensor2(S)$, [Second Piola-Kirchhoff stress tensor])
  def-sym("invariant1", $I_rightcauchygreensymbol$, [First invariant])
  def-sym("invariant2", $I #h(-2pt) I_rightcauchygreensymbol$, [Second invariant])
  def-sym("invariant3", $I #h(-2pt) I #h(-2pt) I_rightcauchygreensymbol$, [Third invariant])
  def-sym("isochoricinvariant1", $I_tilde(rightcauchygreensymbol)$, [Isochoric first invariant])
  def-sym("isochoricinvariant2", $I #h(-2pt) I_tilde(rightcauchygreensymbol)$, [Isochoric second invariant])
  def-sym("tangentmodulus", $tensor4(AA)$, [Tangent modulus])
  def-sym("elasticitytensor", $tensor4(CC)$, [Elasticity tensor])
  def-sym("bulkmodulus", $kappa$, [Bulk modulus])
  def-sym("shapefunction", $shapefunctionsymbol$, [Shape function])
  def-sym("shapefunctionmatrix", $cal(shapefunctionsymbol)$, [Shape function matrix])
  def-sym("referenceshapefunction", $hat(shapefunctionsymbol)$, [Shape function in the reference element])
  def-sym("nummeshelements", $n_"el"$, [Number of elements in the mesh])
  def-sym("testfunction", $testfunctionsymbol$, [Test function])
  def-sym("testfunctionvector", $bold(testfunctionsymbol)$, [Test function vector])
}


#let dimension = use-sym("dimension")
#let stepsize = $#use-sym("stepsize")$
#let odemassmatrix = $#use-sym("odemassmatrix")$
#let odeenergy = $#use-sym("odeenergy")$
#let position = $#use-sym("position")$
#let velocity = $#use-sym("velocity")$
#let acceleration = $#use-sym("acceleration")$
#let state = $#use-sym("state")$
#let volume = $#use-sym("volume")$
#let undefvolume = $#use-sym("undefvolume")$
#let force = $#use-sym("force")$
#let bodyforce = $#use-sym("bodyforce")$
#let gravity = $#use-sym("gravity")$
#let forceelement = $#use-sym("forceelement")$
#let momentum = $#use-sym("momentum")$
#let mass = $#use-sym("mass")$
#let density = $#use-sym("density")$
#let massmatrix = $#use-sym("massmatrix")$
#let stiffness = $#use-sym("stiffness")$
#let damping = $#use-sym("damping")$
#let identity = $#use-sym("identity")$
#let lagrangiandensity = $#use-sym("lagrangiandensity")$
#let lagrangian = $#use-sym("lagrangian")$
#let kineticenergy = $#use-sym("kineticenergy")$
#let constraint = $#use-sym("constraint")$
#let constraintmatrix = $#use-sym("constraintmatrix")$
#let potentialenergy = $#use-sym("potentialenergy")$
#let geometricstiffness = $#use-sym("geometricstiffness")$
#let compliancematrix = $#use-sym("compliancematrix")$
#let relaxation = $#use-sym("relaxation")$
#let mapping = $#use-sym("mapping")$
#let jacobianmapping = $#use-sym("jacobianmapping")$
#let coriolismatrix = $#use-sym("coriolismatrix")$
#let diffusivity = $#use-sym("diffusivity")$
#let loss = $#use-sym("loss")$
#let deformationgradient = $#use-sym("deformationgradient")$
#let greenstrain = $#use-sym("greenstrain")$
#let rightcauchygreen = $#use-sym("rightcauchygreen")$
#let displacement = $#use-sym("displacement")$
#let strain = $#use-sym("strain")$
#let linearstraintensorcomponent = $#use-sym("linearstraintensorcomponent")$
#let linearstraintensor = $#use-sym("linearstraintensor")$
#let straindisplacement = $#use-sym("straindisplacement")$
#let undefposition = $#use-sym("undefposition")$
#let cauchystresscomponent = $#use-sym("cauchystresscomponent")$
#let cauchystress = $#use-sym("cauchystress")$
#let elasticitymatrix = $#use-sym("elasticitymatrix")$
#let youngmodulus = $#use-sym("youngmodulus")$
#let poissonratio = $#use-sym("poissonratio")$
#let referenceposition = $#use-sym("referenceposition")$
#let particle = $#use-sym("particle")$
#let body = $#use-sym("body")$
#let configurationmapping = $#use-sym("configurationmapping")$
#let deformationjacobian = $#use-sym("deformationjacobian")$
#let strainenergydensity = $#use-sym("strainenergydensity")$
#let undefstrainenergydensity = $#use-sym("undefstrainenergydensity")$
#let domain = $#use-sym("domain")$
#let boundary = $#use-sym("boundary")$
#let referencedomain = $#use-sym("referencedomain")$
#let pk1 = $#use-sym("pk1")$
#let pk2 = $#use-sym("pk2")$
#let invariant1 = $#use-sym("invariant1")$
#let invariant2 = $#use-sym("invariant2")$
#let invariant3 = $#use-sym("invariant3")$
#let isochoricinvariant1 = $#use-sym("isochoricinvariant1")$
#let isochoricinvariant2 = $#use-sym("isochoricinvariant2")$
#let tangentmodulus = $#use-sym("tangentmodulus")$
#let elasticitytensor = $#use-sym("elasticitytensor")$
#let bulkmodulus = $#use-sym("bulkmodulus")$
#let shapefunction = $#use-sym("shapefunction")$
#let shapefunctionmatrix = $#use-sym("shapefunctionmatrix")$
#let referenceshapefunction = $#use-sym("referenceshapefunction")$
#let nummeshelements = $#use-sym("nummeshelements")$
#let testfunction = $#use-sym("testfunction")$
#let testfunctionvector = $#use-sym("testfunctionvector")$