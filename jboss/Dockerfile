FROM yannart/jboss-5.1.0.ga-jdk6

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

