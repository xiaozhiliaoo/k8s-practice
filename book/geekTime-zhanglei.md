### 极客时间-张磊 

https://www.yuanrenxue.com/geektime/kubernetes-course.html


docker改变了云计算发展。
cf push (一键部署)
Cloud Foundry:打包流程-经典PaaS项目
PaaS核心功能应用打包失效，docker降维打击。
Docker镜像的精髓：本地环境和云端环境的高度一致！
应用生命周期管理。
Docker公司重新定义PaaS
基础设施：平台化和PaaS化
Paas思考：究竟如何给应用打包？(Paas根本性问题)
Docker为什么能成功？应用打包和发布
“容器化”取代“PaaS 化”
Docker改变了Cloud Foundry 定义的Paas
如何让开发者把应用部署在我的项目上？
平台层项目：Docker Swarm：用户提供平台层能力，否则沦为小工具，充当别的平台的工具。
Docker平台化发展和CoreOs分裂。
Fig：提出容器编排功能。 -》  Compose
Docker不是Paas
老牌集群管理项目Mesos创建Marathon
大数据所关注的计算密集型离线业务，其实并不像常规的Web服务那样适合用容器进行
托管和扩容，也没有对应用打包的强烈需求，所以 Hadoop、Spark 等项目到现在也没在容器
技术上投下更大的赌注。
Google:lmctfy（Let Me Container That For You)
Docker是容器生态的事实标准,到了容器之上的平台层不行了，Paas层。
容器编排领域“三国鼎立”：swarm， Mesos，k8s
Kubernetes过于超前。
容器监控事实标准：Prometheus
Docker 项目的边界扩展到Paas项目边界：2016 docker公司将容器编排和集群管理功能全部内置到 Docker 项目
热度极高的微服务治理项目 Istio
有状态应用部署框架 Operator
Solomon Hykes
容器本身没有价值，有价值的是“容器编排”
容器，其实是一种特殊的进程。
HostOs VS GuestOs？ 物理机OS-HostOs  虚拟机的OS-GuestOs
虚拟化技术目的：提高资源利用率。 一台物理计算机虚拟成多台逻辑计算机
Docker=进程+namespace，之前进程还是之前进程。没有变化。
Namespace修改了应用进程看待整个计算机“视图”，即它的“视线”被操作系统做了限制，只能“看到”某些指定的内容
管理docker的还是物理机资源。
低版本的 Linux 宿主机上运行高版本的 Linux 容器不行。不能改变共享宿主机内核
Microsoft-Azure-Windows服务器上创建各种linux虚拟机。
隔离与限制
Linux Cgroups：Linux Control Group
docker run -it --cpu-period=100000 --cpu-quota=20000 ubuntu /bin/bash
容器只是一种特殊的进程
容器是一个“单进程”模型，用户的应用进程实际上就是容器里 PID=1 的进程
容器设计模式
容器镜像：rootfs
docker原理：1. 启用 Linux Namespace 配置；
           2. 设置指定的 Cgroups 参数；
           3. 切换进程的根目录（Change Root-Root FS）  这三种技术创造的进程隔离  
应用依赖：操作系统本身才是它运行所需要的最完整的“依赖库”，而不是编程语言层面。
 docker run -d ubuntu:latest sleep 3600 本质是Ubuntu 操作系统的 rootfs
容器技术“强一致性”
容器镜像将会成为未来软件的主流发布方式
docker exec 是怎么做到进入容器里的呢？
一个进程，可以选择加入到某个进程已有的 Namespace 当中，从而达到“进入”这个进程所在容器的目的
从容器到容器云
1  基础设施领域先有工程实践、后有方法论的
2  理论基础则要比工程实践走得靠前得多(K8S)
Google基础设施体系论文:Borg基础设施技术栈最底层，最不可能开源的技术。
基础设施领域开源项目赖以生存的核心价值：先进性与完备性
Kubernetes 项目要解决的问题是什么？编排？调度？容器云？还是集群管理？路由网关、水平扩展、监控、备份、灾难恢复？(经典Paas项目的功能)
kubelet：CRI(Runtime Interface)，CNI(Network)，CSI(Storage)
Borg 对于 Kubernetes 项目的指导作用又体现在哪里呢？Master 节点:如何编排、管理、调度用户提交的作业
运行在大规模集群中的各种任务之间，实际上存在着各种各样的关系。这些关系的处理，才是作业编排和管理系统最困难的地方。
Borg 项目完全可以把Docker镜像看做是一种新的应用打包方式。
容器的本质，只是一个进程而已
Kubernetes 项目最主要的设计思想是，从更宏观的角度，以统一的方式来定义任务之间的各种关系，并且为将来支持更多种类的关系留有余地
Kubernetes：1 编排对象：Pod，Job，CornJob 描述管理的应用
            2 服务对象：Service、Secret、Horizontal Pod Autoscaler负责复杂平台级功能
 声明式 API
 Kubernetes 项目如何启动一个容器化任务呢？
 两个nginx以负载均衡对外提供服务？
 1 启动两台虚拟机，分别安装两个 Nginx，然后使用 keepalived为这两个虚拟机做一个虚拟 IP。           
 2 k8s:nginx-deployment.yaml  kubectl create -f nginx-deployment.yaml
