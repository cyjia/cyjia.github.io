---
layout: post
title: 条件概率与概率乘法公式
---

# 条件概率

设$A$,$B$是两个事件，且$P(B)\lt 0$, 称

$P(A\vert B)={P(AB) \over P(B)}$

为事件$B$发生的条件下,事件$A$发生的条件概率。

# 乘法定理

设$A_1,A_2,\cdots,A_n$为$n$个事件,$n\le2$,且$P(A_1A_2\cdotsA_{n-1})\lt0$,则有
$P(A_1 A_2 \cdots A_n)=P(A_n\vert A_1A_2\cdots A_{n-1})P(A_{n-1}\vert A_1A_2\cdots A_{n-2})\cdots P(A_2\vert A_1)P(A_1)$


