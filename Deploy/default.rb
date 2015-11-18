#
# Cookbook Name:: purchasing
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# Cookbook Name:: mrpapp-2
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Runs apt-get update
include_recipe "apt"

# Add the Open JDK apt repo
apt_repository 'openJDK' do
    uri 'ppa:openjdk-r/ppa'
    distribution 'trusty'
end

# Install JDK and JRE
apt_package 'openjdk-8-jdk' do
    action :install
end

apt_package 'openjdk-8-jre' do
    action :install
end

# Set Java environment variables
ENV['JAVA_HOME'] = "/usr/lib/jvm/java-8-openjdk-amd64"
ENV['PATH'] = "#{ENV['PATH']}:/usr/lib/jvm/java-8-openjdk-amd64/bin"


# Install Tomcat 7
apt_package 'tomcat7' do
    action :install
end


# Set tomcat port 
script 'tomcat_port' do 
    interpreter "bash"
    code "sed -i 's/Connector port=\".*\" protocol=\"HTTP\\/1.1\"$/Connector port=\"#{node['tomcat']['mrp_port']}\" protocol=\"HTTP\\/1.1\"/g' /etc/tomcat7/server.xml"
    not_if "grep 'Connector port=\"#{node['tomcat']['mrp_port']}\" protocol=\"HTTP/1.1\"$' /etc/tomcat7/server.xml"
    notifies :restart, "service[tomcat7]", :immediately
end

# Install the MRP app, restart the Tomcat service if necessary
remote_file 'purchasing.war' do
    source node['purchasing']['blob']
    path node['tomcat']['webapp_dir'] + node['purchasing']['app_war']
    action :create
    notifies :restart, "service[tomcat7]", :immediately
end

# Ensure Tomcat is running
service 'tomcat7' do
    action :start
end

