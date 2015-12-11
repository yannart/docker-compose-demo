## Docker Compose Demo

This is an example of how Docker can be used to compose a complete environment.
The containers used in this demo are:
* **dockerui**: Container that exposes DOcker UI dashboard.
* **apache**: Apache HTTPD used as a front of JBoss.
* **jboss**: App "task-viewer" running on Jboss 5.1.0GA with Java 6. The image is based on Centos 6.7. The application is downloaded from "https://github.com/yannart/task-viewer.git" and compiled with Maven when the Docker image is built.
* **webapp**: App "task-manager-app" running as an executable jar with an embedded Tomcat server on Java 8. The image is based on last version available of Centos 6.7. The application is downloaded from "https://github.com/yannart/task-manager-app.git" and compiled with Maven when the Docker image is built.
* **mysql**: MySQL server based on official Docker image, loads initial SQL script at first execution to prepare the schema required by the applications.
* **elasticsearch**: Elasticsearch container using the last Elasticsearch official image.
* **activemq**: Last version available of webcenter/activemq Docker image.

### Install Docker Toolbox for Windows
Download and install Docker Toolbox (require >= 1.9.1c): https://www.docker.com/docker-toolbox

Add these lines in "C:\Windows\System32\drivers\etc\hosts":
  ```
  DOCKER_HOST_IP mysql
  DOCKER_HOST_IP docker.host
  ```

Where DOCKER_HOST_IP is the IP of Docker VM.

### Create / start the Docker host VM

The commands need to be executed from the Bash console included with Git.

  ```
	docker-machine create ggdocker --driver virtualbox
	docker-machine stop ggdocker
  ```

* In VirtualBox, modify the ggdocker VM to:
  * Increase the memory (tested with 4GB)
  * Setup a shared folder "container_data" checking the option "auto-mount". The selected folder in Windows will contain the data and logs of the containers.

* Start the VM
  ```docker-machine start ggdocker```
	
* Execute the commands to share the folder:
  ```
  docker-machine.exe ssh ggdocker 'sudo mkdir --parents //container_data'
  docker-machine.exe ssh ggdocker 'sudo mount -t vboxsf container_data //container_data'
  ```

* Update the Docker environment
  ```
  eval "$(docker-machine env ggdocker)"
  export DOCKER_HOST_IP=`docker-machine ip ggdocker`
  ```

### Run the containers

  ```
  docker-compose up activemq apache dockerui elasticsearch jboss mysql webapp
  ```

* Access to the web consoles (Be sure you added "docker.host" to your "hosts" file):
  * JBoss:
    * Management (if port 8080 is exposed): http://docker.host:8080
    * Task Viewer (if port 8080 is exposed): http://docker.host:8080/task-viewer
  * Webapp Task Management: http://docker.host:8090/home
  * ActiveMQ: http://docker.host:8161/admin/
  * Apache:
    * Root: http://docker.host
    * Task Viewer: http://docker.host/task-viewer
  * Elasticsearch:
    * HTTP API: http://docker.host:9200
    * Kopf dashboard: http://docker.host:9200/_plugin/kopf/
  * Docker UI: http://docker.host:9000

* Other commands:
To execute a bash inside an image:
  ```
  docker exec -i IMAGEID bash
  ```
 
To force to rebuild a project:
  ```
  docker-compose build --no-cache apache
  ```
