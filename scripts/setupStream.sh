#!/bin/zsh
dir=`dirname $0`
java -jar ${dir}/spring-cloud-dataflow-shell-2.11.0.jar --spring.shell.commandFile=${dir}/streams.txt
