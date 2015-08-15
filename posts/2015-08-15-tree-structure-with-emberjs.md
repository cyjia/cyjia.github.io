# Tree structure with EmberJS
Ember has a rich library of Array, ArrayProxy, ArrayController, with which you can created computed property and observer depends on change of array element. But Ember does not have out of box support for tree data.

In a project, I am implementing a table component to show tree data. To model it, I created a GroupRow object to represent a row, which can has many children rows, and one or zero parent row. The children rows and parent row are also GroupRow. To respond to actions like expand and collapse one row, the table will render changed rows, display more or less rows, change row expanding indicator.

The component is implemented to observe tree rows count to add, remove and redraw rows. The tree rows count will increase when a row is expanded and decrease when a row is collapsed.

## First Try
Our first implementation is to mannually notify tree rows count change.

tree-row.js

```javascript
export default Ember.Object.extend({
    expand: function(row) {
        row.toogleExpandState();
        this.recalculateRowCount();
        this.notifyPropertyChange('count');
    },
    collapse: function(row) {
        row.toogleCollapseState();
        this.recalculateRowCount();
        this.notifyPropertyChange('count');
    }
});

```javascript

This implementation works well at first, but when lazy load feature added the code became crisp. We had to be careful with order of function calls. The call to `row.toogleExpandState()` intersects with `this.calculateRowCount()`, because calculating row count should take row expand state into account. When some object obersevs row state and retrives row count in its obersver's callback it will get a old value. A general work around is to wrap behaviour of a oberserver into `Ember.run` to ensure all states are synchronized, but the solution does not work with this case as `recalculateRowCount` is a function instead of a computed property, it executes only when called. Keep this in mind, we began try to express row count in computed property and let Ember runloop to manage execution order.

## Turn to declarative
Our second implementation is to declare calculation relationship using computed property.

tree-row.js

```
export default Ember.Object.extend({
    expand: function(row) {
        row.toggleExpandState();
    },
    collapse: function(row) {
        row.toogleCollapseState();
    },
    rowCount: Ember.computed.oneWay('_virtualRoot.subRowsCount'),
    _virtualRoot: Ember.computed(function() {
    var root = GroupRow.create();
    root.toogleExpandState();
    return root;
    })
});
```

group-row.js

```
export default Ember.Object.extend({
    toggleExpandState: function() {
        this.setProperty('isExpanded', true);
    },
    toggleCollapseState: function() {
        this.setProperty('isExpanded', false);
    },
    subRowsCount: Ember.computed(function() {
        var descendentsCount = this.get('_childrenRows').reduce(function(prev, current) {
            if (!_childrenRows.get('isExpanded')) {
                return prev;
            }
            return prev + current.get('subRowsCount');
        });
        var childrenCount = this.get('_childrenRows.length');
        return childrenCount + descendentsCount;
    }).property('_childrenRows.length', '_childrenRows.@each.subRowsCount', '_childrenRows.@each.isExpanded')
});

```

This implementation looks much clear, `rowCount` is declared as computed property and it will be recalculated on get when expand state changes. But this implementation only works with two levels of tree data, the `rowCount` property in `tree-data.js` would not recalculate with three levels of tree data. We finally found the reason is that `_childrenRows.@each.subRowsCount` only propagates one level up. If `subRowsCount` change in one row of second level, then its paren row in first level will recalcuate on get, but the `subRowsCount` in root node will nevel recalculate on get unless `subRowsCount` in second level is calculated. Because of this, we come to our final implementation.

## Final version
group-row.js

```
export default Ember.Object.extend({
    toggleExpandState: function() {
        this.setProperty('isExpanded', true);
    },

    toggleCollapseState: function() {
        this.setProperty('isExpanded', false);
    },

    subRowsCount: Ember.computed(function() {
        var descendentsCount = this.get('_childrenRows').reduce(function(prev, current) {
        if (!_childrenRows.get('isExpanded')) {
            return prev;
        }
            return prev + current.get('subRowsCount');
        });
            var childrenCount = this.get('_childrenRows.length');
            return childrenCount + descendentsCount;
        }).property('_childrenRows.length', '_childrenRows.@each.subRowsCount', '_childrenRows.@each.isExpanded'),
    subRowsCountDidChange: Ember.Observer('subRowsCount', function() {
        if (this.get('parentRow')) {
            this.get('parentRow').tooglePropertyChange('subRowsCount');
        }
});

```

In the final implementation, whenever `subRowsCount` changed its parentRow will get notified, and then its parenRow will notify parent parent row until to the root row. Any observers watching `subRowsCount` on root row will get notified whenever expand state changes in each level of the tree.

Thanks to the compute property and observer in EmberJS, now the implementation looks much better.

Tree structure is common in many projects. In this case, we only focus on `subRowsCount`, there is sure to be many other aspects in other projects. They might be related to the tree structure itself, such as `depth`, `leafCount`, or they might be related to the content in the tree data, such as `sumOfxxProperty`. I hope EmberJS will provide such a structure by default, or one day someone will start a project to build one.
