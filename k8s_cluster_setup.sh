#!/bin/bash
# https://kops.sigs.k8s.io/getting_started/aws/#using-s3-default-bucket-encryption

ID=$(uuidgen) && aws route53 create-hosted-zone --name gocrazy.dealshare.co.in --caller-reference $ID | jq .DelegationSet.NameServers


aws s3api create-bucket \
 --bucket kubernetes-dealshare-com-state-storage \
 --region ap-south-1 \
 --create-bucket-configuration LocationConstraint=ap-south-1

aws s3api put-bucket-versioning \
 --bucket kubernetes-dealshare-com-state-storage \
 --versioning-configuration Status=Enabled

aws s3api create-bucket \
    --bucket kubernetes-dealshare-com-oidc-store \
    --region ap-south-1 \
    --create-bucket-configuration LocationConstraint=ap-south-1 \
    --acl public-read

export NAME=gocrazy.dealshare.co.in
export KOPS_STATE_STORE=s3://kubernetes-dealshare-com-state-storage

kops create cluster \
    --zones=ap-south-1a \
    --discovery-store=s3://kubernetes-dealshare-com-oidc-store/${NAME}/discovery \
    ${NAME}

# Suggestions:
#  * validate cluster: kops validate cluster --wait 10m
#  * list nodes: kubectl get nodes --show-labels
#  * ssh to the master: ssh -i ~/.ssh/id_rsa ubuntu@api.gocrazy.dealshare.co.in
#  * the ubuntu user is specific to Ubuntu. If not using Ubuntu please use the appropriate user based on your OS.
#  * read about installing addons at: https://kops.sigs.k8s.io/addons.

kops export kubeconfig ${NAME} --admin

# https://kops.sigs.k8s.io/getting_started/kubectl/
# https://devops.stackexchange.com/questions/13632/kubectl-asking-for-username-k8s-cluster-created-via-kops
kops update cluster ${NAME} --yes --state ${KOPS_STATE_STORE} --admin

kops rolling-update cluster