# Flux and EmberJS component

[Flux](https://facebook.github.io/flux) is a pattern that Facebook uses for building client-side web applications. It features with unidirectional data flow, roles of dispatcher, store, action, view.

Recently, I was in a project bulding a front-end component using EmberJS. I found the component in EmberJS has many similarities with Flux pattern.

## Rols mapping
Typically, a EmberJs component is composed of a view template and a component class. A view template describes the view structure, binding view elements to controller properties. A component class represents the state of the component, using computed property and observer to declare compute relationships. The component class also connects view action, with the help of EmberJS, a view action will can easily be connected with a function.

The roles in EmberJS component may not be the same as roles in Flux, but all responsibilities can be found in EmberJS.

### Create and send actions
The _View_ in Flux has responsibility of sending actions to _Dispatcher_. The component class in EmberJS fullfills this responsibility. A DOM event will map to an action defined in component class, and the action can create and send action to other components through _event dispatcher_ in EmberJS.

The _Action_ in Flux needs a specific field for type, so that a _Store_ can distinguish it. Since EmberJS matches action name with function name, so there is less boiler plate code.

### Dispatch actions
The _Dispatcher_ in Flux dispatches actions to _Store_. This responsibility can be found in the event dispatcher in EmberJS, and EmberJS does more. In Flux, the receiver -  _Store_ needs to first register callback in _Dispatcher_. In EmberJS, the event dispatcher will automatically match action name with function name, and will broadcast the event along controller hierarchy, so there's no need to specifically register a callback.

To solve the dependency between _Store_, Flux introduced _waitFor_ method in _Dispatcher_. In EmberJS, the dependency between objects is built in blood, so there's no need to introduce any more new concepts. The _computed property_ and _observer_ can declare dependencies in an elegant way, and the _runloop_ in will take greate care to manage the computation order. In addition, the _computed property_ can cache data and _runloop_ can [merge multiple set operations](http://guides.emberjs.com/v1.13.0/understanding-ember/run-loop), which would be much better in performance than explicit _waitFor_.

### Manage application state
[The _Store_ in Flux manages application state in a particular domain within the application](https://facebook.github.io/flux/docs/overview.html#content). This is what a _component class_ and other model classes does in EmberJS.
A _Store_ notifies property change by broacasting event, and then the view query the new state and update themselves. In EmberJS, view declares binding to property of _component class_, whenever state changes in _component class_ view property will be automatically updated by _runloop_, there's no need for a _component class_ to broacast event except some rare cases. But even in those rare cases, it's easy to notify property change, a _component class_ can simply call `this.propertyChange('propertyName')` to notify observers.

If the application state is very complicated, then EmberJS will be more suitable to use. The reason is you can create a bunch of models to express you state structure, and declare calculational relationships using computed property and observer. The state change in models would be automatically recognized by _runloop_ and then reflected as property change in _component class_, and then view binding will be notified. In rare cases like, if the dependency chain is too complicated to declare, you can explicitly told _runloop_ some property is changed by simply call `someObject.propertyChange('propertyName`). The declarative way is good for [describing complext state](https://github.com/cyjia/cyjia.github.io/blob/master/posts/2015-08-15-tree-structure-with-emberjs.md).

## Controller view
Flux mentioned controller view, which is a special kind of view listen for application state change event and trigger nested views to update themselves. React and EmberJS are both good at build composable components/views. For a single component its works well in Flux way, but when there are many components and their application state intersects in some way, it's still quite complicated to coordinate order of updating states and sending actions.

For example, to manage a table of rows with parent and children relationship. Any time a parent row expanded, the total rows count should increase and the parent row state should be changed to expanded. We need to control the order of updating row state, updating row count, create new rows, updating table height, create new row views. The application state of a row view is part of the application state of the table. A generate rule is to update application state and then update view. But here, we need also to manage order of updating application state of multiple views, and the order of updating views should be acted in concert with order of updating application state.

To solve all this complexity, a view at the top of view hierarchy could be selected as a controller view and bind to the overall application state. Any action in the view hierachy will result in the application state change in controller view, then controller view will fore its descendents views to update themselves. The appllication states for all views can depend or observer each other, and the _runloop_ will ensure they are calculated in right order.

In the example above, we have two kind of views, naming _Table_, _Row_ and _Cell_. The application states are _TableRows_, _GroupRow_, and _CellContent_. The expand action triggers in view _Cell_, and then _GroupRow_ is updated to `expanded` state, and then _TableRows_ updates `rowsCount`, and then _Table_ view update itself and its descending views.

## Summary
In summary, Flux pattern is well supported in EmberJS and it's much easier to use in EmberJS; _controller view_ is a usfule concept for structuring data flow in complex components.
