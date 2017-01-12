FROM jenkinsci/jenkins:2.40

USER root
RUN apt-get update \
      && apt-get install -y build-essential php5-cli php5-curl sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/

RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/ref/plugins.txt | tr '\n' ' ')

RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
