# Segregated DOM

As client-side JavaScript applications grow in sophistication, we see an increased need for engineering sophistication to match. A common architectural flaw is unfettered access to the DOM from across the codebase - mixing DOM manipulation with application logic and AJAX calls. This makes the code difficult to understand and extend. Thinking about separation of concerns is a useful antidote. This involves aggressively restricting all DOM access (which usually translates to all jQuery usage) to a thin ‘segregation layer’. One pleasant side-effect
of this approach is that everything outside of that segregated DOM layer can be tested rapidly in isolation from the browser using a lean JavaScript engine such as node.js.
