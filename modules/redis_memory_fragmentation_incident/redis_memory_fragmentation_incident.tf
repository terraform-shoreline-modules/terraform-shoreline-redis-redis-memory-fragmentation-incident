resource "shoreline_notebook" "redis_memory_fragmentation_incident" {
  name       = "redis_memory_fragmentation_incident"
  data       = file("${path.module}/data/redis_memory_fragmentation_incident.json")
  depends_on = [shoreline_action.invoke_redis_optimize]
}

resource "shoreline_file" "redis_optimize" {
  name             = "redis_optimize"
  input_file       = "${path.module}/data/redis_optimize.sh"
  md5              = filemd5("${path.module}/data/redis_optimize.sh")
  description      = "Optimize the Redis configuration by tuning the maxmemory parameter and setting eviction policies to prevent over-allocation of memory."
  destination_path = "/tmp/redis_optimize.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_redis_optimize" {
  name        = "invoke_redis_optimize"
  description = "Optimize the Redis configuration by tuning the maxmemory parameter and setting eviction policies to prevent over-allocation of memory."
  command     = "`chmod +x /tmp/redis_optimize.sh && /tmp/redis_optimize.sh`"
  params      = ["MAX_MEMORY","EVICTION_POLICY"]
  file_deps   = ["redis_optimize"]
  enabled     = true
  depends_on  = [shoreline_file.redis_optimize]
}

