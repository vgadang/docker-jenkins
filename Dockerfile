# Based on official oracle java 8 image
FROM dockerfile/java:oracle-java8

# Get basic packages
RUN apt-get update && apt-get install -y wget git curl zip && rm -rf /var/lib/apt/lists/* 

# Jenkins version
ENV JENKINS_VERSION 1.580.1

# Get Jenkins binary and install it
RUN mkdir /usr/share/jenkins/
COPY init.groovy /tmp/WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy
RUN curl -L http://updates.jenkins-ci.org/download/war/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war \
  && cd /tmp && zip -g /usr/share/jenkins/jenkins.war WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy && rm -rf /tmp/WEB-INF

# Setup jenkins home and env variables
ENV JENKINS_HOME /var/jenkins_home
VOLUME /var/jenkins_home

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

# Copy custom plugins, jobs and scripts
COPY jenkins.sh /usr/local/bin/jenkins.sh
COPY plugins /usr/share/jenkins/ref/plugins
COPY jobs /usr/share/jenkins/ref/jobs
COPY config.xml /usr/share/jenkins/ref/config.xml

# Main command to run jenkins
CMD ["/usr/local/bin/jenkins.sh"]

