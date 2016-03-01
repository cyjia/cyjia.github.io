---
layout: post
title: 连续型随机变量及其概率分布密度
---

如果随机变量$X$的分布函数$F(x)$可以表示成某一非负函数$f(x)$的积分
$F(x)=\int_{-\infty}^xf(t)dt,\; -\infty \lt x \lt +\infty$,
则称$X$为连续型随机变量，其中$f(x)$称为$X$的概率密度函数。

概率密度函数具有性质:

1. $f(x)\ge 0$;
2. $\int_{-\infty}^{+\infty}f(x)dx=1$;
3. $P\{x_1\lt X\le x_2\}=\lim_{x_1}^{x_2}f(x)dx$;
4. 若$f(x)$在点$x$处连续,
$f(x)=F'(x)=\lim\limits_{\Delta x \to0}{P\{x\lt X \le x +\Delta x\} \over \Delta x}$

常见的连续型分布有:

## 正态分布

若随机变量$X$有概率密度
$f(x)={1\over \sqrt{2\pi\sigma}}e^{-{(x-\mu)^2}\over 2\sigma^2},\;-\infty\lt x\lt +\infty,\sigma\gt0$
称$X$服从参数为$\mu,\sigma$的正态分布,记做$X\sim N(\mu,\sigma^2)$.正态密度函数曲线有以下特性:

1. 关于直线$x=\mu$对称, 即$f(\mu+x)=f(\mu-x)$;
2. 当$x=\mu$时,$f(x)$达到最大值${1\over \sqrt{2\pi\sigma}}$;
3. 当$x\to\pm\infty$时,$f(x)\to0$;
4. 曲线与$x$轴之间所夹面积为1.

## 均匀分布
若随机变量$X$有概率密度
$f(x)=\left\lbrace\displaylines{ {1\over b-a}, \;&a\le x\le b\cr 0, &其它\cr }\right\rbrace$
称$X$服从区间$[a,b]$上的均匀分布,记为$X\sim U(a,b)$.
其分布函数为
$F(x)=\left\lbrace\displaylines{ 0,\; &x\lt a,\cr {x-a \over b-a}, &a\le x \lt b,\cr 1, &x\ge b.}\right\rbrace$


