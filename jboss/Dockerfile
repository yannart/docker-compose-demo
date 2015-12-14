FROM centos:6.7


# Update OS and install required packages
##########################################
RUN yum -y update \
&& yum -y install git tar unzip wget \
&& yum clean all
 

# Install JAVA Oracle JDK 6u45
##########################################
RUN wget --continue --no-check-certificate --header "Cookie: oraclelicense=a" -O jdk-linux-x64.rpm.bin "http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64-rpm.bin" \
&& sh jdk-linux-x64.rpm.bin \
&& rm jdk-linux-x64.rpm.bin
ENV JAVA_HOME /usr/java/default

# Install JBoss 5.1.0.GA
##########################################
RUN wget -O jboss.zip http://sourceforge.net/projects/jboss/files/JBoss/JBoss-5.1.0.GA/jboss-5.1.0.GA-jdk6.zip/download \
&& unzip jboss.zip \
&& mv jboss-5.1.0.GA /opt \
&& rm jboss.zip \
&& ln -s /opt/jboss-5.1.0.GA /opt/jboss \
&& cd /opt/jboss-5.1.0.GA/bin \
&& chmod +x *.sh
ENV JBOSS_HOME /opt/jboss

# Install Maven
##########################################
# Maven version. 3.2.5 is last version compatible with Java 6, see https://maven.apache.org/docs/history.html)
ENV MVN_VERSION 3.2.5
RUN cd /tmp \
&& wget http://www.eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
&& cd /opt \
&& tar -xzf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz \
&& mv apache-maven-${MVN_VERSION} maven \
&& ln -s /opt/maven/bin/mvn /usr/local/bin \
&& rm -rf /tmp/*
ENV M2_HOME /opt/maven


# Install application
##########################################

# Name of the application
ENV APP_NAME task-viewer

# Version of the application
ENV APP_VERSION 1.0.0-SNAPSHOT

# Git repository
ENV APP_GIT_REPOSITORY https://github.com/yannart/task-viewer.git

# Git commit to compile
ENV APP_GIT_COMMIT 61e7898713c32e4e30a88cfc014e03f27b0a7792

# Binary name
ENV APP_BIN ${APP_NAME}-${APP_VERSION}.war

# Application installation folder
ENV APP_HOME /opt/jboss/server/default/deploy

RUN git clone ${APP_GIT_REPOSITORY} /tmp/${APP_NAME} \
&& cd /tmp/${APP_NAME} \
&& git reset --hard ${APP_GIT_COMMIT} \
&& mvn clean package \
&& mv /tmp/${APP_NAME}/target/${APP_BIN} ${APP_HOME}/${APP_NAME}.war \
&& rm -rf /tmp/* \
&& echo ${APP_NAME} > ${APP_HOME}/VERSION \
&& echo ${APP_VERSION} >> ${APP_HOME}/VERSION \
&& echo ${APP_GIT_COMMIT} >> ${APP_HOME}/VERSION

# Copy files to deploy
#COPY ./deploy/* ${APP_HOME}/

# Run JBoss
CMD ["/opt/jboss/bin/run.sh", "-b", "0.0.0.0"]

EXPOSE 8080
EXPOSE 8009

