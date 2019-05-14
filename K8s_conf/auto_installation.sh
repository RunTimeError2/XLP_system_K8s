#! /bin/bash

echo 'Installing etcd...'

echo 'Downloading binary file for etcd v3.3.2'
wget https://github.com/coreos/etcd/releases/download/v3.3.2/etcd-v3.3.2-linux-amd64.tar.gz
tar -zxvf etcd-v3.3.2-linux-amd64.tar.gz
echo 'Copying binary file to /usr/bin/'
cp etcd-v3.3.2-linux-amd64/etc* /usr/bin/
echo 'Creating working directory'
mkdir /var/lib/etcd/default.etcd
mkdir /var/lib/etcd
mkdir /etc/etcd
echo 'Copying configuration file'
cp configuration/etcd.conf /etc/etcd/
cp service/etcd.service /lib/systemd/system/
echo 'Starting services'
systemctl daemon-reload
systemctl start etcd.service
systemctl enable etcd.service

echo 'Installing Kubernetes'

echo 'Downloading binary file for Kubernetes v1.8.13'
wget https://dl.k8s.io/v1.8.13/kubernetes-server-linux-amd64.tar.gz
tar -zxvf kubernetes-server-linux-amd64.tar.gz
echo 'Copying binary file to /usr/bin/'
rm kubernetes/server/bin/*.tar
rm kubernetes/server/bin/*.docker_tag
cp kubernetes/server/bin/* /usr/bin/
echo 'Creating working directory'
mkdir /etc/kubernetes
mkdir /var/lib/kubelet
echo 'Copying configuration file'
cp configuration/apiserver /etc/kubernetes/
cp configuration/config /etc/kubernetes/
cp configuration/controller-manager /etc/kubernetes/
cp configuration/kubelet /etc/kubernetes/
cp configuration/proxy /etc/kubernetes/
cp configuration/scheduler /etc/kubernetes/
cp service/kube-apiserver.service /lib/systemd/system/
cp service/kube-controller-manager.service /lib/systemd/system/
cp service/kubelet.service /lib/systemd/system/
cp service/kube-proxy.service /lib/systemd/system/
cp service/kube-scheduler.service /lib/systemd/system/
echo 'Starting services'
systemctl daemon-reload
systemctl start kube-apiserver.service
systemctl start kube-controller-manager.service
systemctl start kube-scheduler.service
systemctl start kube-proxy.service
systemctl start kubelet.service
systemctl enable kube-apiserver.serivce
systemctl enable kube-controller-manager.service
systemctl enable kube-scheduler.service
systemctl enable kube-proxy.serivce
systemctl enable kubelet.service

echo 'Finished'
