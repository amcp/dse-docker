# DataStax Enterprise Cassandra in Docker

## Introduction

This is the example Dockerfile taken from [here](http://www.datastax.com/resources/whitepapers/best-practices-running-datastax-enterprise-within-docker)

Clone the project and build the DSE Docker Image ```docker build -t dse/docker .```

You can deploy a cluster of nodes by runnning the cluster-launcher.sh script ```./cluster-launcher.sh dse/docker [num_nodes]```

You can also specify node type after num_nodes, for example  ```./cluster-launcher.sh dse/docker 3 -k```. This would give bring up 3 DSE Cassandra nodes in Spark Analytics mode. 

Connect to a running node with ```docker exec -it node1 bash```

