FROM jenkins:2.32.2

# Install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# Disable slave to master
RUN mkdir -p /usr/share/jenkins/ref/secrets/
RUN echo "false" > /usr/share/jenkins/ref/secrets/slave-to-master-security-kill-switch

# Username and password
ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# Skip initial wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Concurrent Jobs and user creation
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY user.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home
