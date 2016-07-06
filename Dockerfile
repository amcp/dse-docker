FROM ubuntu

#install dependencies
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y apt-transport-https \
  curl \
  ifupdown \
  iproute2 \
  isc-dhcp-client \
  isc-dhcp-common \
  libatm1 \
  libdns-export162 \
  libgdbm3 \
  libisc-export160 \
  libmnl0 \
  libopts25 \
  libperl5.22 \
  libpython-stdlib \
  libpython2.7-minimal \
  libpython2.7-stdlib \
  libxtables11 \
  netbase \
  ntp \
  openjdk-8-jdk \
  perl \
  perl-modules-5.22 \
  python \
  python-minimal \
  python2.7 \
  python2.7-minimal \
  rename

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

# Expose ports:
# Cassandra
# Solr (assuming DSE Max)
# Spark (assuming DSE Max)
# Hadoop (assuming DSE Max)
# Hive/Shark
# OpsCenter agent

EXPOSE 7000 9042 9160 \
       8983 8984 \
       4040 7080 7081 7077 \
       8012 50030 50060 9290 \
       10000 \
       61621

CMD /bin/bash
