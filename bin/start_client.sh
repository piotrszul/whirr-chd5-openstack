#!/bin/bash
set -e

echo "Initializing Hadoop Client Shell"

MASTER_IP=$(grep hadoop-namenode  $HOME/.whirr/hadoop-yarn/instances | awk '{print $4}')

echo "Master at: $MASTER_IP"
echo "NameNode GUI at: http://$MASTER_IP:50070"
echo "ResourceManager GUI at: http://$MASTER_IP:8088"

if [[ -f "$HOME/.whirr/hadoop-yarn/hadoop-site.xml" ]]; then
	mv ~/.whirr/hadoop-yarn/hadoop-site.xml ~/.whirr/hadoop-yarn/core-site.xml
fi

export HADOOP_CONF_DIR=~/.whirr/hadoop-yarn

~/.whirr/hadoop-yarn/hadoop-proxy.sh  >/dev/null  2>&1  &
 
PROXY_PID=$!
hadoop fs -mkdir -p /user/ubuntu

echo "Starting Hadoop Client shell. Use [Ctrl+D] or type 'exit' to exit"

bash --rcfile <(echo "PS1='hadoop#\u@\h:\w\>> '")

killall ssh
echo "Done with the Hadoop Client shell"
