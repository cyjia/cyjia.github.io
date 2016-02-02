---
layout: default
title: 一次使用Jest的经历
---
# 一次使用Jest的经历

今天尝试基于Jest做React组件的测试。参考[Jest官网的例子](http://facebook.github.io/jest/docs/tutorial-react.html#content)。在尝试用自定义预处理器时遇到了一些困难。

我的环境包括三个文件,`CheckboxWithLabel.js`, `__tests__/CheckboxWithLabel-test.js`, `preprocessor.js`和`package.json`,具体代码可以参考Jest官网的例子或本文附录A。NodeJs的版本是4.1.0。

## Babel 版本引发问题
例子中自定义预处理器用Babel转换代码，需要引入`babel-core`的npm包。执行命令`npm install babel-core --save-dev` 安装`babel-core`包。然后执行命令`npm test`重新运行Jest测试。这时得到如下的错误信息。

> TypeError: babel.canCompile is not a function

看上去是`preprocessor.js`中的代码`babel.canCompile`遇到问题了。首先想到的是不是`babel`为undefined呀。仔细一想觉得不大可能，`require('babel-core')`不应该出错。难不成是`canCompile`不存在？最简单的验证办法是什么？把他打印出来。对，于是我就在`preprocessor.js`中毫不犹豫地加了一行`console.log(babel)`。

再次运行`npm test`,没有看到预期的`babel`输出。奇怪了，难道对标准输出做了手脚？忽然想到Jest文档中有提到`config.verbose`，难不成要打开？抱着试一试的心态，我在`package.json`中Jest配置里加入了`"verbose":true`。

又一次运行`npm test`,测试依然失败,并且少了`babel.canCompile`的信息。越来越不能理解了。想来想去还是要先解决这个输出的问题，自定义预处理器也要能调试才行啊。于是试着google一下`jest preprocessor debug`，果然，有人提到要打开Jasmin的verbose。对呀，一定是有人看了源码。按照提示在`package.json`中Jest的配置里有加入`"setupTestFrameworkScriptFile":"testsetup.js"`的配置。`testsetup.js`中只有一行代码`jasmine.VERBOSE = true`。

重新运行`npm test`,这下终于看到了预期的输出。果然babel对象没有`canCompile`方法。于是再去google`babel canCompile`，有人已经给babel提问题了，说是版本6.0以后就没有了`canCompile`方法，并且还有其他一些不兼容的地方。检查一下自己的`babel-core`版本，居然是`6.1.4`，太幸运了。然后果断去查了babel最新的api，果然没有`canCompile`。看了一下调用`canCompile`方法的地方，发现就是要跳过一些不能转换的文件，应该可以通过文件名也你能判断，因此就暂时去掉了对`canCompile`的调用。

`npm test`，还是测试失败。奇怪了，我忍不住想看看babel转换都干了什么，于是在`preprocessor`中输出转换后的代码。居然没有看到任何代码输出。怀疑preprocessor中代码转换出错了，但错误信息被Jest忽略。把`babel.transform`用try..catch包裹起来，输出error。这次终于发现问题了。

> [ReferenceError: [BABEL] /Users/CYJIA/Documents/HedgeServ/workspace/test/testsetup.js: Unknown option: base.stage]
> [ReferenceError: [BABEL] /Users/CYJIA/Documents/HedgeServ/workspace/test/__tests__/CheckboxWithLabel-test.js: Unknown option: base.stage]

`Unknow option: base.stage`,一定是babel新版本的不兼容选项。babel版本6.0以后已经不用`stage`选项了，改用`stage-0`的presence。对preprocessor的代码再次修正。


```javascript
    babel.transform(src, { presets: ['es2015', 'react', 'stage-0']})
```
测试终于过了。但是，等等，执行了哪些测试？让我把测试改挂试试。把一个测试改坏之后，Jest仍然显示测试通过，但同时也输出了错误信息。

> [Error: Couldn't find preset "es2015"]

非常奇怪，为什么之前没有出现这个错误？两次运行的差别在哪里？只是第二次修改了测试文件？难道，是前一次运行没有重新转换文件？哦，是Jest的转换缓存在搞鬼。毫不犹豫地打开了`preprocessCachingDisabled`选项。这下每次运行测试都出现错误了。不过错误很好理解，需要安装babel的转换插件`es2015`。于是把三个插件一起装了`npm install babel-preset-es2015 babel-preset-react babel-preset-stage-0 --save-dev`。

测试挂了，不过输出了很多信息。

> Running 1 test suite...Warning: React.createElement: type should not be null, undefined, boolean, or number. It should be a string (for DOM elements) or a ReactClass (for composite components).
> FAIL  __tests__/CheckboxWithLabel-test.js (4.206s)
> CheckboxWithLabel
>  ✓ it should run
>  ✕ it changes the text after click

> FAIL  __tests__/CheckboxWithLabel-test.js (4.206s)
> ● CheckboxWithLabel › it changes the text after click
>  - Error: Invariant Violation: Element type is invalid: expected a string (for built-in components) or a class/function (for composite components) but got: object.

难道测试写错了，检查了N遍都觉得很合理呀。为什么说`React.createElement`的参数是Object而不是函数呢？无奈之下只能在processor再输出转换后的代码。发现`CheckboxWithLabel-test.js`中的`require('./CheckboxWithLabel')得到的CheckboxWithLabel`没有进行default转换，所以得到的是`{default: [function]}`。想想也对，CheckboxWithLabel模块可以有多个export，`export default class CheckboxWithLabel`就应该转换成`{default: [function]}`。解决办法就是在`require('./CheckboxWithLabel')['default']`。

> CheckboxWithLabel
>  ✓ it should run
>  ✓ it changes the text after click
>
> 2 tests passed (2 total in 1 test suite, run time 3.969s)

哈哈，测试全过了。

## Import还是require
不过，别急。怎么看着`require('./CheckboxWithLabel')['default']`这么别扭呢？其他模块都可以用es2015的`import`,单单这一句用`require`呢？是不是直接用import就好了呢？尝试了一下，结果令人吃惊。

> - Error: Invariant Violation: Element type is invalid: expected a string (for built-in components) or a class/function (for composite components) but got: object.

测试又挂了。在测试中输出import后得到的`CheckboxWithLabel`，发现居然是Jest给mock出来的对象，难怪React会抱怨。可是代码第一行明明写着dontMock呀。没办法，只好在preprocessor中再次输出转换的代码。不可思议，`dontMock`居然被排在`import`后面，也就是说，先`require`了`CheckboxWithLabel`再`dontMock`，难怪会出来一个mock对象。

问题找到了，解决办法呢？第一、让babel转换时尊重代码顺序；第二、让Jest默认不mock，显示启用mock。我采用了第二种解决方法，因为暂时还没用到mock。把`CheckboxWithLabel.js`及其测试都放到`src`目录下，然后把`src`加到Jest的配置项`unmockedModulePathPatterns`。万事大吉了。

## 总结
这次刚好遇到了babel大版本升级，有些不兼容的变化。Jest吞掉预处理的错误给自定义预处理场景下的调试带来困难。babel转换时把import语句提前导致Jest.dontMock失效。

## 附录A

- `CheckboxWithLabel.js`
{% highlight javascript %}

import React from 'react';

class CheckboxWithLabel extends React.Component {

  constructor(props) {
    super(props);
    this.state = {isChecked: false};

    this.onChange = this.onChange.bind(this);
  }

  onChange() {
    this.setState({isChecked: !this.state.isChecked});
  }

  render() {
    return (
      <label>
        <input
          type="checkbox"
          checked={this.state.isChecked}
          onChange={this.onChange}
        />
        {this.state.isChecked ? this.props.labelOn : this.props.labelOff}
      </label>
    );
  }
}

export default CheckboxWithLabel;

{% endhighlight %}

- `__tests__/CheckboxWithLabel-test.js`

{% highlight javascript %}

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

import CheckboxWithLabel from '../CheckboxWithLabel';

describe('CheckboxWithLabel', () => {

  it('changes the text after click', () => {

    // Render a checkbox with label in the document
    var checkbox = TestUtils.renderIntoDocument(
      <CheckboxWithLabel labelOn="On" labelOff="Off" />
    );

    var checkboxNode = ReactDOM.findDOMNode(checkbox);

    // Verify that it's Off by default
    expect(checkboxNode.textContent).toEqual('Off');

    // Simulate a click and verify that it is now On
    TestUtils.Simulate.change(
      TestUtils.findRenderedDOMComponentWithTag(checkbox, 'input')
    );
    expect(checkboxNode.textContent).toEqual('On');
  });

});

{% endhighlight %}

- `preprocessor.js`

{% highlight javascript %}

var babel = require("babel-core");

module.exports = {
  process: function (src, filename) {
    // Allow the stage to be configured by an environment
    // variable, but use Babel's default stage (2) if
    // no environment variable is specified.
    var stage = process.env.BABEL_JEST_STAGE || 2;

    // Ignore all files within node_modules
    // babel files can be .js, .es, .jsx or .es6
    if (filename.indexOf("node_modules") === -1 ) {
      return babel.transform(src, {
        filename: filename,
        presets: ['es2015', 'react', 'stage-0'],
        retainLines: true,
        auxiliaryCommentBefore: "istanbul ignore next"
      }).code;
    }

    return src;
  }
};

{% endhighlight %}

- `package.json`

{% highlight json %}

{
  "dependencies": {
    "react": "~0.14.0",
    "react-dom": "~0.14.0"
  },
  "devDependencies": {
    "babel-core": "^6.1.4",
    "babel-jest": "*",
    "babel-preset-es2015": "^6.1.4",
    "babel-preset-react": "^6.1.4",
    "babel-preset-stage-0": "^6.1.2",
    "jest-cli": "*",
    "react-addons-test-utils": "~0.14.0"
  },
  "scripts": {
    "test": "jest"
  },
  "jest": {
    "scriptPreprocessor": "<rootDir>/preprocessor.js",
    "unmockedModulePathPatterns": [
      "<rootDir>/node_modules/react",
      "<rootDir>/node_modules/react-dom",
      "<rootDir>/node_modules/react-addons-test-utils",
      "<rootDir>/node_modules/fbjs"
    ],
    "verbose": true,
    "setupTestFrameworkScriptFile": "./testsetup.js",
    "preprocessCachingDisabled": true
  }
}

{
 "dependencies": {
    "react": "~0.14.0",
    "react-dom": "~0.14.0"
  },
  "devDependencies": {
    "jest-cli": "*",
    "react-addons-test-utils": "~0.14.0"
  },
  "scripts": {
    "test": "jest"
  },
  "jest": {
    "scriptPreprocessor": "<rootDir>/preprocessor.js",
    "unmockedModulePathPatterns": [
      "<rootDir>/node_modules/react",
      "<rootDir>/node_modules/react-dom",
      "<rootDir>/node_modules/react-addons-test-utils",
      "<rootDir>/node_modules/fbjs"
    ]
  }
}

{% endhighlight %}

- `testsetup.js`

`jasmine.VERBOSE = true`

