FROM centos

ENV APP_NAME task-manager

ENV MVN_VERSION 3.3.9

# Install required packages
RUN yum -y install wget git

# Install Oracle JDK 8
RUN wget --continue --no-check-certificate --header "Cookie: oraclelicense=a" -O jdk-linux-x64.rpm "http://download.oracle.com/otn-pub/java/jdk/8-b132/jdk-8-linux-x64.rpm" \
&& yum localinstall -y jdk-linux-x64.rpm \
&& rm jdk-linux-x64.rpm \
&& ln -s /usr/java/default/bin/java /usr/local/bin
ENV JAVA_HOME /usr/java/default

# Install Maven
RUN cd /tmp \
&& wget http://www.eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
&& cd /opt \
&& tar -xzf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz \
&& mv apache-maven-${MVN_VERSION} maven \
&& ln -s /opt/maven/bin/mvn /usr/local/bin \
&& rm -rf /tmp/*
ENV M2_HOME /opt/maven

# Download the project and compile it
# Hash of the commit, comment the line "git reset..." to use the last version:
ENV APP_VERSION 0.0.1-SNAPSHOT
ENV COMMIT_SHA1 f5154298417e80547302e202e7b34eeb21234bc8

RUN cd /tmp \
&& git clone https://github.com/yannart/task-manager-app.git \
&& cd /tmp/task-manager-app \
&& git reset --hard ${COMMIT_SHA1} \
&& mvn clean package \
&& mkdir -p /opt/webapp \
&& mv /tmp/task-manager-app/target/${APP_NAME}-${APP_VERSION}.jar /opt/webapp/

# Copy files to deploy
#COPY ./deploy/${APP_NAME}-${APP_VERSION}.jar /opt/webapp/

WORKDIR /opt/webapp/

CMD ["java", "-jar", "task-manager-0.0.1-SNAPSHOT.jar"]

EXPOSE 8080
