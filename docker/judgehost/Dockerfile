FROM debian:stable
MAINTAINER DOMjudge team <team@domjudge.org>

ENV DEBIAN_FRONTEND=noninteractive \
	CONTAINER_TIMEZONE=Asia/Jakarta \
	DOMSERVER_BASEURL=https://senior.schematics-npc.com/ \
	JUDGEDAEMON_USERNAME=judgehost \
	JUDGEDAEMON_PASSWORD=password \
	DAEMON_ID=0 \
	DOMJUDGE_CREATE_WRITABLE_TEMP_DIR=0 \
	RUN_USER_UID_GID=62860

# Install required packages for running of judgehost
RUN apt-get update
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	dumb-init
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	acl zip unzip supervisor sudo procps libcgroup1 
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	php-cli php-zip php-gd php-curl php-mysql php-json \
	php-gmp php-xml php-mbstring 
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	python3 
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	gcc g++ 
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	default-jre-headless default-jdk 
	# ghc fp-compiler \
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	pypy3
RUN rm -rf /var/lib/apt/lists/*

# Add chroot and judgehost data
ADD chroot.tar.gz /
ADD judgehost.tar.gz /
RUN cp /opt/domjudge/judgehost/etc/sudoers-domjudge /etc/sudoers.d/

# Add scripts
COPY ["judgehost/scripts", "/scripts/"]

# Change start script permissions, add user and fix permissions
RUN chmod +x /scripts/start.sh \
	&& useradd -m domjudge \
	&& chown -R domjudge: /opt/domjudge

# Make the scripts available to the root user
ENV PATH="$PATH:/opt/domjudge/judgehost/bin"

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/scripts/start.sh"]
