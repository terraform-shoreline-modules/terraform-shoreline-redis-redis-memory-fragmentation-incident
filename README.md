
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Redis Memory Fragmentation Incident
---

Redis is an in-memory data structure store that is widely used as a caching layer in various software applications. However, frequent Redis memory fragmentation incidents occur when the memory used by Redis is not contiguous and becomes fragmented over time. This can lead to increased memory usage and slower performance of the application. When this type of incident occurs, it may require analysis and optimization of the Redis configuration to improve its memory management and reduce fragmentation.

### Parameters
```shell
export MAX_MEMORY="PLACEHOLDER"

export EVICTION_POLICY="PLACEHOLDER"
```

## Debug

### Check Redis memory usage
```shell
redis-cli info memory
```

### Check Redis fragmentation ratio
```shell
redis-cli info memory | grep fragmentation_ratio
```

### Check the amount of memory Redis is using for different types of data
```shell
redis-cli memory stats
```

### Check the number of keys in Redis and their memory usage
```shell
redis-cli --bigkeys
```

### Check if Redis is swapping memory to disk
```shell
vmstat 1
```

### Check the amount of free memory available on the system
```shell
free -h
```

### Check if any other processes are consuming too much memory
```shell
ps aux --sort=-%mem | head
```

## Repair

### Optimize the Redis configuration by tuning the maxmemory parameter and setting eviction policies to prevent over-allocation of memory.
```shell


#!/bin/bash



# Set the maxmemory parameter to ${MAX_MEMORY} in the Redis configuration file

sudo sed -i "s/^maxmemory .*/maxmemory ${MAX_MEMORY}/" /etc/redis/redis.conf



# Set the eviction policy to ${EVICTION_POLICY} in the Redis configuration file

sudo sed -i "s/^maxmemory-policy .*/maxmemory-policy ${EVICTION_POLICY}/" /etc/redis/redis.conf



# Restart the Redis service to apply the new configuration

sudo systemctl restart redis.service





sudo ./redis_optimize.sh


```