#!/usr/bin/env bash

usage(){
    echo ""
    echo "usage:"
    echo ""
    echo $0" namespace moudleName"
    echo "查看namespace在rd4上exchange-web-api的日志:sh pod-log.sh rd4 exchange-web-api"
    echo "如果不知道有哪些namespace，请查看kubectl get ns"
    echo "如果不知道namespace有哪些pod，请查看kubectl get pods -n xxxx"
}

if [ "$1" != "" ] && [ "$2" != "" ] ; then
    kubectl -n $1 exec -it `kubectl get pods -n $1 | grep $2 | awk '{print $1}' | awk 'NR==1'` /bin/bash
else
    usage
fi

