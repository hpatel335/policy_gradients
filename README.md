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

The gradient of the policy is found with

$$
     \nabla_\theta J=(\Delta\Theta^T\Delta\Theta)^{-1}\Delta\Theta^T\Delta J 
$$

$$
     \Delta\Theta = \left[ \delta\theta_i, ... ,  \delta\theta_M \right]^T \\ 
$$

$$
     \Delta J = \left[ \Delta J_i, ... , \Delta J_M \right ]^T 
$$

The reward is defined as

$$
    r(x_k,u_k)=x^TQx+u^TRu
$$

The linear feedback policy parameterization is defined as

$$
    u(x,\theta)=Kx_k
$$

### Results 

The Finite Differencing method converges close to the optimal gain, determined from LQR, but tends to oscillate around the optimal value. These fluctuations are directly related to the system noise represented by $\epsilon_k$ in the stochastic dynamic equation. 

**Plots of gain (right), and system reward (left) for the Finite Difference case. Here A = B = 0.1, and Q = R = -1.**
<img src="./plots/optimal1.png" width="600">


## Reinforce Policy Gradient
The following pseudo-code describes the implementation of RPG. 

| Steps | Description | 
|1| Initialize policy| 
|2| Create trajectory profiles by varying the exploration noise  | 
|3| Calculate the gradient of the cost |
|4| Update the policy using the gradient |
|5| Repeat until policy has converged|

In this case, the linear feedback stochastic policy parameterization is defined as

$$
    u(x,\theta)= (K + \epsilon_k)x 
$$

### Derivation of Episodic Reinforce

Here we'll derive the equation used to calculate the gradient of the cost function with respect to the policy. The optimization function in this case can be represented as the following: 

$$
    J(\theta) = \int{p\left(\vec{\tau}\right) R\left(\vec{\tau}\right) d\vec{\tau}}
$$

The probability of the trajectory, $\tau$ is represented by $p\left(\vec{\tau}\right)$, and the reward R is still the accumulated cost over the entire trajectory. By applying the Markov property and the dependence of the policy to the state and parameter x, $\theta$, the probability of the trajectory can be be expressed as the following: 

$$
    p(\vec{\tau}) = p(x_o)\Pi_{i=0}^{N-1}p(x_{i+1}|x_i, u_i)p(u_i|x_i) 
$$

The probability of the trajectories represents the products of the transition probabilities in $p(x_{i+1}|x_i, u_i)$ and the paramaterized policy $p(u_i|x_i)$ where $\theta$ is the parameter to be optimized. The gradient of the cost function with respect to the policy can be expressed as the following: 

$$
    \nabla_{\theta}J(\theta) = \nabla_{\theta}\left(\int{p\left(\vec{\tau}\right)  R\left(\vec{\tau}\right) d\vec{\tau}} \right) = \int{\nabla_{\theta}p\left(\vec{\tau}\right)  R\left(\vec{\tau}\right) d\vec{\tau}} = \int{p\left(\vec{\tau}\right)\nabla_{\theta}log p(\vec{\tau})  R\left(\vec{\tau}\right) d\vec{\tau}} = \mathbb{E}_p\left[\nabla_{\theta}log p(\vec{\tau}) R(\vec{\tau}) \right] 
$$


