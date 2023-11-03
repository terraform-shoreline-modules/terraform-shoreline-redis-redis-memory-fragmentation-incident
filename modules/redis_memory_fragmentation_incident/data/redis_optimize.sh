

#!/bin/bash



# Set the maxmemory parameter to ${MAX_MEMORY} in the Redis configuration file

sudo sed -i "s/^maxmemory .*/maxmemory ${MAX_MEMORY}/" /etc/redis/redis.conf



# Set the eviction policy to ${EVICTION_POLICY} in the Redis configuration file

sudo sed -i "s/^maxmemory-policy .*/maxmemory-policy ${EVICTION_POLICY}/" /etc/redis/redis.conf



# Restart the Redis service to apply the new configuration

sudo systemctl restart redis.service





sudo ./redis_optimize.sh