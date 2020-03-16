docker search harbor.lili.com

docker search hub.docker.com


# 本地镜像重命名  域名/仓库名/镜像名
# docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
# docker tag dockerinaction/hello_world harbor.lili.com/harbor/hello_world:v0.0.1
docker tag dockerinaction/hello_world harbor.lili.com/harbor/hello_world
docker push harbor.lili.com/harbor/hello_world

docker pull harbor.lili.com/harbor/hello_world

docker info

#启动docker：
sudo systemctl start docker

# 关闭docker：
sudo systemctl stop docker

# docker开机自启：
sudo systemctl enable docker

# 查看docker日志：
journalctl -u docker.service or less /var/log/messages | grep Docker

# 查看服务运行状态：
systemctl status docker.service

# systemd启动docker.service逻辑：
cat /usr/lib/systemd/system/docker.service

# docker数据存储目录：
tree -L 1 /var/lib/docker

# 删除docker数据存储目录：
rm -rf /var/lib/docker/ or docker system prune -a or docker volume rm $(docker volume ls -q)  #删除所有卷

# 查看docker所占磁盘空间：
cd /var/lib/docker && du -sh * or docker system df

# docker磁盘挂载信息：
mount | grep overlay2

# docker配置信息：
ls  /etc/docker

# 理解容器内外进程id的关联信息：
#容器内：
docker exec etcd0 ps -ef
#容器外：
docker top etcd0 关联pid信息  pstree -pl | grep docker

# 删除所有容器：
docker rm -f  `docker ps -a -q`
# 运行某一个容器：
docker run  -it -d -p 6379:6379  --name mx-redis  mx/redis:1.0