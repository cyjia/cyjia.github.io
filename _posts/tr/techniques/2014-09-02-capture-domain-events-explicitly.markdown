---
layout: default
---
# capture domain events explicitly

When using techniques such as “instrument all the things” and semantic logging, it can be very useful to capture domain events explicitly. You can avoid having to infer user intent behind state transitions by modeling these transitions as first-class concerns. One method of achieving this outcome is to use an event sourced architecture with application events being mapped to business meaningful events.
