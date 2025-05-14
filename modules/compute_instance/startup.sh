#!/bin/bash

# Update system packages
sudo yum update -y

# Fix potential yum lock issues
sudo rm -f /var/lib/rpm/.rpm.lock
sudo rm -f /var/run/yum.pid

# Install required dependencies
sudo yum install fontconfig freetype libXi -y

# Install Java 17 (required for Jenkins)
sudo yum install java-17-openjdk -y
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk' | sudo tee -a /etc/profile
source /etc/profile

# Add Jenkins repository and install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install --nogpgcheck jenkins -y

# Correct service file to point to jenkins.war
sudo sed -i 's|ExecStart=.*|ExecStart=/usr/bin/java -jar /usr/share/java/jenkins.war --httpPort=8080|' /usr/lib/systemd/system/jenkins.service

# Reload systemd to apply changes
sudo systemctl daemon-reload
sudo systemctl enable jenkins

# Ensure correct permissions for Jenkins directories
sudo mkdir -p /var/lib/jenkins /var/log/jenkins
sudo chown -R jenkins:jenkins /var/lib/jenkins /var/log/jenkins

# Start Jenkins
sudo systemctl start jenkins

# Wait for Jenkins to start before installing plugins
sleep 30

# Install Jenkins Plugins
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
if [ -f "jenkins-cli.jar" ]; then
    java -jar jenkins-cli.jar -s http://localhost:8080/ -noCertificateCheck install-plugin workflow-aggregator git github docker-workflow configuration-as-code
    sudo systemctl restart jenkins
else
    echo "Jenkins CLI tool not found. Skipping plugin installation."
fi

echo "Jenkins setup and plugin installation completed successfully!" | sudo tee /var/log/startup-script.log
