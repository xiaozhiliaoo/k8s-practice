kubectl run kubia --image=luksa/kubia --port=8080 --generator=run/v1

kubectl expose rc kubia --type=LoadBalancer --name kubia-http

