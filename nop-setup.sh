# Install liquibase
wget -O- https://repo.liquibase.com/liquibase.asc | gpg --dearmor > liquibase-keyring.gpg && \
cat liquibase-keyring.gpg | sudo tee /usr/share/keyrings/liquibase-keyring.gpg > /dev/null && \
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/liquibase-keyring.gpg] https://repo.liquibase.com stable main' | sudo tee /etc/apt/sources.list.d/liquibase.list
sudo apt-get install liquibase
#
# # Liquibase is a java application and so requires the java runetime
sudo apt install default-jdk
sudo apt install default-jre
#
#  Install MySQL Connector/J (https://dev.mysql.com/doc/connectors/en/connector-j-binary-installation.html)
#  Driver for allowing communication with sql server in java
curl -LO https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j_9.2.0-1ubuntu22.04_all.deb
sudo dpkg -i mysql-connector-j_9.2.0-1ubuntu22.04_all.deb
rm mysql-connector-j_9.2.0-1ubuntu22.04_all.deb*
# This is installed to /usr/share/java by default so this is the base for our class path

echo "driver: com.mysql.cj.jdbc.Driver
url: jdbc:mysql://localhost:3307/CVSBNOP?createDatabaseIfNotExist=true
username: root
password: password
classpath: /usr/share/java/mysql-connector-java-9.2.0.jar"> liquibase.properties

# Start my sql docker container. Map container port 3306 to 3307 on host machine so that mysql servive
# can run at the same time.
docker run --network host --name local-mysql -e MYSQL_ROOT_PASSWORD=password -p3307:3306 -d mysql:8

# Run liquibase with liquibase properties and change log file
liquibase --defaultsFile liquibase.properties --changeLogFile changelog-master.xml update
