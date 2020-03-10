# core kubeadm kubectl kubelet
# 查看k8s使用情况，1 查看命名空间 2 查看使用资源(怎么查看？？？) 3 查看nodes，pod占用资源

kubectl run kubia --image=luksa/kubia --port=8080 --generator=run/v1

kubectl expose rc kubia --type=LoadBalancer --name kubia-http

# 强制删除pod
kubectl delete pods fortune  --grace-period=0 --force

# 组件状态
kubectl get componentstatuses

# kube-system 命名空间的pod
kubectl get po -o custom-columns=POD:metadata.name,NODE:spec.nodeName --sort-by spec.nodeName -n kube-system

# 监听
kubectl get pod --watch

kubectl get nodes --all-namespaces

kubectl get pods --all-namespaces

kubectl get deploy --all-namespaces

kubectl get pods -o wide --namespace rd3


kubectl get nodes -o wide -n rd3
kubectl get pods -o wide -n rd3
kubectl get svc -o wide -n rd3
kubectl get rs -o wide -n rd3
kubectl get deploy -o wide -n rd3
kubectl get pv -o wide -n rd3
kubectl logs -n rd4  exchange-app-api-d8bf47766-krmmk

kubectl describe svc email-gateway -n rd3
kubectl describe po --namespace rd4  exchange-app-api-d8bf47766-krmmk
kubectl get pods -n rd4 exchange-app-api-d8bf47766-krmmk  -o json  # 查看pod详情
kubectl get pods -n rd4 exchange-app-api-d8bf47766-krmmk  -o yaml  # 查看pod详情
kubectl get pods -n rd4 exchange-app-api-d8bf47766-krmmk  -o yaml | grep resources -C 8 # 查看pod资源
kubectl get svc -n rd4 exchange-app-api  -o json  # 查看service详情
kubectl get ingress -n rd4 -o wide
kubectl get endpoints -n rd4 -o wide

kubectl get configmap -n rd4
kubectl get configmap jvm-heap  -n rd4 -o yaml
kubectl get configmap open-user-config-rd4  -n rd4 -o yaml

# 获取所有资源
kubectl get all -n rd4

# 想看所有Pod都在哪些节点上运行
kubectl get pod -A -o yaml |grep '^    n'|grep -v nodeSelector|awk 'NR%3==1{print ++n"\n"$0;next}1'
# 想看所有Pod都在哪些节点上运行,过滤系统的
kubectl get pod -A -o yaml |grep '^    n'|grep -v nodeSelector|sed 'N;N;s/\n/ /g'|grep -v kube-system

# 查看所有pod
kubectl get pods -A
# 过滤系统的
kubectl get pod -A |grep -v kube-system
# 查看所有deploy
kubectl get deploy -A

# 进入某个pod
kubectl -n rd4 exec -it exchange-app-api-d8bf47766-krmmk  /bin/bash
# 日志目录
# /data/logs/app/exchange-app-api

# 查看日志
kubectl -n rd4 exec -it `kubectl get pods -n rd4 | grep 'exchange-web-api' | awk '{print $1}' | awk 'NR==1'` /bin/bash
# shell:kubectl -n $1 exec -it `kubectl get pods -n $1 | grep $2 | awk '{print $1}' | awk 'NR==1'` /bin/bash

kubectl get pods -n saas-new-taobao | grep operate-web | awk '{print $1}' | awk 'NR==1'


# context
kubectl config view


# 查看失败pod思路：一直处于pendind
kubectl describe pod finance-65898f4cb8-mnfjr -n rd4 | grep -A 3 Events

# 查看pod所在node
kubectl describe pod finance-65898f4cb8-mnfjr -n rd4 | grep -A 3 Events # From列

# 查看node详情，资源是否够，计算资源和已经使用量
kubectl describe nodes node8

# 查看namespace
kubectl describe ns rd4


# limitRange资源
kubectl get limits --all-namespaces

# 查看ResourceQuota -资源配额
kubectl get quota  --all-namespaces
# 查看namespace占用资源
kubectl get quota -n rd4
kubectl describe quota -n rd4

# 通过ResourceQuota和LimitRange进行资源管理

# k8s监控 kubectl top
kubectl get nodes -o wide
kubectl top node
# 查看namespace下pod占用资源
kubectl top  pod -n rd4

kubectl cluster-info

# kubectl资源类型  https://kubernetes.io/docs/reference/kubectl/overview/#resource-types

# 查看sts资源 statefulsets
kubectl get sts --all-namespaces  -o wide

# 查看serviceaccount
kubectl get sa --all-namespaces  -o wide


# k8s权威指南第五章


# k8s log
systemctl list-units | grep kube
systemctl status kubelet.service
# kubelet日志
journalctl -u kubelet
# kube-controller-manager日志

# kube-scheduler日志


# 所有资源在ns下的 查看资源列表
kubectl api-resources --namespaced=true
# 不在namespace下的资源
kubectl api-resources --namespaced=false


kubectl api-versions

# 对象字段描述
kubectl explain pod
kubectl explain pod.spec

# 列出API所有字段
kubectl explain svc --recursive

# 查看某个字段含义
kubectl explain svc.spec.ports

# 字段选择器
kubectl get pods --field-selector status.phase=Running
kubectl explain pod.status.phase
kubectl get services  --all-namespaces --field-selector metadata.namespace!=default
kubectl get pods --field-selector=status.phase!=Running,spec.restartPolicy=Always
kubectl get pods --field-selector=status.phase==Running,spec.restartPolicy=Always -n rd4
kubectl get statefulsets,services --all-namespaces --field-selector metadata.namespace!=default
kubectl get statefulsets --all-namespaces --field-selector metadata.namespace=rd4
