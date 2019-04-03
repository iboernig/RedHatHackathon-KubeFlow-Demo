#!/bin/bash

echo # Create ~/.kube/config
export K8S_NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)

oc login kubernetes.default.svc.cluster.local --insecure-skip-tls-verify --token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token )

while true ; do 
clear;
oc status
sleep 60;
done;