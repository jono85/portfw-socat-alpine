#!/bin/sh

set -euo pipefail

echo "Starting Alpine/Socat port forwarder..."

#PROTO=${PROTOCOL,,} #lowercase in BASH
PROTO=$(echo $PROTOCOL | awk '{print tolower($0)}') #lowercase in alpine/busybox
if [[ $PROTO == 'tcp' ]] || [[ $PROTO == 'udp' ]]
then
    PROTOCOL=$PROTO
else
    echo "ERROR: Invalid protocol '$PROTOCOL', valid options are 'tcp' or 'udp'"
    exit 1
fi

if [ $LISTEN_PORT -lt 1 ] || [ $LISTEN_PORT -gt 65535 ]
then
    echo "ERROR: Invalid listening port '$LISTEN_PORT', valid range is 1 - 65535"
    exit 2
fi

if [[ $REMOTE_HOST == '' ]]
then
    echo "ERROR: missing REMOTE_HOST - empty value present"
    echo "Please set either an IP address or a hostname recognized by this system"
    exit 3
elif [[ $REMOTE_HOST == 'remote.host.not.set' ]]
then
    echo "ERROR: Invalid remote host '$REMOTE_HOST' - default value present"
    echo "Please set either an IP address or a hostname recognized by this system"
    exit 4
fi

if [ $REMOTE_PORT -lt 1 ] || [ $REMOTE_PORT -gt 65535 ]
then
    echo "ERROR: Invalid remote target port '$REMOTE_PORT', valid range is 1 - 65535"
    exit 5
fi

echo "Starting SOCAT portforwarding"
echo "    $PROTOCOL:$LISTEN_PORT --> $REMOTE_HOST:$REMOTE_PORT"
echo ""

socat $PROTOCOL-listen:$LISTEN_PORT,reuseaddr,fork ${PROTOCOL}:$REMOTE_HOST:$REMOTE_PORT

echo ""
echo "SOCAT closed, exiting..."
echo ""

# export PROTOCOL='tcp'
# export LISTEN_PORT=12389
# export REMOTE_HOST='192.168.222.99'
# export REMOTE_PORT=3389 
