#!/usr/bin/env bash

usage(){
    echo ""
    echo "usage:"
    echo ""
    echo $0" namespace moudleName"
    echo "查看namespace在rd4上exchange-web-api的事件:sh pod-log.sh rd4 exchange-web-api"
    echo "如果不知道有哪些namespace，请查看kubectl get ns"
}

if [ "$1" != "" ] && [ "$2" != "" ] ; then
    kubectl describe pod `kubectl get pods -n $1 | grep $2 | awk '{print $1}' | awk 'NR==1'` -n $1
else
    usage
fi

