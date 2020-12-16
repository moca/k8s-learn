# Get new repos and update repo dbs
sudo apt-get update && sudo apt-get install -y apt-transport-https

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

# Install the packages. Install current stable Kubernetes version. Mark the packages ;)
sudo apt-get install -y docker-ce=18.09 kubelet=1.16.15-00 kubeadm=1.16.15-00 kubectl=1.16.15-00
sudo apt-mark hold docker-ce kubelet kubeadm kubectl

# Enable iptables bridge call
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf

sudo modprobe br_netfilter

sudo sysctl -p