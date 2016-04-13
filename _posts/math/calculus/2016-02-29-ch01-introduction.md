---
layout: post
title: Introduction
---

# Velocity and Distance

Example, car, speed(or velocity), distance traveled.
$v$ for velocity, $f$ for distance traveled.
Units of measurement are different for $v$ and $f$. $f$ is measured in kilometers or miles. $v$ is measured in km/hr or miles per hour. A unit of $time$ enters the velocity but not the distance. Every formula to compute $v$ from $f$ will have $f$ divided by time.

 _The central question of calculus is the relation between $v$ and $f$_.

Can you find $v$ if you know $f$, and vice versa, and how? If we know the velocity over the whole history of the car, we should be able to compute the total distance traveled. In other words, if the speedometer record is complete but the odometer is missing, its information could be recovered. One way to do it(without calculus) is to put in a new odometer and drive the car all over again at the right speeds. That seems like a hard way, but the point is that _the information is there_. If we know everything about $v$, there must be a method to find $f$.

What happens in the opposite direction, when $f$ is know? If you have a complete record distance, could you recover the complete velocity? In principle you could drive the car, repeat the history, and read off the speed. Again there must be a better way.

The whole subject of calculus is built on the relation between $v$ and $f$. We need to know how to find the velocity from a record of the distance. (That is called _differentiation_, and it is the central idea of diffferential calculus.) We also want to compute the distance from a history of the velocity.(That is integration, and it is the goal of integral calculus.)

## CONSTANT VELOCITY

if $v$ is constant and $f$ starts at zero then $f=vt$.

## VELOCITY vs. DISTANCE: SLOPE vs. AREA

How do you compute $f$ from $v$? The point of the question is to see $f = vt$ on the graphs. We want to start with the graph of $v$ and discover the graph of $f$.

The distance $f$ is the area under the $v$-graph. When $v$ is constant, the region under the graph is a rectangle. Its height is $v$, its width is $t$, and its area is $v$ times $t$. This is _integration_, to go from $v$ to $f$ by computing the area. We are glimpsing two of the central facts of calculus.

The whole point of calculus is to deal with velocities that are _not_ constant, and from now on $v$ has several values.

_EXAMPLE_ (Forward and back) There is a motion that you will understand right away. The car goes forward with velocity $V$, and comes back at the same speed. To say it more correctly, the _velocity in the second part is_ $V$. If the forward part lasts until $t = 3$, and the backward part continues to $t = 6$, _the car will come back where it started. The total distance after both parts will be $f = 0$.

## FUNCTIONS

The number $v(t)$ is the value of the function $v$ at the time $t$.

The time $t$ is the _input_ to the function. The velocity $v(t)$ at that time is the _output_. Most people say "$v of t$" when they read $v(t)$. The number "$v of 2$" is the velocity when $t = 2$. The forward-back example has $v(2) = +V$ and $v(4) = - V$. The function contains the whole history.

It is simple to convert foward-back motion into a formula. Here is $v(t)$:

$v(t)=\left\lbrace\displaylines{+\, V \; &if 0\lt t\lt3\cr ? &if t=3\cr -\, V &if 3\lt t\lt6\cr}$

The right side contains the instructions for finding $v(t)$. The input $t$ is converted into the output $+\,V$ or $-\,V$. The velocity $v(t)$ depends on $t$. In this case the function is "discontinuous", because the needle jumps at $t = 3$. The velocity is not defined at that instant. There is no $v(3)$. The graph of $f$ has a corner, and we can't give its slope.

The problem also involves a second function, namely the distance. The principle behind $f(t)$ is the same: $f(t) _is the distance at time_ $t$. It is the net distance forward, and again the instructions change at $t = 3$. In the forward motions, $f(t)$ equals $Vt$ as before. In the backward half, a calculation is built into the formula for $f(t)$:

$f(t)=\left\lbrace\displaylines{Vt\; &if 0\le t\le 3\cr V(6-t)\; &if 3\le t \le 6}$

The domain of a function is the set of inputs. The range is the set of outputs.

## SUMMARY:MORE ABOUT FUNCTIONS

In practice what matters is the active part. The number $f(t)$ is produced from the number $t$. We read a graph, plug into a formula, solve an equation, run a computer program. The input $t$ is "mapped" to the output $f(t)$, which changes as $t$ changes. Calculus is about the _rate of change_. This rate is our other function $v$.


# Calculus Without Limits

## 1B The differences of the $f$'s add up to ($f_last - f_first$)

The total area under the v-graph is $f_last - f_first$

## 1C The v's are slopes of $f(t)$. The area under the v-graph is $f(t_end) - f(t_start)$

# The Velocity at an Instant
The central problems that calcus was invented to solve.

1. If the velocity is changing, _how can you compute the distance traveled_?
2. If the graph of $f(t)$ is not a straight line, what is its slope?

Question 1 Suppose the velocity at each time $t$ is $v(t) = 2t$. Find $(ft).

Question 2 The distance traveled by time t is $f(t)=t^2$. Find the velocity $v(t)$.

## 1E As h approaches zero, the average velocity $2t+h$ approaches $v(t)=2t$.

