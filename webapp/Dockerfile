FROM centos:7


# Update OS and install required packages
##########################################
RUN yum -y update \
&& yum -y install wget git \
&& yum clean all


# Install JAVA Oracle JDK 8
##########################################
RUN cd /tmp \
&& wget --continue --no-check-certificate --header "Cookie: oraclelicense=a" -O jdk-linux-x64.rpm "http://download.oracle.com/otn-pub/java/jdk/8-b132/jdk-8-linux-x64.rpm" \
&& yum localinstall -y jdk-linux-x64.rpm \
&& rm -rf /tmp/* \
&& ln -s /usr/java/default/bin/java /usr/local/bin
ENV JAVA_HOME /usr/java/default


# Install Maven
##########################################
ENV MVN_VERSION 3.3.9
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
ENV APP_NAME task-manager

# Version of the application
ENV APP_VERSION 0.0.1-SNAPSHOT

# Git repository
ENV APP_GIT_REPOSITORY https://github.com/yannart/task-manager-app.git

# Git commit to compile
ENV APP_GIT_COMMIT a847e6632c44549e7c739d46945c27203ad6e091

# Binary name
ENV APP_BIN ${APP_NAME}-${APP_VERSION}.jar

# Application installation folder
ENV APP_HOME /opt/${APP_NAME}

RUN git clone ${APP_GIT_REPOSITORY} /tmp/${APP_NAME} \
&& cd /tmp/${APP_NAME} \
&& git reset --hard ${APP_GIT_COMMIT} \
&& mvn clean package \
&& mkdir -p ${APP_HOME} \
&& mv /tmp/${APP_NAME}/target/${APP_BIN} ${APP_HOME}/ \
&& rm -rf /tmp/* \
&& echo ${APP_NAME} > ${APP_HOME}/VERSION \
&& echo ${APP_VERSION} >> ${APP_HOME}/VERSION \
&& echo ${APP_GIT_COMMIT} >> ${APP_HOME}/VERSION

# Copy files to deploy for local development
#COPY ./deploy/* ${APP_HOME}/

# Working directory
WORKDIR ${APP_HOME}

CMD java -jar $APP_BIN

EXPOSE 8080
