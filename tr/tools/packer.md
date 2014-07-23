# Packer

We featured ‘Machine image as a build artifact’ in the last Radar, as an excellent way to implement fast spin-up, immutable servers. The thing holding this technique back was the difficulty in building images, especially when targeting more than one platform. Packer (packer.io) solves this, using your configuration management tool of choice to create images for a number of platforms including AWS, Rackspace, DigitalOcean and even Docker and Vagrant, although we have found the VMWare support to be problematic.
