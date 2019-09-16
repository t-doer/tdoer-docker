# dragon/dragon-app-tomcat

Latest Tag: 1.0.2

- Tag: harbor.tdoer.cn/dragon/dragon-app-tomcat:1.0.2
- Base Image: tdoer/alpine-jdk8-jre-tomcat8:1.0.2

## Build

Example version: 1.0.0

```
docker build -t harbor.tdoer.cn/dragon/dragon-app-tomcat:1.0.0 .
```

## Build and Push

 Usage: 
 
 ```
 ./build.sh <TARGET_WAR> <VERSION>
 ```
 
 Example:
  
 ```
 ./build.sh ../../target-examples/dg-web.war 1.0.0
 ```

## Run    

Run Tomcat

Suppose configuration files are under `/tmp/conf`

```
docker run --name dragon-app-tomcat -p 8080:8080 -v /tmp/conf:/deployments/conf --privileged=true -e CATALINA_OPTS='-Duser.timezone=Asia/Shanghai -Dhttp.prop.connectionTimeout=2000 -Dhttp.prop.acceptCount=20 -Dajp.prop.connectionTimeout=2000 -Dfile.encoding=UTF-8 -Djdbc.dataSourceClass=com.edb.jdbc3.Jdbc3PoolingDataSource -Djdbc.url=jdbc:edb://rm-2ze752xb1872903yp.ppas.rds.aliyuncs.com:3433/bomspre -Djdbc.user=xuesong -Djdbc.password=bybon@999 -DnewJdbc.dataSourceClass=com.mysql.cj.jdbc.MysqlDataSource -DnewJdbc.url=jdbc:mysql://10.8.2.3:3306/bomsdb?useUnicode=true\&characterEncoding=utf8\&autoReconnect=true\&rewriteBatchedStatements=TRUE -DnewJdbc.user=bybon -DnewJdbc.password=bybontest' -d harbor.tdoer.cn/dragon/dragon-app-tomcat:1.0.0
```

Check Image after running

```
docker exec -it dragon-app-tomcat /bin/bash
```

If Tomcat is not run successfully, you can use the command to login image to check files:

```
docker run --name dragon-app-tomcat -p 8080:8080 -v /tmp/conf:/deployments/conf --privileged=true -it --rm harbor.tdoer.cn/dragon/dragon-app-tomcat:1.0.0 /bin/bash
```

In container, Tomcat will run with the command:

```
/usr/local/jre1.8.0_201/bin/java -Djava.util.logging.config.file=/opt/tomcat/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djdk.tls.ephemeralDHKe
ySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -Duser.timezone=Asia/Shanghai -Dhttp.prop.connectionTimeout=2000 -Dhttp.prop.ac
ceptCount=20 -Dajp.prop.connectionTimeout=2000 -Dfile.encoding=UTF-8 -Djdbc.dataSourceClass=com.edb.jdbc3.Jdbc3PoolingDataSource -Djdbc.url=jdbc:edb://rm-2ze752xb1872903yp.ppas.rds.aliyuncs.com:3433/bomspre -Djd
bc.user=xuesong -Djdbc.password=bybon@999 -DnewJdbc.dataSourceClass=com.mysql.cj.jdbc.MysqlDataSource -DnewJdbc.url=jdbc:mysql://10.8.2.3:3306/bomsdb?useUnicode=true&characterEncoding=utf8&autoReconnect=true&rew
riteBatchedStatements=TRUE -DnewJdbc.user=bybon -DnewJdbc.password=bybontest -javaagent:/opt/agent-bond/agent-bond.jar=jolokia{{host=0.0.0.0}},jmx_exporter{{9779:/opt/agent-bond/jmx_exporter_config.yml}} -XX:+Us
eParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -XX:MinHeapFreeRatio=20 -XX:MaxHeapFreeRatio=40 -XX:+ExitOnOutOfMemoryError -Dignore.endorsed.dirs= -classpath /deployments/conf/:/opt/tomcat/bin/boo
tstrap.jar:/opt/tomcat/bin/tomcat-juli.jar -Dcatalina.base=/opt/tomcat -Dcatalina.home=/opt/tomcat -Djava.io.tmpdir=/opt/tomcat/temp org.apache.catalina.startup.Bootstrap start
```
