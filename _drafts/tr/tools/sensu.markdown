# Sensu

Many monitoring tools are built around the idea of the machine. We monitor what the machine is doing and which software is running on it. When it comes to cloud based infrastructure, especially patterns like Phoenix and Immutable servers this is a problematic approach. Machines come and go, but what is important is that the services remain working. Sensu allows a machine to register itself as playing a particular role and Sensu then monitors it on that basis. When we are finished with the machine we can simply de-register it.
