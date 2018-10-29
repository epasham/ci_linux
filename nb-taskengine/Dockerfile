FROM centos:centos7.2.1511

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
# RUN groupadd -r netbrain && useradd -r -g netbrain netbrain

# Copy files to container
COPY . /tmp

# Install java 10
RUN \
  cd /tmp && \
  yum install -y jre-10.0.2_linux-x64_bin.rpm && \
  rm jre-10.0.2_linux-x64_bin.rpm && \
  mkdir -p /home/netbrain/taskengine/ && \
  mv docker-entrypoint.sh /home/netbrain/taskengine/ && \
  mv task-engine-netty.jar /home/netbrain/taskengine/ && \
  mv conf /home/netbrain/taskengine/ && \
  cd /home/netbrain/taskengine


# Define mountable directories
# VOLUME ["/data"]
VOLUME ["/home/netbrain/taskengine/conf"]
VOLUME ["/home/netbrain/taskengine/logs"]

# Define working directory
WORKDIR /home/netbrain/taskengine

# examine files
#RUN ls /home/netbrain/taskengine

# test run
#RUN pwd
#RUN ./docker-entrypoint.sh

# Define entrypoint
#ENTRYPOINT ["pwd"]
ENTRYPOINT ["./docker-entrypoint.sh"]

