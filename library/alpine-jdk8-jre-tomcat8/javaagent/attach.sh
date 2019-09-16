#!/usr/bin/env bash

#JAVA_HOME="/opt/taobao/java"

script_dir=$(cd $(dirname $0); pwd)

if [ "${JAVA_HOME}" = "" ]; then
   echo "Please set JAVA_HOME before running this script"
   exit 1
fi

TOOLS_JAR="${JAVA_HOME}/lib/tools.jar"
if [ ! -f ${TOOLS_JAR} ] ; then
    echo "Could not find tools.jar in $JAVA_HOME"
    exit 1
fi

classpath="${TOOLS_JAR}:$script_dir/javaagent-bootstrap.jar"
cmd="${JAVA_HOME}/bin/java -cp $classpath com.alibaba.adam.javaagent.bootstrap.AgentAttacher $*"

echo -e "$cmd\n" && eval "$cmd"
