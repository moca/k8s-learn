# Join the node to the cluster. 
# Do this by copying the provided line from the output when 
# initializing the master node. Keep in mind that when copying the command, 
# the system will add a newline character if it stretches over 
# multiple lines in the web terminal. 
$controller_private_ip= 
$token= 
$hash=

sudo kubeadm join $controller_private_ip:6443 --token $token --discovery-token-ca-cert-hash $hash