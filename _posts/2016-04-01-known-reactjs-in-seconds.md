---
title: 秒懂ReactJs
layout: post
---

这篇文章是为ReactJs小白准备的，希望他们快速抓住ReactJs的要点并能在实践中随机应变。

# 两句话版本
- ReactJs把视图更新简化为一个render函数
- render函数接收两个参数，分别是配置项和状态

# 长版本

ReactJs是一个专注于View的Web前端框架。Web前端的View就是浏览器中的Dom元素，改变View的唯一途径就是修改浏览器中的Dom元素，因此ReactJs的核心任务就是如何修改Dom元素，作为一个成功的框架，ReactJs使修改Dom元素变得高效而又简单。

ReactJs把修改Dom的操作简化成一个函数`renderInto(parentDom, props, states)=>htmlString`，这个函数的意图就是根据`props`，`states`计算出视图对应的html字符串并添加为parentDom的子节点。`props`和`states`就是普通的javascript对象，这个函数的核心逻辑就是计算html元素的机构及元素属性然后拼接成字符串返回。作为框架，ReactJs用JSX形式的DSL解决了拼接html的任务并接管了更新到`parentDom`的职责。看一个例子，理解这个函数并理解ReactJs怎么使用这个函数你就可以一个人开始ReactJs之旅了。

```
var props = {name: 'myname'};
var states = {amount: 1000};

function render(props, states) {
  var title = ’Hello, ' + props.name;
  var description = 'You have ' + states.amount + ' score now.';

  return (
    <div className="score-board">
       <h1>{title}</h1>
       <p>{description}</p>
    </div>
  );
}
```

函数第一行根据`props`计算`title`，第二行根据`states`计算`description`，最后以JSX形式返回拼接好的html字符串。

如果你用过AngularJs，EmberJs等类似的前端框架，你可能会觉得没什么了不起，不就是把模板和逻辑放到一起吗？是的，没错，但这不仅仅是组织形式上的改变，而是编程隐喻的转变--从复杂的MVC或MVVM模式到简单的`render`函数。还有一点不同是JSX最终编译成调用`react-dom`的javascript语句，而不是直接生成字符串。

`render`函数还只是ReactJs这座冰山的一角，"React"会在`render`函数的输入变化时再次调用这个函数。再看一个例子。

```
var props = {name: 'myname'};
var states = {amount: 1000};

function handleClickAdd() {
  states = {amount: states.amount + 1};
}

function render(props, states) {
  var title = ’Hello, ' + props.name;
  var description = 'You have ' + states.amount + ' score now.';

  return (
    <div className="score-board">
       <h1>{title}</h1>
       <p>{description}</p>
       <button onClick={handleClickAdd}>+1</button>
    </div>
  );
}
```

这个例子增加了一个"+1"按钮，当用户点击按钮时会修改`states`，ReactJs在`states`变化时的"React"就是再次调用`render`函数，然后用新输出更新浏览器的dom。

可能你会问，`props`和`states`不就是Model吗？是的，可以理解成Model，但此Model非彼Model，`props`和`states`都是为View服务的而非和View平起平坐。

可能你还会问，为啥不把`props`和`states`合并成一个对象？要回答这个问题，就涉及到复杂视图的场景。想想看，当视图内的元素不断增加时，代码上如何处理，还要在一个`render`函数里折腾吗？肯定不会。我猜你已经想到了，要把大问题拆小。ReactJs给出的解决方法就是把大视图拆成若干个小视图，每个视图都有自己的`render`函数，在JSX中可以直接使用视图标签。看一个例子。

```
var Score = React.createClass({
  initialState: function() {
    return {amount: 1000};
  },

  function handleClickAdd() {
    this.setState({amount: this.states.amount + 1});
  }

  render: function() {
    var title = ’Hello, ' + this.props.name;
    var description = 'You have ' + this.states.amount + ' score now.';

    return (
      <div className="score-board">
         <h1>{title}</h1>
         <p>{description}</p>
         <button onClick={handleClickAdd}>+1</button>
      </div>
    );
  }
});

var ScoreList = React.createClass({
  render() {
    return (
      <ul className="score-list">
        <li><Score name="Tom" /></li>
        <li><Score name="Jerry" /></li>
      </ul>
    );
  }
});

ReactDOM.render(
  <ScoreList />,
  document.getElementById('content')
);

```

这个例子中有两类View，分别是Score和ScoreList。ScoreList的render函数中使用Score标签并给出配置项name的值。详细看一下Score，ReactJs提供`createClass`方法定义视图，在`render`函数中通过`this.props`访问外部传入的配置项，通过`this.states`访问视图内部的状态。从意图上看，`props`外部传入视图的配置项，拥有者是父视图，视图内部只能读取配置项，`states`的拥有者是视图自身。

区分`props`和`states`的结果就是，子视图没办法直接改变父视图，视图改变一定是自触发改变的视图开始向子视图传播。对上面的例子，当Tom的Score改变时，ScoreList其他部分一定不会改变，所以视图更新从Tom的Score视图开始就可以，这就保证了能更高效地计算视图变化，再加上VirtualDom的使用，使ReactJs的效率大大超过其他框架。

当子视图需要改变父视图时，也一定是从父视图开始向下更新。假如上面的例子中ScoreList还有平均分的视图，当Tom的分数改变时，需要更新ScoreList中的平均分。这就需要Score视图在处理"+1"输入时把变化通知到ScoreList，做法时给Score增加配置项，ScoreList中定义更新平均分的函数并把函数作为配置项传给Score。当ScoreList更新时，因为Jerry的`props`和`states`都没变化，所以Jerry的Score视图不需要更新。

这就是ReactJs的全部秘密了(不过Web前端本身是一个复杂系统，你还需要了解更多其他内容)。
