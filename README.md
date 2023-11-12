# sample-app

- git clone https://github.com/MetinAdem/sample-app.git

- If Docker is not install, you have to read following link ;
    https://docs.docker.com/desktop/install/mac-install/

- Kubernetes installation is done in oneclick_install.sh script that's why you don't need to do anything.
##### In this line --> brew install k3d ####

- The steps in the oneclick_install.sh script were tried to be explained in one sentence.

- You can run the oneclick_install.sh with the commands below;

    ./oneclick_install.sh --> this command does'nt work run the command "chmod +x oneclick_install.sh" and try again or
    bash oneclick_install.sh --> you can use this command 


After script runs, your setup will be ready !!!


############### EXTRA INFORMATIONS #######################

- If you want to use the image as Docker, I push the image my repo
    You can pull the command ---> "docker pull ademmetin/sample-app:v1" 

- Run command ---> docker run -d -p 8080:80 --name sample-appv2 sample-app  

NOTE: If 8080 port is not free in your pc, you have to change port from "8080:80" part

      If You want to change from k8s, you have to change;
      - kubectl port-forward svc/sample-app-service 8080:80 in this line.
      This line is the last line in the oneclick_install.sh script.

- Dockerfile is ademmetin/sample-app:v1 codes. If you want to local build
You run this command --> "docker build -t sample-app ."   

##### Deployment.yaml #####

Kubernetes YAML definition file that includes an Ingress, a Service for load balancing, and a Deployment with two pods.
These kinds seperated by "---", If you want, you can divide it into 3 separate files. 

1- Deployment:

Creates a Deployment with two replicas (pods) running your Docker image.
Listens on port 80.

2- Service:

Creates a Service for load balancing across the pods.
Listens on port 80.

3- Ingress:

Creates an Ingress resource to handle HTTP requests from outside the cluster.
Uses the traefik Ingress controller annotation for rewriting the URL path.
Associates the Ingress with the previously defined Service.
Specifies the domain (http://localhost:8080/WeatherForecast) for routing external traffic to the Service.


########## FINAL ###########

    http://localhost:8080/WeatherForecast  click and see the result