集群管理项目（比如 Yarn、Mesos，以及 Swarm）所擅长的，都是把一个容器，按照某种规则，放置在某个最佳节点上运行起来。这种功能，我们称为“调度”
Kubernetes 项目所擅长的，是按照用户的意愿和整个系统的规则，完全自动化地处理好容器之间的各种关系。这种功能，就是我们经常听到的一个概念：“编排”
Kubernetes 项目的本质，是为用户提供一个具有普遍意义的容器编排工具,真正的价值，提供了一套基于容器构建分布式系统的基础依赖
mesos是旧瓶，marathon是新酒
迁移可以简单分为两类：磁盘数据文件不变，进程重启；磁盘数据文件不变、内存数据也不变，相当于连带进程一起挪过去
为什么不用容器部署Kubernetes 呢？
如何容器化 kubelet？复杂
kubelet 直接运行在宿主机上，然后使用容器部署其他的Kubernetes组件，比如 kube-apiserver、kube-controller-manager、kube-scheduler
kubelet 在 Kubernetes 项目中的地位非常高，在设计上它就是一个完全独立的组件，而其他 Master 组件，则更像是辅助性的系统容器
kubeadm 的设计非常简洁 - Lucas Käldström 18岁
kubeadm暂时不能用于生产，生产kops或者 SaltStack 或者ansible playbook，各大云厂商最常用的部署的方法，是使用 SaltStack、Ansible 等运维工具自动化地执行这些步骤
k8s生产级别部署：kubespray ，https://github.com/gjmzj/kubeasz
kubeadm的高可用部署
openstack比k8s技术门槛要高。
docker公司放弃docker-swarm
Kubernetes组件之间的交互方式：HTTP/HTTPS、gRPC、DNS、系统调用
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/
kube-apiserver、kube-scheduler、kube-controller-manger 这三个系统 Pod
云原生，就是Kubernetes原生，Rook(存储插件-Ceph，好东西，有前途-安装Ceph如此简单！！！)、Istio
Rook就可以把复杂的 Ceph 存储后端部署起来。
Bare-metal环境。裸机
Kubernetes 本身“一切皆容器”的设计思想，加上良好的可扩展机制，使得插件的部署非常简便
基于 Kubernetes工作思考：1. 我的工作是不是可以容器化？
                        2. 我的工作是不是可以借助 Kubernetes API 和可扩展机制来完成？
Ansible等工具适合部署大规模集群。
k8s最多支持节点数目：5000个
https://kubernetes.io/docs/setup/best-practices/cluster-large/
springboot日志要用pv
一键高可用部署
什么才是 Kubernetes 项目能“认识”的方式呢？面向yaml开发
一个YAML文件其实是一个API对象，Kind是API对象类型
Pod 就是 Kubernetes 世界里的“应用”；而一个应用，可以由多个容器组成
一种 API 对象（Deployment）管理另一种 API 对象（Pod）的方法， Kubernetes 中，叫作“控制器”模式（controller pattern）
API 对象的所有重要操作，全部在Event里面。
kubectl create -f nginx-deployment.yaml
升级nginx（kubectl replace -f nginx-deployment.yaml）
kubectl apply -f nginx-deployment.yaml-建议用apply，声明式 API”所推荐的使用方法，用户不必关心是创建还是更新，会根据yaml变化，自动执行相关操作。
kubectl apply 命令完成对这个对象的创建和更新操作。
docker run命令行转变apply 声明式API，每一个容器技术学习者，必须要跨过的第一道门槛
编写一个单独的Pod的YAML文件，我一定会推荐你使用一个replicas=1的Deployment，两者有什么区别?replicas=1 的 Deployment，这样便于以后的扩容与修改，减少不必要的操作
yaml模板：Jinja
大规模集群部署：2000节点，2k节点一般得用saltstack等专业武器了，毕竟管2k个机器已经可以排除大部分工具了
k8s中一般不直接使用Pod，都是挂在某种Controller下
为什么我们会需要 Pod？
Docker 容器的本质：Namespace做隔离，Cgroups做限制，rootfs做文件系统-三句箴言
容器，就是未来云计算系统中的进程；容器镜像就是这个系统里的“.exe”安装包。那么Kubernetes 呢？Kubernetes 就是操作系统！
k8s将进程组概念映射到容器技术里面，云“操作系统”一等公民。
Kubernetes 和 Borg 部署的应用，往往都存在着类似于“进程和进程组”的关系
Istio 项目使用 sidecar 容器完成微服务治理的原理
虚拟机里的应用无缝迁移到容器？容器与虚拟机几乎没有任何相似的地方，具体的实现原理，还是从使用方法、特性、功能等方面
那么物理机迁移虚拟机呢？
一个运行在虚拟机里的应用，哪怕再简单，也是被管理在 systemd 或者 supervisord 之下的一组进程，而不是一个进程。
对于容器来说，一个容器永远只能管理一个进程。更确切地说，一个容器，就是一个进程。这是容器技术的“天性”，
不可能被修改。所以，将一个原本运行在虚拟机里的应用，“无缝迁移”到容器中的想法，实际上跟容器的本质是相悖的。

