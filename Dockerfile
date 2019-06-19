# based on jaysonsantos/docker-minecraft-ftb-skyfactory3

FROM openjdk:8-stretch

MAINTAINER example@example.com

# manual upgrades only chaps
# when you upgrade, you are responsible for removing the duplicate mods from your ./mods folder on your volume.
ENV VERSION=1.7.0

RUN apt-get update && apt-get install -y wget unzip
RUN adduser --disabled-password --home=/data --uid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/ftb && cd /tmp/ftb && \
  wget -c https://ftb.forgecdn.net/FTB2/modpacks/FTBInteractions/1_7_0/FTBInteractionsServer.zip -O ftbinteractions.zip && \
	unzip ftbinteractions.zip && \
	chown -R minecraft /tmp/ftb && \
	bash /tmp/ftb/FTBInstall.sh

USER minecraft

EXPOSE 25565

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start

ENV MOTD Interactions ${VERSION} Wildcard
ENV LEVEL world
ENV JVM_OPTS -Xms7200m -Xmx7200m
ENV FLIGHT true
