#!/bin/ash

export SONARQUBE_JDBC_URL=$SQLAZURECONNSTR_SONARQUBE_JDBC_URL 
mkdir -p /home/sonarqube/data
chown -R sonarqube:sonarqube /home/sonarqube

mv -n /opt/sonarqube/conf /home/sonarqube
mv -n /opt/sonarqube/logs /home/sonarqube
mv -n /opt/sonarqube/extensions /home/sonarqube

chown -R sonarqube:sonarqube /home/sonarqube/data
chown -R sonarqube:sonarqube /home/sonarqube/conf
chown -R sonarqube:sonarqube /home/sonarqube/logs
chown -R sonarqube:sonarqube /home/sonarqube/extensions

rm -rf /opt/sonarqube/conf
rm -rf /opt/sonarqube/logs
rm -rf /opt/sonarqube/extensions
rm -rf /opt/sonarqube/temp

ln -s /home/sonarqube/conf /opt/sonarqube/conf
ln -s /home/sonarqube/logs /opt/sonarqube/logs
ln -s /home/sonarqube/extensions /opt/sonarqube/extensions

exec $SONARQUBE_HOME/bin/run.sh -Dsonar.path.data="/home/sonarqube/data"