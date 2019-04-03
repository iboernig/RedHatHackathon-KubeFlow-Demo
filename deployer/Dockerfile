# FROM registry.redhat.io/openshift3/ose-cli
FROM centos

# Install opeshift cli and ksonnat
RUN yum install -y git make centos-release-openshift-origin311.noarch && \
    yum install -y origin-clients.x86_64 &&\
    curl -L -O https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz &&\
    tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz &&\
    export PATH=$PATH:/usr/local/go/bin &&\
    go get github.com/ksonnet/ksonnet &&\
    cd /root/go/src/github.com/ksonnet/ksonnet &&\
    make install 

# https://www.lightbend.com/blog/how-to-deploy-kubeflow-on-lightbend-platform-openshift-installing-kubeflow?_ga=2.2545200.1054314146.1554291372-2140898909.1554291372

ENV KUBEFLOW_SRC=kubeflow
ENV KUBEFLOW_TAG=v0.4.1
ENV KFAPP=openshift

RUN mkdir -p /deployer/${KUBEFLOW_SRC} &&\
    cd /deployer &&\
    curl https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash

ADD kubeflow-deploy.sh /deployer/
ADD additional-kubeflow.yml /deployer/




