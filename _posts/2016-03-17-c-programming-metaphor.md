---
layout: post
title: C的编程隐喻
---

用C编程就是要把问题转换为对内存的读写，最后内存中的值就是结果。为方便描述所操作的内存块，把内存映射成变量名称。变量的类型隐含占用内存的字节数。指针变量的值就是内存地址。

对内存的管理仍然是编程的负担。对于在代码中定义的局部变量，编译器会为他们分配到一块特殊的内存区域，一般是在调用栈中。对于在代码中定义的全局变量，编译器也会为他们分配到一一块特殊的内存区域，一般是在？？中。对于运行期通过malloc申请的内存，程序中要注意调用free进行释放，否则这部分内存要等到进程结束才会由操作系统释放，晚释放、不释放就会造成所谓的内存泄露。

在我看来，应该把内存管理从编程的关注点中移除。我现在还没有完整的解决方法，不过能看到一些在语言层面的解决方法，不过还没看到过库级别的解决方法。

所谓库级别的解决方法，我设想有一套类型、函数库，这些库提供直接可用的类型，这些类型的操作方法中隐含管理了内存的申请和释放。比如，有一个String类型，程序中可以直接定义`String a`，而实际生成的代码还是`char *a`，在使用`a`的地方自动申请内存。对于已经申请的内存也追踪使用情况，及时释放不使用的内存。



