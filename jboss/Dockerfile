FROM centos:6.7

ENV APP_NAME task-viewer

# Maven version. 3.2.5 is last version compatible with Java 6, see https://maven.apache.org/docs/history.html)
ENV MVN_VERSION 3.2.5

# Install required packages
RUN yum -y install git tar unzip wget 

# Install Oracle JDK 6u45
RUN wget --continue --no-check-certificate --header "Cookie: oraclelicense=a" -O jdk-linux-x64.rpm.bin "http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64-rpm.bin"
RUN sh jdk-linux-x64.rpm.bin \
&& rm jdk-linux-x64.rpm.bin
ENV JAVA_HOME /usr/java/default

# Install JBoss 5.1.0.GA
RUN wget -O jboss.zip http://sourceforge.net/projects/jboss/files/JBoss/JBoss-5.1.0.GA/jboss-5.1.0.GA-jdk6.zip/download
RUN unzip jboss.zip \
&& mv jboss-5.1.0.GA /opt \
&& rm jboss.zip \
&& ln -s /opt/jboss-5.1.0.GA /opt/jboss \
&& cd /opt/jboss-5.1.0.GA/bin \
&& chmod +x *.sh
ENV JBOSS_HOME /opt/jboss

# Install Maven
RUN cd /tmp \
&& wget http://www.eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz
RUN cd /opt \
&& tar -xzf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz \
&& mv apache-maven-${MVN_VERSION} maven \
&& ln -s /opt/maven/bin/mvn /usr/local/bin \
&& rm -rf /tmp/*
ENV M2_HOME /opt/maven

# Download the project and compile it
# Hash of the commit, comment the line "git reset..." to use the last version:
ENV APP_VERSION 1.0.0-SNAPSHOT
ENV COMMIT_SHA1 61e7898713c32e4e30a88cfc014e03f27b0a7792

RUN cd /tmp && git clone https://github.com/yannart/task-viewer.git \
&& cd /tmp/task-viewer \
&& git reset --hard ${COMMIT_SHA1} \
&& mvn clean package \
&& mv /tmp/task-viewer/target/${APP_NAME}-${APP_VERSION}.war /opt/jboss/server/default/deploy/task-viewer.war

# Copy files to deploy
# COPY ./deploy/* /opt/jboss/server/default/deploy/

# Run JBoss
CMD ["/opt/jboss/bin/run.sh", "-b", "0.0.0.0"]

EXPOSE 8080
EXPOSE 8009

