---
layout: post
title: Shell编程的两个大招
---

我是一个很笨的程序员，照猫画虎地写程序。

从业多年来，无数次遇到Shell脚本，从最初的Tomcat脚本，到最近的Hadoop脚本。但每次都仅限于读懂脚本，改改环境变量，或者加个参数，对脚本编程的思维模式、基本元素都是似是而非。就这样浑浑噩噩过了好多年，直到最近，生活所迫，不得不坐下来认真研究一下Shell编程。研究后，我发现，Shell编程其实挺简单，只需要掌握1)屈指可数的编程元素，2)Shell的思考方式。

## 准备学习环境

要学习编程，最好的方法就是练习，所以你要准备一个练习环境。Linux, Mac都可以在自带Terminal里运行Shell脚本。Bash恐怕是目前最常见的Shell了，所以直接用Bash进行学习是最好不过的了。

如果非要给出个步骤，那就是1)找到一个Linux或Mac系统，2)打开Terminal，3)运行命令 `bash`， 4)再打开一个文本编辑器，5)新建一个文件test.sh， 6)在Terminal中执行命令`chmod +x test.sh`。

## 屈指可数的编程元素

在test.sh中输入如下的代码。

{% highlight shell %}

#!/bin/bash
title="Chaoyang";
echo "Hello, $title";

{% endhighlight %}

保存文件后，运行`./test.sh`，将看到输出`Hello, Chaoyang`。恭喜你，第一个Shell脚本写好了，并且测试通过。如果你遇到文件找不到的问题，那是文件`test.sh`不在你的当前目录，`ls`一下看看。如果你遇到权限不够的问，那是你忘记给文件加执行权限了，`chmod +x test.sh`之后再试试看。如果你遇到其他奇怪的错误，那多半是输入中出现了拼写错误，或者加了多余的空格、换行符，请严格检查输入是否正确。

这个简单至极的脚本展示了Shell编程的两个要素:声明Shell类型，声明和使用变量。`#!/bin/bash`这句话永远放在文件第一行，声明期望的Shell类型。别问为什么，照样做就行了，如果你有充足的理由要其他Shell，那说明你已经足够深入，本文对你没营养。`title="Chaoyang;"`这一句声明了一个变量`title`，并为其赋字符串值`Chaoyang`。下一句，`echo "Hello, $title";`，执行程序`echo`，传递的参数是`Hello, Chaoyang`，因为Shell知道`$title`是变量`title`的值。

可以看出，Shell对变量的要求极其简单，没有类型声明，给个名字就够了。使用变量时在变量名前加`$`即可。至于名字的范围，字母数字下划线都是可以的，如果你要挑战极限用一些奇怪的符号，那请自行慢慢研究吧。

给变量赋值的变化较多，只需要掌握几个常用规则即可。给变量赋予整数、小数等数值，可以加或不加双引号。给变量赋字符串值时，也可以用单引号，但此时不会替换其中的变量值，比如`title2='$title';`，结果`title2`的值是`$title`而不是`Chaoyang`。这几种变化请读者自行验证。

最后，特别提醒，声明变量时`=`两边不要加空格，比如`title ="Chaoyang";`，`title= "Chaoyang";`都是不对的，这也算是Shell的一个坑吧，估计不少人都折在这里。

有了变量，下面就是函数了。

请在文件`test.sh`中继续追加以下内容。

{% highlight shell %}
function hello_world {
    echo "Hello, I am function";
}

hello_world;
{% endhighlight%}

保存文件并运行`./test.sh`应该能看到`Hello, I am function`的输出。如果你遇到语法错误的提醒，那估计是多或少加了空格、换行或者函数名前后不一致，请严格按照示例进行输入。如果你没看到期望的输出，请检查是否忘了最后调用函数的那一句`hello_world`。

运行正确之后，再看看这段代码。是不是很简洁？`function`就说明后面是函数的声明，`hello_world`是函数名称，紧接着就是代码块开始的分隔符 `{`，连参数声明都省了。函数内部语句用`;`结束，以`}`结束函数声明。需要提醒的是，函数名和`{`之间要加个空格，这算是Shell的另一个坑吧。

你肯定在问，参数怎么办?答案是，请用`$1,$2,...$n`。请在文件`test.sh`中继续追加一下内容。

{% highlight shell %}

function hello_to {
    whom=$1;
    echo "Hello, $whom!";
}

hello_to "Jeff";

{% endhighlight %}

保存文件并运行`./test.sh`后应该看到`Hello, Jeff!`的输出。我想，这次你应该是一次成功，即便不是一次成功也已经自己找出并解决了问题。

这段代码展示了如何在函数中使用参数以及如何给函数传递参数。如你所见，`whom=$1;`把函数的第一个参数赋给变量`whom`，`echo "Hello, $whom!";`使用了变量`whom`的值。当然了，也可以不声明变量`whom`，直接用`$1`，比如`echo "Hello, $1!"`，但是像我这样笨的程序员喜欢循规蹈矩，只要有助于表达意思，不怕多写几行。

变量、函数都知道了，再掌握控制语句就能写出长篇大论啦。

在`test.sh`最后加入`if`语句的例子。

{% highlight shell %}

function welcome {
    guest=$1;
    if [ $1 = "Chaoyang" ]; then
        echo "Welcome";
    else
        echo "Can I help you?";
    fi
}

welcome "Chaoyang"

{% endhighlight %}

保存文件并运行`./test.sh`之后应该能看到`Welcome`的输出。如果出现`command not found`的错误提示，那是因为'['之后、']'之前没有空格。

