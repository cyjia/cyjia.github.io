---
layout: post
title: 样本空间与随机事件
---

# 基本概念

## 随机试验
对某一事物的观测称为试验。随机试验具有特点:

1. 可以在相同条件下重复进行
2. 每次试验的可能结果不止一个，并且能事先明确试验的所有可能结果
3. 进行一次试验之前不能确定哪一个结果会出现

通常用字母$$E$$或$$E_1, E_2, \cdots$$表示随机试验。

## 样本空间和样本点
随机试验$$E$$的所有可能结果组成的集合称为$$E$$的样本空间，记为$$S$$。样本空间的元素，即$$E$$的每个结果，称为样本点。

## 随机事件
试验$$E$$的样本空间$$S$$的子集称为$$E$$的随机事件。由一个样本点组成的单点集称为基本事件。

# 事件的关系
对于事件A和B，可能存在如下关系：

1. $$A\subset B$$,
2. $$A\subset B$$ 且 $$B\subset A$$,$$A = B$$,
3. $$A\bigcap B = \{x\mid x \in A$$且 $$x \in B\}$$, 称为事件A和B的积事件,
4. $$A\bigcup B = \{x\mid x \in A$$或 $$x \in B\}$$, 称为事件A和B的和事件,
5. $$A - B=\{x\mid x \in A$$且 $$x \notin B\}$$, 称为事件A与B的差事件,
6. 若$$A\bigcap B = \emptyset$$, 则称事件$$A$$与$$B$$是互不相容事件,
7. 若$$A\bigcup B = S$$且$$A\bigcap B = \emptyset$$则称事件A与B互为逆事件。

# 事件的运算律

- 交换律:
  $$A\bigcup B = B \bigcup A; A \bigcap B = B \bigcap A$$
- 结合律:
  $$A\bigcup(B\bigcup C) = (A\bigcup B)\bigcup C; (A\bigcap B)\bigcap C = A\bigcap(B\bigcap C)$$
- 分配律:
  $$A\bigcup(B\bigcap C) = (A\bigcup B)\bigcap(A\bigcup C); A\bigcap(B\bigcup C)=(A\bigcap B)\bigcup(A\bigcap C)$$
- 德摩根律:
  $$\overline{A\bigcup B} = \overline A\bigcap \overline B; \overline{A\bigcap B} = \overline A\bigcup \overline B$$

