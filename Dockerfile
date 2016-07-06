FROM nimmis/java:oracle-8-jdk

#install dependencies
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y apt-transport-https \
  libatm1 \
  libmnl0 \
  libopts25 \
  ntp

#add datastax repository file
ARG DSA_EMAIL
ARG DSA_PASSWORD
ENV DSA_URL "deb https://${DSA_EMAIL}:${DSA_PASSWORD}@debian.datastax.com/enterprise stable main"

RUN echo "${DSA_URL}" | tee -a /etc/apt/sources.list.d/datastax.sources.list
#add datastax repository key
RUN curl -L https://debian.datastax.com/debian/repo_key | apt-key add -
#update repository
RUN apt-get update -y

#install dse and demos
RUN apt-get install -y dse-full=5.0.0-1 dse-demos

#install datastax studio
RUN curl --user ${DSA_EMAIL}:${DSA_PASSWORD} -L https://downloads.datastax.com/datastax-studio/datastax-studio.tar.gz | tar xz

# Expose ports:
# Cassandra
# Solr (assuming DSE Max)
# Spark (assuming DSE Max)
# Hadoop (assuming DSE Max)
# Hive/Shark
# OpsCenter agent
# Studio

EXPOSE 7000 9042 9160 \
       8983 8984 \
       4040 7080 7081 7077 \
       8012 50030 50060 9290 \
       10000 \
       61621 \
       9091

RUN sed -i '/GRAPH_ENABLED=0/c\GRAPH_ENABLED=1' /etc/default/dse
RUN sed -i '/SOLR_ENABLED=0/c\SOLR_ENABLED=1' /etc/default/dse
RUN sed -i '/httpBindAddress/c\\ httpBindAddress:\ 0.0.0.0' /root/datastax-studio-1.0.0/conf/configuration.yaml
ADD kickstartOneNodeCluster.sh /kickstart.sh
RUN chmod a+x /kickstart.sh
CMD /kickstart.sh
