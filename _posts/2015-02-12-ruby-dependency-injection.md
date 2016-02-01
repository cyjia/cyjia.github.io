---
layout: default
---
# [DHH's view](http://david.heinemeierhansson.com/2012/dependency-injection-is-not-a-virtue.html)
## My understanding
  The example used by DHH didn't get the point. The dependency of Time.now hardcoded the type with Time, what we need here is only an object who can respond to method now and return 'now', the object is not necessarily named as Time, it could be UTCTime, CenterTime and others.
