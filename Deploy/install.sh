#!/bin/bash
apt-get -y update
apt-get -y install default-jre
apt-get -y install tomcat7
curl $1 > publishing.war
cp publishing.war /var/lib/tomcat7/webapps/