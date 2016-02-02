---
layout: default
---
# Chef-solo or standalone puppet

Chef & Puppet servers are a central place to store recipes/ manifests that propagate configuration changes to managed bottleneck when multiple clients simultaneously connect to machines. They are also a central database of node information and provide access control for manifests/recipes. The disadvantage of having these servers is that they become a bottleneck when multiple clients simultaneously connect to them. They are a single point of failure and take effort to be
robust and reliable. In light of this, we recommend **chef-solo￼or standalone puppet** in conjunction with a version control￼system when the server is primarily used to store recipes/manifests. Teams can always introduce the servers as the need arises or if they find themselves reinventing solutions to the￼problems the servers have already solved.
