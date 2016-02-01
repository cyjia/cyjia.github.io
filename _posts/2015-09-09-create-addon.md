---
layout: default
---
# How to develop an addon?
[ember-cli](http://www.ember-cli.com/extending) allows you extend it by creating your own addon. ember-cli site gives an addon example of createing a component, but an addon can do a lot of things. In following scenarios we might need to create an addon, they are:
* encapsulating a bower package
* doing custom transform
* intercepting into development server
* providing custom ember command

## Addon basci info
I give specific examples for above scenarios. But before that, lets list some basic info about addon.
* [addon hooks](https://github.com/ember-cli/ember-cli/blob/master/ADDON_HOOKS.md)
* [developing addons and blueprints](http://www.ember-cli.com/extending/#developing-addons-and-blueprints)

There are two kinds of addon in general, one is in-repo addon, meaning it stays under folder `lib` in your application; the other is a common addon, meaning it is provided in a npm package. An in-repo addon is used to do small things. When the addon itself needs dependencies, you'd better use `packge.json` of the app rather then the addon. If you add dependencies in the addon's `package.json`, then you will have to run `npm install` in the addon's folder.

## Encapsulating a bower package
Let's say, we have a bower package, which can provide cool effects, such as [toastr](https://github.com/CodeSeven/toastr). Without an addon, you will have to add lines of code to include js and css files. Fourtunally, there's an addon [here](https://github.com/knownasilya/ember-toastr), now we can use it with one command `ember install ember-toastr`.

To create an addon, we need at least two files `index.js` and `package.json`. In `index.js` you declare addon info and provide hook functions.

```javascript

'use strict';

module.exports = {
    name: 'ember-toastr',

    included: function(app, parentAddon) {
        // you code here
        var target = (parentAddon || app);
        var bowerDir = target.bowerDirectory;

        target.import(bowerDir + '/toastr/toastr.js');
        target.import(bowerDir + '/toastr/toastr.css');
    }

};

```
Explaination of each hook can be found [here](https://github.com/ember-cli/ember-cli/blob/master/ADDON_HOOKS.md). This addon used hook `included` to add `toastr.js` and `toastr.css` files.

In `package.json`, you declare meta info.

```json
{
    "name": "ember-toastr",
    "description": "Ember wrapper for Toastr.js notifications",
    "keywords": [
        "ember-addon"
    ]
}
```

Please note that `keywords` must include value _ember-addon_, otherwise Ember will not recognize this package as an addon.

## Doing custom transform
Suppose we have many static content written in markdown, and we want to transform these files into handlebars files when doing Ember build.
[ember-cli-coffeescript](https://github.com/kimroen/ember-cli-coffeescript) does similar job. Its `index.js` file registered a coffee processor for type `js`.
```javascript
'use strict';

module.exports = {
    name: 'Ember CLI Coffeescript Addon',

    setupPreprocessorRegistry: function(type, registry) {
        registry.add('js', {
            'name': 'ember-cli-coffeescript',
            'ext': 'coffee',
            toTree: function(tree, inputPath, outputPath) {
              //transform files
            }
        })
    }
}
```

In our case, it's a little different, we want markdown transform happens before handlebars. So we use 'preprocessTree' hook.

```javascript
    'use strict';
    var MarkdownProcessor = require('./lib/markdown-processor');
    module.exports = {
        preprocessTree: function(type, tree) {
            if (type === 'template') {
                return MarkdownProcessor(tree);
            }
            return tree;
        }
    }

```

The `markdown-processor` use [broccoli-filter](https://github.com/broccolijs/broccoli-filter) to filter out `.md` files and use [marked](https://github.com/chjj/marked) to transform them into `.hbs` files.

```javascript
'use strict';

var Filter = require('broccoli-filter');
var RSVP = require('rsvp');
var marked = require('marked');
var renderer = new marked.Renderer();

function MarkdownProcessor(inputTree, options) {
  if (!(this instanceof MarkdownProcessor)) {
    return new MarkdownProcessor(inputTree, options);
  }

  this.inputTree = inputTree;

  renderer.list = function(body, ordered) {
    return body;
  };
  marked.setOptions({renderer: renderer});
}


MarkdownProcessor.prototype = Object.create(Filter.prototype);
MarkdownProcessor.prototype.constructor = MarkdownProcessor;

MarkdownProcessor.prototype.extensions = ['md'];
MarkdownProcessor.prototype.targetExtension = 'hbs';

MarkdownProcessor.prototype.processString = function (markdownString) {
  return new RSVP.Promise(function (resolve, reject) {
    marked(markdownString, function (err, content) {
      if (err) {
        reject(err);
      } else {
        resolve(content);
      }
    });
  });
};

module.exports = MarkdownProcessor;
```

## Intercepting into development server
This time we want to start a stub server in test and development environment. I know we can use mock server provided by ember-cli, but we do have strong reasons to define a stub server.

We use hook 'serverMiddleware'.

```javascript
'use strict';
module.exports = {
 name: 'ember-cli-stub-server',

  serverMiddleware: function(middlewareContext) {
    var emberOptions = middlewareContext.options;
    var app = middlewareContext.app;
    if (emberOptions.environment === 'development') {
      var serverOptions = {
        dataSetsDir: this.project.root + '/' + 'datasets',
        host: emberOptions.host
      };
      var startServer = require('./lib/stub-server');
      return startServer(app, serverOptions);
    }
  }

};
```

## Providing custom ember command
In the last case, we want to provide custom command. [ember-cli-cordova](https://github.com/poetic/ember-cli-cordova) does similar things.We need to use hook `includedCommands` to return our commands.

```javascript
'use strict';
module.exports = {
    includedCommands: function () {
        return commands;
    }
}
```
## Reference
* [ember-cli](http://www.ember-cli.com/extending)
* [addon hooks](https://github.com/ember-cli/ember-cli/blob/master/ADDON_HOOKS.md)
