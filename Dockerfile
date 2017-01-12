FROM jenkinsci/jenkins:2.40

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

# install extra packages
USER root
COPY packages.txt /usr/share/jenkins/ref/
RUN apt-get update \
      && apt-get install -y $(cat packages.txt) \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# install extra plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/ref/plugins.txt | tr '\n' ' ')

RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
