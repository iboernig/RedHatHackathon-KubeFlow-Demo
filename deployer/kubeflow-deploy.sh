#!/bin/bash

echo # Create ~/.kube/config
NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)

oc login kubernetes.default.svc.cluster.local --insecure-skip-tls-verify --token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token )
oc project $NAMESPACE

echo "Start Deployment Script"
cd /deployer/

./scripts/kfctl.sh init $KFAPP --platform none
cd $KFAPP
/deployer/scripts/kfctl.sh generate k8s
#Set SCC Policies to anyuid
oc adm policy add-scc-to-user anyuid -z ambassador -n $NAMESPACE
oc adm policy add-scc-to-user anyuid -z jupyter -n $NAMESPACE
oc adm policy add-scc-to-user anyuid -z katib-ui -n $NAMESPACE
oc adm policy add-scc-to-user anyuid -z default -n $NAMESPACE

# Go to KS App Dir
cd /deployer/$KFAPP/ks_app
# Set to latest Images
ks param set tf-job-operator tfJobImage gcr.io/kubeflow-images-public/tf_operator:latest
# got to openshift dir
cd /deployer/$KFAPP
# Apply KFCTL
/deployer/scripts/kfctl.sh apply k8s


oc apply -f /deployer/additional-kubeflow.yml -n $NAMESPACE
oc expose service/ambassador -n $NAMESPACE
