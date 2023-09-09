# Spring_Boot_Application_k8s
Here we are going to deploy our application in our kubernetes cluster.

1. Create a Kubernetes Cluster.
    For Creating the cluster we need servers which have at least 2 GB ram. So choose t2.medium (which is not under the free tier).
    In both master and worker nodes create (sudo vi script.sh) run that file(./script.sh). It will install all required configurations on all the nodes.
    Run the below command only on Master Node/Control-plane.
        sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --kubernetes-version 1.24.0
    Run the following command to start the cluster
        mkdir -p $HOME/.kube
        sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        sudo chown $(id -u):$(id -g) $HOME/.kube/config
        export KUBECONFIG=/etc/kubernetes/admin.conf
    Create a Pod Network in the master node using the following command
        kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
    Join all the worker nodes to the kubernetes cluster.
        kubeadm token create --print-join-command
    Copy use the above obtained kubeadm join token command on each worker nodes.
        kubeadm join 68.29.82.187:8443 --token tx7by6.nae8saikiran2y3gqb \
        --discovery-token-ca-cert-hash sha256:a506a51aa88791b456275b289bedc5d3316534ff67475fdbc7c2c64ace82652f
    Check all the nodes are connected and they are in the ready state
        kubectl get nodes
        kubectl cluster-info
    Now the Kubernetes cluster is created.
   
*Application Development to Image push in the Docker Hub we already did. Kindly check how to do that from the below reference.
https://github.com/RajashekarDandamudi/Spring_boot_application.git

3. Pull the Image to Master node.
    Install Docker on Master
        sudo apt install -y docker.io
        docker login <user_name> <Password>
        docker pull <image_name:latest>

4. Write Deployment,service file and Deploy the Application.
    sudo vi deployment.yml
    sudo vi service.yml

    kubectl apply -f deployment.yml
    kubectl apply -f service.yml

    Checking the status of pods
        kubectl get pods
    
    Get the service ports by running below command
        kubectl get svc <name-of-service>-service

It will create a external ip for load balancer. We can access the application in this ip address. Kubernetes application deployment is successfuly