pod 这个概念，提供的是一种编排思想，而不是具体的技术方案，愿意的话虚拟机来作为Pod的实现(virtlet)
pod和虚拟机类比关系？设计上对比，实际没什么关系。
Infra 容器-Pause容器
一个容器就是一个进程
rsyslogd 由三个进程组成：一个 imklog 模块，一个imuxsock 模块，一个 rsyslogd 自己的 main 函数主进程。这三个进程一定要运行在同一台机器上，否则，它们之间基于 Socket 的通信和文件交换，都会出现问题
容器的“单进程模型”，并不是指容器里只能运行“一个”进程，而是指容器没有管理多个进程的能力。
因为容器里 PID=1 的进程就是应用本身，其他的进程都是这个
PID=1 进程的子进程。可是，用户编写的应用，并不能够像正常操作系统里的 init 进程或者
systemd 那样拥有进程管理的功能。

典型的成组调度-》Mesos 资源囤积resource hoarding，Google Omega 论文中，
则提出了使用乐观调度处理冲突的方法，即：先不管这些冲突，而是通过精心设计的回滚机制在出现了冲突之后解决问题。
https://en.wikipedia.org/wiki/Gang_scheduling

容器间的紧密协作，“超亲密关系”：互相之间会发生直接的文件交换、使用 localhost 或者 Socket 文件进行本地通
                 信、会发生非常频繁的远程调用、需要共享某些 Linux Namespace
 
Pod 最重要的一个事实是：它只是一个逻辑概念
Kubernetes 真正处理的，还是宿主机操作系统上 Linux 容器的 Namespace 和Cgroups，而并不存在一个所谓的 Pod 的边界或者隔离环境
Pod，其实是一组共享了某些资源的容器，Pod 里的所有容器，共享的是同一个 Network Namespace，并且可以声明共享同一个Volume
容器关系：对等和拓扑
Pod 的生命周期只跟 Infra 容器一致，而与容器 A 和 B 无关
Pod是容器设计思想
Pod 这种“超亲密关系”容器的设计思想，实际上就是希望，当用户想在一个容器里跑多个功能并不相关的应用时，应该优先考虑它们是不是更应该被描述成一个 Pod 里的多个容器。
initContainers：Init Container 定义的容器，都会比 spec.containers 定义的用户容器先启动
WAR包与Tomcat容器之间耦合关系
sidecar 指的就是我们可以在一个 Pod 中，启动一个辅助容器，来完成一些独立于主进程（主容器）之外的工作
Application oriented abstraction：Containers
Pod，实际上是在扮演传统基础设施里“虚拟机”的角色；而容器，则是这个虚拟机里运行的用户程序
容器只是pod的一个普通属性。
Pod 扮演的是传统部署环境里“虚拟机”的角色。这样的设计，是为了使用户从传统环境（虚拟机环境）向Kubernetes（容器环境）的迁移，更加平滑
Pod-传统机器 容器-用户程序
调度、网络、存储，以及安全相关的属性，基本上是 Pod 级别的，凡是跟容器的 Linux Namespace 相关的属性，也一定是 Pod 级别的。
Pod：HostAliases(/etc/hosts)
ImagePullPolicy:镜像拉取策略。
Containers生命周期，Pod生命周期- Container Lifecycle Hook
对象保存在etcd里面。
Projected Volume：Secret，ConfigMap，DownwardApi，ServiceAccountToken
Secret：数据库敏感信息，
ConfigMap：应用配置
本质：环境变量
Pod 的恢复过程，永远都是发生在当前节点上，而不会跑到别的节点上去。事
实上，一旦一个 Pod 与一个节点（Node）绑定，除非这个绑定发生了变化（pod.spec.node 字段
被修改），否则它永远都不会离开这个节点。
 Pod 出现在其他的可用节点上，就必须使用 Deployment 
 restartPolicy：
 Always：在任何情况下，只要容器不在运行状态，就自动重启容器；
 OnFailure: 只在容器 异常时才自动重启容器；(一个 Pod，它只计算 1+1=2，计算完成输出结果后退出，变成 Succeeded 状态,restartPolicy=Always 强制重启这个 Pod 的容器，就没有任何意义)
 Never: 从来不重启容器。(如果你要关心这个容器退出后的上下文环境，比如容器退出后的日志、文件和目录，就需要将restartPolicy 设置为 Never)
