#!/bin/bash
# -*- mode: sh -*-
#
# Copyright DataStax, Inc, 2017
#   Please review the included LICENSE file for more information.
#

set -e

. /base-checks.sh

link_external_config "${STUDIO_HOME}"

CONNECTION_NAME=${STUDIO_DEFAULT_CONNECTION_NAME:-"localhost"} 
CONNECTION_HOST=${STUDIO_DEFAULT_CONNECTION_HOST:-"127.0.0.1"} 
HTTP_BIND_ADDRESS=${STUDIO_HTTP_BIND_ADDRESS:-"localhost"} 

# setup the connection information
sed -i -e "s/default localhost/$CONNECTION_NAME/g" /opt/datastax-studio/examples/connections/418ed742-cd61-4df8-abd8-07bc56a62e8d
sed -i -e "s/127.0.0.1/$CONNECTION_HOST/g" /opt/datastax-studio/examples/connections/418ed742-cd61-4df8-abd8-07bc56a62e8d    

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