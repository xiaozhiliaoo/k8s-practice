# install docker
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --enable docker-ce-nightly
sudo yum-config-manager --enable docker-ce-test
sudo yum-config-manager --disable docker-ce-nightly
sudo yum install docker-ce docker-ce-cli containerd.io
yum list docker-ce --showduplicates | sort -r
sudo yum install docker-ce- <VERSION_STRING >docker-ce-cli- <VERSION_STRING >containerd.io
sudo systemctl start docker

################################################################################################

# install minikube
setenforce 0  # 关闭selinux   vim /etc/selinux/config  SELINUX=disabled
systemctl disable firewalld && systemctl stop firewalld  # 关闭防火墙
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/
minikube start --vm-driver=none --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'
minikube status

################################################################################################

# install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

################################################################################################

# install helm
wget -O helm.tar.gz https://get.helm.sh/helm-v3.1.1-linux-amd64.tar.gz
tar -zxvf helm.tar.gz
chmod +x linux-amd64/helm
mv linux-amd64/helm /usr/local/bin/helm

################################################################################################

# install harbor
#wget -O harbor.tgz https://storage.googleapis.com/harbor-releases/release-1.10.1/harbor-offline-installer-v1.10.1.tgz
# https://github.com/goharbor/harbor/releases/download/v1.10.1/harbor-offline-installer-v1.10.1.tgz
# https://storage.googleapis.com/harbor-releases

# prerequisites install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# set https https://github.com/goharbor/harbor/blob/master/docs/1.10/install-config/configure-https.md
wget -O harbor.tgz https://storage.googleapis.com/harbor-releases/release-1.10.0/harbor-offline-installer-latest.tgz
tar -zxvf harbor.tgz

# Generate CA
openssl genrsa -out ca.key 4096

openssl req -x509 -new -nodes -sha512 -days 3650 \
-subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=harbor.lili.com" \
-key ca.key \
-out ca.crt

# Generate CA Key
openssl genrsa -out harbor.lili.com.key 4096

openssl req -sha512 -new \
-subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=harbor.lili.com" \
-key harbor.lili.com.key \
-out harbor.lili.com.csr

cat >v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=harbor.lili.com
DNS.2=harbor.lili
DNS.3=hostname
EOF

# FQDN Generate
openssl x509 -req -sha512 -days 3650 \
-extfile v3.ext \
-CA ca.crt -CAkey ca.key -CAcreateserial \
-in harbor.lili.com.csr \
-out harbor.lili.com.crt

mkdir -p /data/cert/
cp harbor.lili.com.crt /data/cert
cp harbor.lili.com.key /data/cert

openssl x509 -inform PEM -in harbor.lili.com.crt -out harbor.lili.com.cert

mkdir -p /etc/docker/certs.d/harbor.lili.com
mkdir -p /etc/docker/certs.d/harbor.lili.com

cp harbor.lili.com.cert /etc/docker/certs.d/harbor.lili.com/
cp harbor.lili.com.key /etc/docker/certs.d/harbor.lili.com/
cp ca.crt /etc/docker/certs.d/harbor.lili.com/
cp harbor.lili.com.crt /etc/pki/ca-trust/source/anchors/

# 淇敼harbor.yaml  /data/cert/harbor.lili.com.key   /data/cert/harbor.lili.com.crt

./prepare
# Generate docker-compose.yaml file

docker-compose down -v

docker-compose up -d

# 绔彛鍗犵敤闂  https://www.maoyuanrun.com/2017/01/12/docker-port-is-already-allocated/

docker login
# user:admin  pwd:Harbor12345

################################################################################################

# install jenkins
# yum list java* 閺屻儳婀卝ava閸欘垳鏁ら悧鍫熸拱
yum install java-1.8.0-openjdk.x86_64
#wget http://ftp-chi.osuosl.org/pub/jenkins/war-stable/2.204.4/jenkins.war
wget https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/2.204.4/jenkins.war
java -jar jenkins.war --httpPort=8099 >jenkins.log 2>&1 &
#pwd:01cf85c42cad43288d759c402929c966
# admin:lili pwd:772654204lili

# install nginx
# wget http://nginx.org/download/nginx-1.14.2.tar.gz
# tar -zxvf nginx-1.14.2.tar.gz

# install rancher https://github.com/rancher/rancher#installation
# https://github.com/rancher/rke/releases/tag/v1.0.4
# wget https://github.com/rancher/rke/releases/download/v1.0.4/rke_linux-amd64
mv rke_linux-amd64 rke
chmod +x rke
sudo mv rke /usr/local/bin/
# docker run -d --restart=unless-stopped -p 8666:8080 rancher/rancher:latest
# docker run -d --restart=always -p 8080:8080 rancher/server
docker run -d --restart=always -p 81:80 -p 82:443 --name rs2001 rancher/rancher:stable
# admin 772654204lili



# install Istio
sudo wget https://github.com/istio/istio/releases/download/1.5.0/istio-1.5.0-linux.tar.gz
tar -zxvf istio-1.5.0-linux.tar.gz
cd istio-1.5.0
chmod +x bin/istioctl
sudo mv bin/istioctl /usr/local/bin/