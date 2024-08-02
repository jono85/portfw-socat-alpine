# autossh-tunnel
Minimalist port-forwarder docker container based on Alpine, using SOCAT tool to do network traffic forwarding

## usage
The container should expose a listening port on a local host IP and uses environmental variables to configure listening port, remote host and remote port.

## example
You can run the container using the following example command:

```console
docker run \
    -e PROTOCOL='tcp' \
    -e LISTEN_PORT=63389 \
    -e REMOTE_HOST='10.1.2.3' \
    -e REMOTE_PORT=3389 \
    -p 63389:63389 \
    -dit jono85/portfw-socat-alpine:latest
```


## Environmental variables (MANDATORY)
| VARIABLE | Allowed values |
| ------------- | ------------- |
| PROTOCOL | either 'tcp' or 'udp' |
| LISTEN_PORT | Integer between 1 and 65535 - port the container will listen on. Should also be exposed on the docker host if it's to serve other machines |
| REMOTE_HOST | a valid IP address or domain name, i.e. '192.168.1.250' or 'some.server.com' |
| REMOTE_PORT | Integer between 1 and 65535 - port the traffic will be forwarded to on the Remote Host |
