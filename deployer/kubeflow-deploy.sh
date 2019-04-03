#!/bin/bash

echo "Start Deployment Script"

# exporting Kubeflow Source Direcotry
mkdir -p "/tmp/kubeflow"
export "KUBEFLOW_SRC=/tmp/kubeflow"
echo $KUBEFLOW_SRC
cd $KUBEFLOW_SRC
export "KUBEFLOW_TAG=v0.4.1"
curl "https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash"
# setting up Kubeflow
#mkdir -p "/tmp/kubeflow/openshift"
export "KFAPP=openshift"
echo $KFAPP
/tmp/kubeflow/scripts/kfctl.sh init $KFAPP --platform none
cd $KFAPP
/tmp/kubeflow/scripts/kfctl.sh generate k8s
#Set SCC Policies to anyuid
oc adm policy add-scc-to-user anyuid -z ambassador -nkubeflow
oc adm policy add-scc-to-user anyuid -z jupyter -nkubeflow
oc adm policy add-scc-to-user anyuid -z katib-ui -nkubeflow
oc adm policy add-scc-to-user anyuid -z default -nkubeflow
# Go to KS App Dir
cd $KUBEFLOW_SRC/$KFAPP/ks_app
# Set to latest Images
ks param set tf-job-operator tfJobImage gcr.io/kubeflow-images-public/tf_operator:latest
# got to openshift dir
cd $KUBEFLOW_SRC/$KFAPP
# Apply KFCTL
oc status
/tmp/kubeflow/scripts/kfctl.sh apply k8s