FROM ubuntu:bionic
#
# MODIFIED FROM ORIGINAL BY Alexander Radyushin <alexander@fjedi.com>
MAINTAINER Eddie Dunn <tmwsiy2012@gmail.com.

ENV RUNTIME_DEPS="curl wget mc nano iputils-ping net-tools"

# Install required packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y $RUNTIME_DEPS


RUN mkdir -p /srv/theta_mainnet/guardian_mainnet \
  && curl -k --output /usr/local/bin/theta `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=theta'` \
  && curl -k --output /usr/local/bin/thetacli `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=thetacli'` \
  && chmod +x /usr/local/bin/theta && chmod +x /usr/local/bin/thetacli

# 16888 - RPC API, 30001 - p2p
EXPOSE 16888 30001
#
VOLUME /srv/theta_mainnet/guardian_mainnet
#
CMD ["sh", "-c", "/usr/local/bin/theta start --config=/srv/theta_mainnet/guardian_mainnet/node --password=$NODE_PASSWORD"]
