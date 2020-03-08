kubectl run kubia --image=luksa/kubia --port=8080 --generator=run/v1

kubectl expose rc kubia --type=LoadBalancer --name kubia-http

# 强制删除pod
kubectl delete pods fortune  --grace-period=0 --force

