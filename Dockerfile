FROM jenkins:2.32.3
LABEL maintainer "waltervargas@linux.com"

USER root
ENV PACKAGES jq
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && apt-get -y install $PACKAGES && rm -rf /var/lib/apt/lists/*

USER jenkins
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
COPY init.groovy.d/* /usr/share/jenkins/ref/init.groovy.d/
COPY files/* /tmp/
COPY files/gitconfig /var/jenkins_home/.gitconfig

# Install Plugins
RUN /usr/local/bin/install-plugins.sh git pipeline-stage-view job-dsl workflow-aggregator blueocean maven-plugin
WORKDIR /var/jenkins_home

ENV GIT_URL https://github.com/waltervargas/jenkins.git
