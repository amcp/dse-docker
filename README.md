# DataStax Enterprise Cassandra in Docker

## Introduction

This project uses a modified version of the example Dockerfile taken from [here](http://www.datastax.com/resources/whitepapers/best-practices-running-datastax-enterprise-within-docker)
to start up DataStax Enterprise (DSE) 5.0 with Graph and Solr enabled, and run DataStax Studio on top of DSE. You need a working installation of Docker to use these instructions.

First, register as a user of DataStax Academy [here](https://academy.datastax.com/user/register).

Next, Clone the project with ```git clone git@github.com:amcp/dse-docker.git```
and build the DSE Docker Image with 
```docker build --build-arg DSA_EMAIL=<your DSA email> --build-arg DSA_PASSWORD=<your DSA password> -t dse/docker .```
Here, DSA stands for DataStax Academy.

Start Studio on top of the single-node cluster in a Docker container: ```docker run --privileged=true -t -i --name node1 -d -p 127.0.0.1:9091:9091 dse/docker```

Finally, navigate to the [DataStax Studio endpoint](http://localhost:9091) and choose one or both of the tutorials to explore the features of DSE Graph.
