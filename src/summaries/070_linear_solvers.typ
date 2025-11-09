== Linear Solvers

The section @section_linear_solvers explains practical ways to solve linear equations that arise during iterative calculations, like those used in optimization or physics simulations. It focuses on methods that break down the problem into simpler steps to find a solution without directly computing complex matrix operations. 

The core idea involves splitting the problem into two parts: one part that uses the most recent updates to the solution and another that uses the previous guess. Starting with a simple guess for the solution, each method updates this guess step by step. 

The standard Jacobi method updates every variable using only the values from the previous step. The Gauss-Seidel method improves this by updating variables one at a time and using the new values immediately as they become available. 

To make these methods faster and more stable, a relaxation factor is introduced. This factor blends the old guess with the new guess in each step. The Weighted Jacobi method applies this blending to the standard Jacobi approach. Similarly, the Successive Over-Relaxation (SOR) method uses the same blending technique but applies it to the Gauss-Seidel updates, often leading to faster convergence. 

In essence, these methods provide efficient, step-by-step strategies for solving large systems of equations by carefully balancing how much weight to give the latest updates versus the previous guesses, without requiring complex mathematical computations at each step.