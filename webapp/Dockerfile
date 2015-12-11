FROM centos

# Install required packages
RUN yum -y install wget git

# Install Oracle JDK 8
RUN wget --continue --no-check-certificate --header "Cookie: oraclelicense=a" -O jdk-linux-x64.rpm "http://download.oracle.com/otn-pub/java/jdk/8-b132/jdk-8-linux-x64.rpm"
RUN yum localinstall -y jdk-linux-x64.rpm
RUN rm jdk-linux-x64.rpm; ln -s /usr/java/default/bin/java /usr/local/bin;
ENV JAVA_HOME /usr/java/default

# Install Maven
RUN cd /tmp; wget http://www.eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN cd /opt; tar -xzf /tmp/apache-maven-3.3.9-bin.tar.gz; mv apache-maven-3.3.9 maven; ln -s /opt/maven/bin/mvn /usr/local/bin; rm -rf /tmp/*
ENV M2_HOME /opt/maven

# Download the project and compile it
RUN cd /tmp; git clone https://github.com/yannart/task-manager-app.git;
RUN cd /tmp/task-manager-app; mvn clean package;
RUN mkdir -p /opt/webapp; mv /tmp/task-manager-app/target/task-manager-0.0.1-SNAPSHOT.jar /opt/webapp/;

# Copy files to deploy
#COPY ./deploy/task-manager-0.0.1-SNAPSHOT.jar /opt/webapp/

WORKDIR /opt/webapp/

CMD ["java", "-jar", "task-manager-0.0.1-SNAPSHOT.jar"]

EXPOSE 8080
