# Initialize the cluster:
sudo nano /proc/sys/net/ipv4/ip_forward
# (Change from 0 to 1) 
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Set up local kubeconfig:
mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel networking:
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/3f7d3e6c24f641e7ff557ebcea1136fdf4b1b6a1/Documentation/kube-flannel.yml