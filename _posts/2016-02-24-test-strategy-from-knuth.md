---
layout: post
title: 从Donald Knuth大师那里学到的测试策略
---

[Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth)大师在其[trip.tex](http://texdoc.net/texmf-dist/doc/generic/knuth/tex/tripman.pdf)提到了一种测试大系统的策略。

大师认为大系统很难测，程序员自己写一些测试还比较有效。

大师在1960年开发ALGOL编译器时使用了一种策略，构建测试文件，这个文件包含非常极端、非常复杂的使用场景，这个文件的目的是使软件挂掉，而不是让软件通过。这种测试文件需要花费较大精力。软件系统一般会用到大约50%的逻辑，这种测试文件能覆盖大约90%的逻辑。接下来，再结合测试覆盖率工具，不断提高覆盖率到99%。




