#!/usr/bin/env sh

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \

curl -sLS https://get.k3sup.dev | sh && \
sudo install k3sup /usr/local/bin/

ssh-copy-id k3s@192.168.1.101 && \
ssh-copy-id k3s@192.168.1.201 && \
ssh-copy-id k3s@192.168.1.202 && \


k3sup install --ip 192.168.1.101 --user k3s --no-extras && \
k3sup join --ip 192.168.1.201 --server-ip 192.168.1.101 --user k3s && \
k3sup join --ip 192.168.1.202 --server-ip 192.168.1.101 --user k3s && \

kubectl get node -o wide

# sudo rm -f /usr/local/bin/kubectl /usr/local/bin/k3sup
# ssh k3s@192.168.1.101
# sudo flux uninstall

curl -s https://fluxcd.io/install.sh | sudo bash


flux bootstrap git --url=ssh://git@gitlab.com/joevizcara/on-premise-gitops-kubernetes --branch=master --private-key-file=/path/to/private_ssh_key