Kubernetes 能不能自动给 Pod 填充某些字段呢？PodPreset
简单Pod 在生产环境里根本不能用啊！
k8s:一切皆对象,一切皆容器。比如应用是 Pod 对象，应用的配置是 ConfigMap 对象，应用要访问的密码则是 Secret 对象。
PodPreset 这样专门用来对 Pod 进行批量化、自动化修改的工具对象。
K8s围绕自己的对象进行编排。
Pod 这个看似复杂的 API 对象，实际上就是对容器的进一步抽象和封装而已。
容器这样沙盒描述应用来说，过于简单。
https://github.com/kubernetes/kubernetes/tree/master/pkg/controller
通用编排模式:控制循环，

`for {
        实际状态 := 获取集群中对象 X 的实际状态（Actual State）
        期望状态 := 获取集群中对象 X 的期望状态（Desired State）
        if 实际状态 == 期望状态{
        什么都不做
        } else {
        执行编排动作，将实际状态调整为期望状态
        }
}`


实际状态来自于Kubernetes集群本身，期望状态，来自用户提交的 YAML 文件

控制器模型实现：
1. Deployment 控制器从 Etcd 中获取到所有携带了“app: nginx”标签的 Pod，然后统计它们
的数量，这就是实际状态；
2. Deployment 对象的 Replicas 字段的值就是期望状态；
3. Deployment 控制器将两个状态做比较，然后根据比较结果，确定是创建 Pod，还是删除已有
的 Pod（具体如何操作 Pod 对象，我会在下一篇文章详细介绍）

主要逻辑在第三步，也叫调谐（Reconcile）。调谐的过程，则被称作“Reconcile Loop”（调谐循环）或者“Sync Loop”（同步循环）。
调谐的最终结果，往往都是对被控制对象的某种写操作。增加 Pod，删除已有的 Pod，或者更新 Pod 的某个字段。这也是 Kubernetes 项目“面向API 对象编程”的一个直观体现

Deployment：用一种对象管理另一种对象”的“艺术”

事件驱动是被动的：被控制对象要自己去判断是否需要被编排，调度。实时将事件通知给控制器。
控制器模式是主动的：被控制对象只需要实时同步自己的状态(实际由kubelet做的)，具体的判断逻辑由控制去做。

Kubernetes 使用的这个“控制器模式”，跟我们平常所说的“事件驱动”，有什么区别和联系吗？

统一的编排框架下，不同的控制器可以在具体执行过程中，设计不同的业务逻辑，从而达到不同的编排效果。

Deployment：Pod的“水平扩展 / 收缩”（horizontal scaling out/in）

PaaS 时代开始，一个平台级项目就必须具备的编排能力。

对于一个 Deployment 所管理的 Pod，它的 ownerReference 是谁？ReplicaSet

编排动作：水平扩缩，滚动更新

pod-template-hash：随机字符串：保证这些 Pod 不会与集群里的其他 Pod 混淆。

kubectl edit 并不神秘，它不过是把 API 对象的内容下载到了本地文件，让你修改完成后再提交上去。

一个Deploment，对应多个RelicaSet，多个“应用版本”的描述。

Deployment对应用进行版本控制的具体原理？(回滚)

Deployment 进行的每一次更新操作，都会生成一个新的 ReplicaSet 对象，是不是有些多余，甚至浪费资源呢？

Deployment 实际上是一个两层控制器。首先，它通过ReplicaSet 的个数来描述应用的版本；然后，它再通过ReplicaSet 的属性（比如replicas的值），来保证 Pod 的副本数量。

kubectl rollout 命令控制应用的版本

Deployment 的 Pod 模板，“滚动更新”就会被自动触发

保留历史版本数：spec.revisionHistoryLimit

会话黏连（session sticky），这就意味着“滚动更新”的时候，哪个 Pod 能下线，是不能随便选择的。Deployment就不行了，“自定义控制器”，就可以帮我们实现一个功能更加强大的 Deployment Controller

有了Deployment的能力之后，你可以非常轻松地用它来实现金丝雀发布、蓝绿发布，以及 A/B 测试等很多应用发布模式。

https://github.com/ContainerSolutions/k8s-deployment-strategies

**Pass平台**
设计理念，设计思路。
经典的Paas设计思路。

持续集成、持续交付、持续部署

docker：标准化的交付机制。

DevOps - Development And Operations

How Kubernetes Changes Operations? BRENDAN BURNS

