---
layout: post
title: 概率的定义及性质
---

# 概率的定义

设$E$是随机试验, $S$是他的样本空间, 对于$E$的每一个事件$A$赋予一个实数, 记为$P(A)$, 如果函数$P$满足下列条件:

1. 非负. 对于每一个事件$A$, 有$P(A)\le 0$;
2. 规范. $P(S)=1$;
4. 可列可加 设$A_1, A_2, \cdots$是两两互不相容事件，即$i \ne j$时，$A_i A_j = \emptyset$, $i,j=1,2,\cdots$, 则有$P(A_1 \bigcap A_2 \cdots)=P(A_1) + P(A_2) + \cdots$。

则$P(A)$称为事件A的概率.

# 概率的性质

1. $P(\emptyset) = 0$;
2. 若$A_1, A_2, \cdots, A_n$ 是两两互不相容事件, 则有$P(A_1 \cup A_2 \cup A_n) = P(A_1) + P(A_2) + \cdots + P(A_n)$;
3. 对于任一事件$A$, 有$$P(\overline A) = 1 - P(A)$$;
4. 对于任意两事件$A, B$, 有$P(A\cup B) = P(A) + P(B) - P(AB)$;
5. 对于任意$n$个事件:$A_1, A_2, \cdots, A_n$, $A_1, A_2, \cdots, A_n$, 有$\eqalign{P(A_1 \cup A_2 \cup A_n) &= \sum\limits_{i=1}^n P(A_i)-\sum\limits_{1\le i \lt j \le n}P(A_iA_j) \cr  &+ \sum\limits_{1\le i\lt j\le n}P(A_iA_jA_k) + \cdots + (-1)^{n-1}P(A_1A_2\cdots A_n)}$.
