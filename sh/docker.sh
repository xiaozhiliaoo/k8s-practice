docker search harbor.lili.com

docker search hub.docker.com


# 本地镜像重命名  域名/仓库名/镜像名
# docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
# docker tag dockerinaction/hello_world harbor.lili.com/harbor/hello_world:v0.0.1
docker tag dockerinaction/hello_world harbor.lili.com/harbor/hello_world
docker push harbor.lili.com/harbor/hello_world

docker pull harbor.lili.com/harbor/hello_world