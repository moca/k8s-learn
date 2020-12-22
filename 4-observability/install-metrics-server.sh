# git clone https://github.com/linuxacademy/metrics-server
# kubectl apply -f ~/metrics-server/deploy/1.8+/

# Get the latest version:
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Test that the metrics server are working
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"

