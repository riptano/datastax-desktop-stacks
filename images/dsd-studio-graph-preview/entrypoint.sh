#!/bin/bash
# -*- mode: sh -*-
#
# Copyright DataStax, Inc, 2017
#   Please review the included LICENSE file for more information.
#

set -e

. /base-checks.sh

link_external_config "${STUDIO_HOME}" 

#sleep 30

echo "Configuring DataStax Studio Connection"
CONNECTION_NAME=${STUDIO_DEFAULT_CONNECTION_NAME:-"localhost"} 
CONNECTION_HOST=${STUDIO_DEFAULT_CONNECTION_HOST:-"127.0.0.1"} 
HTTP_BIND_ADDRESS=${STUDIO_HTTP_BIND_ADDRESS:-"localhost"} 

# setup the connection information
sed -i -e "s/localhost/$CONNECTION_NAME/g" /var/lib/datastax-studio/connections/admin/8c4086f9-f441-4514-8643-9d7bd8e48f92
sed -i -e "s/my-dse/$CONNECTION_HOST/g" /var/lib/datastax-studio/connections/admin/8c4086f9-f441-4514-8643-9d7bd8e48f92

# setup the bind information
sed -i -e "s/localhost/$HTTP_BIND_ADDRESS/g" /opt/datastax-studio/conf/configuration.yaml  

############################################
# Set up variables/configure the image
############################################

############################################
# Run the command
############################################
echo "Starting DataStax Studio"
exec "${STUDIO_HOME}/bin/server.sh"
