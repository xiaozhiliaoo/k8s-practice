#!/usr/bin/env bash

if [ "$1" != "" ] && [ "$2" != "" ] ; then
    kubectl -n $1 exec -it `kubectl get pods -n $1 | grep $2 | awk '{print $1}' | awk 'NR==1'` /bin/bash
else
    usage
fi