是的，我已经听到了，你一定在抱怨这是最奇怪的`if`语句，认命吧，你很快就能适应的。这里要注意的是:

- `if`和`fi`成对出现
- `if`后有`then`，而`else`后不需要`then`
- 条件表达式要以`;`结束
- 条件表达式要置于`[]`中，并且在`[`之后和`]`之前有空格
- 多个条件表达式可以通过逻辑符`||`和`&&`连接
- 更多的分支使用`else if ... then`

`for`循环自然是不能少的。请继续向`./test.sh`追加下面的例子。

{% highlight shell %}

for i in $(ls); do
    echo $i;
done

{% endhighlight  %}

保存文件并运行`./test.sh`之后应该能看到`ls`命令的输出。

这就是`for`循环的语法，和`if`类似，循环条件语句以`;`结束。`do`表示循环体的开始，`done`表示循环体的结束。这里难理解的是循环条件语句`i in $(ls)`，我把`$(ls)`理解成文本行的流，这里的意思就是以文本的形式逐行处理命令`ls`的输出。这就是Shell强大的地方，`$(xx)`就执行能命令并拿到命令的输出，然后可以直接把输出当做文本行进行处理。

再举个`while`循环的例子。

{% highlight shell %}
COUNT=0
while [ $COUNT -lt 10 ]; do
    echo "Now: $COUNT"
    let COUNT=COUNT+1
done

{% endhighlight %}

把这段代码追加到`test.sh`，再次运行`./test.sh`应该输出0-9升序的数字。这就是`while`的语法，循环终止条件、`do`和`done`，循环终止条件以`;`结束。这个例子用`[ $COUNT -lt 10 ]`做循环终止条件，因为变量`COUNT`是数值，所以用了数值的比较运算符`-lt`，类似的比较运算符还有很多。循环体内还用到了`let COUNT=COUNT+1`，这是Shell变量计算的方法，不能写成`COUNT=COUNT+1`,读者可以自行试验没有`let`的结果。

好啦，到现在为止变量、函数、控制语句都已经介绍完了，是不是特别简单？

不过，仅仅知道语言还不够，还需要了解一些Shell程序的思维方式才能做出有实用意义的程序。

## Shell的思维方式

Shell语言是一门特殊的语言，与C,JAVA,PYTHON等语言相比，Shell解决问题的领域和思维方式也不同，因此在使用Shell语言是要特别注意用Shell的思维方式。

Shell最初称为Unix shell，它的目的是为用户提供访问操作系统的能力，其实现方式是执行命令，把命令的输出结果进行转换再传递给下一个命令。也就是说，Shell脚本所面对的是很多可执行程序，脚本连接这些可执行程序完成任务。如果需要为Shell编程人员提供一个隐喻，我最先想到的就是是乐高积木，每一个可执行程序是一个积木块，Shell编程就是用积木块拼接成需要的形状。当拿到一个Shell编程的任务，首先应该想到的是现有的哪些积木块能拼接起来就能完成任务，没有直接可用的积木块时首先会去想能不能组合，最后一个选择才是去直接制造积木块。而制造积木块，在我看了就是C,JAVA,PYTHON等语言擅长解决的问题。

举个例子。现在有两个文本文件A和B，里面按行存放了以`,`分隔的键值对数据，现在希望找出在文件A中出现但不在B中的所有键值。在继续之前，请你想想这样的Shell程序应该如何写。

第一种思路是，要打开A文件，读取里面的行，解析出键和值，放在某种集合数据结构中，然后同样处理B文件，然后进行集合的差运算。我估计没有Shell编程经验的大多会这样思考。然后接下来的编程过程就是查文档，看Shell编程如何打开文件，如何读取文件，然后又怎样定义数据结构，有哪些原生支持。

第二种思路是，看看操作系统有哪些命令能解析文本行，哪些命令能对文本行做差集运算，这些命令的输入输出都是什么格式，有哪些选项能控制。

第一种思路是C,JAVA,PYTHON等语言的思路，因为这些语言设计出来就是要制造积木块的。第二种思路是Shell编程的思路，因为Shell编程就是拼接积木块，本身不是设计用来制造积木块的。

Unix，Linux等操作系统提供了很多积木块，每个积木块都有很多选项、接口，因此大多数场景下你都能找到一套适合自己的积木块。对这个例子，用`awk,comm`这两个命令就可以搞定。`awk`能逐行转换文本，`comm`能比较两个文件。答案可能是形如`comm -23 < awk -F, '{print $1}' A < awk -F, '{print $1}' B`。

在有些极少数场景下，你确实找不到适合的积木，这时你应该动用C,JAVA,PYTHON等语言而不是Shell去制造积木。


除了提供灵活的积木块，Shell还有管道技术以连接各个积木块。管道的基本做法是把一个命令的输出作为输入提供给另一个命令。比如我想统计文件有多少行，可以这样写`cat file | wc -l`。没有管道的情况下`cat`命令会把`file`文件内容写到标准输出，`wc`命令会从标准输入读取文本并计算行数，通过管道`|`的连接，`cat`命令原本写到标准输出的内容被传递到`wc`命令的标准输入，这样就把连个命令协调起来。

除了这种基本用法，还可以通过命名管道把一个命令和多个命令连接起来。像前面的例子`comm < awk A < awk B`，就把`comm`和两个`awk`连接起来，`awk`的输出分别作为`comm`的两个输入。


## 结语

好啦，能坚持读到这里还真是辛苦你了，希望这些介绍能为你打开Shell编程的大门。









