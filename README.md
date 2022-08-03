# Policy Gradient

This project document details the implementations of Finite Difference (FD) and the Reinforce Policy Gradient (RPG) methods. A brief overview of the implementation is provided, and the methods are implemented for a scalar system with simple dynamics and reward functions. 

#### Keywords
Finite-Differencing Reinforcement Learning, Episodic Reinforce

## Finite Difference
The following pseudo-code describes the implementation of the Finite Difference Method. 

| Steps | Description | 
|1| Sample perturbations of the optimal policy, $\delta\theta$  | 
|2| Generate roll-outs of the trajectory for each perturbation | 
|3| Calculate cost, J, for each roll-out |
|4| Find change in cost, $\Delta J$ due to perturbation |
|5| Compute gradient of policy, update optimal policy with gradient|
|6| Repeat until the gradient converges

The cost function is defined as

$$
    \underset{\theta}{max}J=\underset{\theta}{max}\mathbb{E}\left[\sum\limits_{k=0}^{N}r(x_k,u_k)\right]
$$

Subject to the scalar stochastic dynamics of

$$
    x_{k+1}=Ax_k+Bu_k(x_k, \theta)+\epsilon_k
$$

The change in cost is found with

$$
    \Delta J_i=J(\theta+\delta\theta_i)-J(\theta)
$$

