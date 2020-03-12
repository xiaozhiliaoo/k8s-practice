Kubernetes  本质是在学习超大规模集群管理技术。

Redis集群。 Node，

K8S 集群的抽象。- 集群的集群。

抽象你的系统- Kubernetes objects 基础对象，控制对象

desired state

workloads:including stateless, stateful, and data-processing workloads

Kubernetes对象代表集群状态，对象配置就是集群配置。yaml配置对象，和配置bean有点类似。

对象字段：spec，status

What state you desire for the object：spec

Object Names and IDs

API资源：创建对象接口

Label selectors：对象选择器

Labels:可视化对象

构建以及定义一个集群所需要的对象(API资源)：- 资源有点像类
WorkLoads=Pod+Contoller(ReplicaSet + Deployments + ReplicationController + StatefulSets + DaemonSet + Job + CornJob)
Service
LoadBalancer
Storage(Volumes)
Secret
Config

Rancher定义资源：
istio
HPA：HorizontalPodAutoscaler

Kubernetes object model

定义一个集群以及管理集群需要什么是一直需要思考的问题！K8S只是工具。也是思想。

Pod的对象属性，Pod是什么？Pod network，storage

Contoller对Pod做了什么？replication，rollout，self-healing，rollback

Why need Pod？1 deployment, horizontal scaling, and replication. Colocation (co-scheduling), shared fate (e.g. termination), coordinated replication, resource sharing, and dependency management 基本单元
2 data sharing and communication

扩容？1 加机器 2 加Pod

k8s本质是容器化化的自动化集群管理技术。1 手动 2 自动
集群本质工作：管理资源。和操作系统一样：管理资源。只是使用抽象不同。

Kubernetes is designed for automation

Pod->RelicaSet->Deployment->Operator

Operators: Putting Operational Knowledge into Software

 An Operator is an application-specific controller that 
 extends the Kubernetes API to create, configure, and 
 manage instances of complex stateful applications on behalf
 of a Kubernetes user
 
 stateful applications： databases, caches, and monitoring systems.

etcd Operator: Simplify etcd cluster configuration and management

Operator= Contoller+Resource = Infrastructure As Code

通过一个ingress，暴露多个服务。




