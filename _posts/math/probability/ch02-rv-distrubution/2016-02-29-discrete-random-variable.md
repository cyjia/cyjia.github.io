---
layout: post
title: 离散型随机变量及其分布律
---

若随机变量$X$只能取有限个或可列无限多个值，称$X$为离散型随机变量.
$P(X=x_k)=p_k(k=1,2,\cdots)$称为离散型随机变量$X$的分布律.

离散型随机变量通常用分布律而不用分布函数.常见的离散型分布律有

1. 两点分布

若离散型随机变量$X$具有分布律:

|$X$   |0  |1  |
|-----:|--:|--:|
|$p_k$ |$q$|$p$|

其中$0<p<1,q=1-p$. 则称$X$服从参数为$p$的两点分布,记作$X\sim(0-1)$分布.

2. 二项分布

若离散型随机变量$X$具有分布律$p_k={\choose n k}p^kq{n-q},k=0,1,\cdots,n$,其中$0<p<1,q=1-p$,则成$X$服从参数$n,p$的二项分布,记做$X\sim B(n,p)$.


3. 泊松分布

若离散型随机变量$X$具有分布律$p_k={\lambda^k\over k!}e{-\lambda}, k=0,1,2,...,\lambda \gt 0$,则称$X$服从参数为$\lambda$的泊松分布,记做$X\sim P(\lambda)$
