#!/bin/bash
# -*- mode: sh -*-
#
# Copyright DataStax, Inc, 2017
#   Please review the included LICENSE file for more information.
#

set -e

. /base-checks.sh

link_external_config "${OPSCENTER_HOME}"

SEED_HOSTS=${OPSCENTER_SEED_HOSTS:-"dse-server"} 

mkdir -p /opt/opscenter/conf/clusters
cat > /opt/opscenter/conf/clusters/DataStax_Desktop_Cluster.conf <<- EOF
[kerberos]
default_service = 
opscenterd_client_principal = 
opscenterd_keytab_location = 
agent_keytab_location = 
agent_client_principal = 

[agents]
ssl_truststore_password = 
ssl_keystore_password = 
ssl_keystore = 
ssl_truststore = 

[jmx]
password = 
port = 7199
username = 

[cassandra]
ssl_truststore_password = 
cql_port = 9042
seed_hosts = $SEED_HOSTS
password = 
ssl_keystore_password = 
ssl_keystore = 
ssl_truststore = 
username = 
EOF

############################################
# Set up variables/configure the image
############################################

############################################
# Run the command
############################################
echo "Starting OpsCenter with $@"
exec "$OPSCENTER_HOME/bin/opscenter" "$@"