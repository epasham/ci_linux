#Stage 1: build from source code
FROM centos:centos7.2.1511 

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
# RUN groupadd -r redis && useradd -r -g redis reids

# Install dependencies
RUN yum -y install make gcc cc tar

# Copy source code
COPY redis-4.0.11.tar.gz /tmp

# Install Redis
RUN \
  cd /tmp && \
  tar xvzf redis-4.0.11.tar.gz && \
  cd redis-4.0.11 && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(protected-mode .*\)$/protected-mode no/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf

# Define mountable directories
VOLUME ["/data"]
VOLUME ["/etc/redis"]

# Define working directory
WORKDIR /data

# Define entrypoint . TODO: change to CMD to support sentinel
CMD ["redis-server", "/etc/redis/redis.conf"]

# Default redis-server port
EXPOSE 6379
