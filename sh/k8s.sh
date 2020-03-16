# core kubeadm kubectl kubelet
# https://kubernetes.io/docs/reference/kubectl/cheatsheet/
# https://github.com/dennyzhang/cheatsheet-kubernetes-A4

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
kubectl get pods --show-labels  -n saas-new-taobao
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
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
# -o yaml pod对象以ymal展示
kubectl get configmap tomcat-config-dev5 -n saas-new-taobao -o yaml


# 获取所有资源
kubectl get all -n rd4
kubectl get all -n rd4

# 想看所有Pod都在哪些节点上运行
kubectl get pod -A -o yaml |grep '^    n'|grep -v nodeSelector|awk 'NR%3==1{print ++n"\n"$0;next}1'
# 想看所有Pod都在哪些节点上运行,过滤系统的
kubectl get pod -A -o yaml |grep '^    n'|grep -v nodeSelector|sed 'N;N;s/\n/ /g'|grep -v kube-system
# pod调度节点统计
kubectl get pod -n saas-new-taobao -o wide
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
kubectl get limitrange --all-namespaces

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

# 查看node详情
kubectl get node -o yaml

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
kubectl api-resources -o name
kubectl api-resources -o wide
kubectl api-resources --api-group=extensions

kubectl api-versions

# 对象字段描述
kubectl explain pod
kubectl explain pod.spec
# POD生命周期
kubectl explain pod.status.phase
# 容器生命周期
kubectl explain pod.spec.containers.lifecycle
# 重启策略
kubectl explain pod.spec.restartPolicy

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

# 查看控制器事件
 kubectl get event --watch


# 查看sevice account
kubectl get sa -n test


# 查看role
kubectl get role --all-namespaces
kubectl get rolebinding --all-namespaces
kubectl get clusterrole --all-namespaces
kubectl get clusterrolebinding --all-namespaces


# 查看PodSecurityPolicy
kubectl get psp


# 查看(kubectl describe node)节点资源cpu内存等，并非实际使用，而是request和limit
kubectl describe nodes
#节点实际CPU和内存
kubectl top node
kubectl top node | sort --reverse --key 3 --numeric | head -10
# why kubectl top node 和 rancher node信息不一样？？
kubectl top node master01
kubectl describe node master01


kubectl top pod
kubectl top pod -n rd4
# 前十个POD内存占用  column 3 descending
kubectl top pod -n rd4 | sort --reverse --key 3 --numeric | head -10
# 前十个PODCPU占用  column 3 descending
kubectl top pod -n rd4 | sort --reverse --key 2 --numeric | head -10
# 查看pod里面容器占用资源
kubectl top pod exchange-web-api-66d69c6dd5-vd8k8 -n saas-new-taobao --containers

# 获取自定义资源
kubectl get crd
kubectl describe crd aliyunlogconfigs.log.alibabacloud.com


# 查看环境变量
kubectl exec -n saas-new-taobao exchange-open-api-675cc6c984-mszrp env

# 查看ingress暴露的url
kubectl describe ingress -n saas-new-taobao
kubectl get ingress --all-namespaces
kubectl describe ingress exchange-ingress -n saas-new-taobao

# 查看CrashLoopBackOff错误(每次奔溃后重启)
kubectl describe pod open-user-6865b88b57-8tvcq -n saas-new-taobao

kubectl exec -it operate-api-6ccdf85cc-5rttm -n saas-new-taobao top

# 0/1 nodes are available: 1 node(s) had taints that the pod didn't tolerate. 查看为什么调度失败？
kubectl describe pod limited-pod
kubectl get node -o yaml | grep taint -A 5

# HPA(HorizontalPodAutoscaler)
kubectl get hpa --all-namespaces

kubectl get node -L avaliablity-zone -L share-type

kubectl get deploy,svc,po

# 集群可用的服务 service catalog
kubectl get clusterserviceclasses
kubectl get serviceclass
kubectl get instance --all-namespaces

# 上下文和集群
kubectl config get-contexts
kubectl config get-clusters
kubectl config current-context


kubectl scale deployment nginx-deployment --replicas=4
kubectl create -f nginx-deployment.yaml --record
kubectl rollout status deployment/nginx-deployment
# 触发滚动升级
kubectl edit deployment/nginx-deployment
#  滚动升级过程
kubectl describe deployment nginx-deployment
# 直接修改deploment镜像
kubectl set image deployment/nginx-deployment nginx=nginx:1.91
kubectl rollout undo deployment/nginx-deployment
kubectl rollout history deployment/nginx-deployment
kubectl rollout history deployment/nginx-deployment --revision=2
kubectl rollout undo deployment/nginx-deployment --to-revision=2
kubectl rollout pause deployment/nginx-deploymen
kubectl rollout resume deploy/nginx-deployment



kubeadm version

# istio
# 基于istio的VirtualService和Destination完成蓝绿和灰度发布(https://help.aliyun.com/document_detail/121189.html)
# 容器服务Kubernetes版-阿里云

kubectl get VirtualService --all-namespaces
kubectl get Gateway --all-namespaces
kubectl get DestinationRule --all-namespaces
kubectl get gateway --all-namespaces
kubectl get svc istio-ingressgateway -n istio-system