kubectl get pod -n istio-system

kubectl describe hpa istio-ingressgateway -n istio-system

watch -n 1 kubectl get hpa,deployment -n istio-system

