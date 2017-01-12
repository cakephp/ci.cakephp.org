FROM jenkinsci/jenkins:2.40

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG SYSTEM_PACKAGES
ENV SYSTEM_PACKAGES ${SYSTEM_PACKAGES:-build-essential sudo}

# install extra packages
USER root
COPY packages.txt /usr/share/jenkins/ref/
RUN apt-get update \
      && apt-get install -y $(cat /usr/share/jenkins/ref/packages.txt) \
      && apt-get install -y $SYSTEM_PACKAGES \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# install extra plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/ref/plugins.txt | tr '\n' ' ')

RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
