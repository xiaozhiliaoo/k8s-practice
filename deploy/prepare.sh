minikube start --kubernetes-version v1.10.0 --memory 8192 --cpus 2 --vm-driver=none --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'

helm repo add stable https://kubernetes-charts.storage.googleapis.com

helm repo update

