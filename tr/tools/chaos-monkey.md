# Chaos Monkey

Following our recommendation in the last radar to consider a focus on reducing mean time to recovery, we want to highlight **Chaos Monkey** from Netflix's Simian Army Suite. It is a tool that randomly disables instances in the production environment during normal operation. When run with comprehensive monitoring and a team on stand by, it helps to uncover unexpected weaknesses in the system, which in turn allows the development team to build automatic recovery mechanisms ahead of time, rather than struggling to respond to an outage that caught everyone by surprise.
