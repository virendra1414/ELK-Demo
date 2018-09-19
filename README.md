# ELK-demo by RRD
To enable Alerting by x-pack follow this doc: https://www.elastic.co/guide/en/x-pack/current/actions-email.html#gmail
Integrate JIRA with ELK to create a ticket:  https://www.elastic.co/guide/en/x-pack/current/actions-jira.html



**** For fresher to elasticsearch world start from here****

##Install Elasticsearch on Linux and Windows for 6.4.0 version
#### Requirements
##### Linux machine requirement:

- Minimum 1 server with 4GB of RAM (8GB will work better)
- If you have 2 server install elastic and kibana on first server and filebeat and logstash on second server


##### Windows Machine requirement:
- 1 machine with minimum 4GB RAM (8GB will work better)


## Elasticsearch Node Installation
Run following commands to install Elasticsearch 6.4.0 on Linux machine
```
yum update
yum install java
Java -version (Must be more than 1.8)
If java version not there then to download latest run below command: (or run: yum install java -y)
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm
Yum install jdk-8u131-linux-x64.rpm -y
Java -version (Check java version again)
Yum install wget (Do not run if wget is already available)
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.4.0.rpm
yum install elasticsearch-6.4.0.rpm -y
Make changes in /etc/elasticsearch/elasticsearch.yml (refer elasticsearch-17 folder)
systemctl start elasticsearch OR service elasticsearch start
systemctl status elasticsearch OR service elasticsearch status
Elasticsearch node is Up and Running now…!!!
http://<IP-of-Node>:9200/ 
For backend: curl -XGET "http://10.0.8.17:9200/_cat/health?v"
If firewall is creating issue just stop it:  systemctl stop firewalld
For any error check logs in:  /var/log/elasticsearch/
```
Run following steps to install Elasticsearch 6.4.0 on Windows machine
```
To download latest java version: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
Goto Control Panel>>Search for System>>Advanced system settings>>Edit the system environment variable>>Environment Variable>>set JAVA_HOME (C:\Program Files\Java\jre1.8.0_151)>>Save
Download .zip folder.
Unzip it and move folder to C drive.
Edit .yml file (Cluster Name & Node Name only)
Start elasticsearch in command line by using >> .\bin\elasticsearch.bat
Done….Node is up and running @http://<IP-of-node>:9200
```

For UI of elasticsearch we can use Elasticsearch chrome extension to find all our primaries and replicas.
Use below link to add extension.
[https://chrome.google.com/webstore/detail/elasticsearch-head/ffmkiejjmecolpfloofpjologoblkegm](https://www.google.com)
Cerebro plugin for Elasticsearch UI is more powerful compared to chrome extension.
For installation of cerebro check github link:
[https://github.com/lmenezes/cerebro/blob/master/README.md](https://www.google.com)
OR follow below instructions.
```
It runs on java 1.8 or newer.
Download from https://github.com/lmenezes/cerebro/releases
Extract files
Run bin/cerebro(or bin/cerebro.bat if on Windows)
Access on http://<IP-of-Node>:9000
```
Benefits of Cerebro:
```
We can changes number of replicas and relocate it from UI directly.
Index creation from UI. Go to more tab at top and select create index.
REST APIs can be used like getpostman.com.
All cluster settings can be done from more tab at the top. We can change values directly here.
Can be used as Analyzers. We can write this kind of sentence => "humpty dumpty fell off the CAR." And check output.
All CAT APIs can be used directly from more tab.
```

## Kibana Installation
Run following commands to install Kibana 6.4.0 on Linux machine
```
wget https://artifacts.elastic.co/downloads/kibana/kibana-6.4.0-x86_64.rpm
yum install kibana-6.4.0-x86_64.rpm -y
Vim /etc/kibana/kibana.yml (change elasticsearch.url, server.host, server.name )
systemctl start kibana OR service kibana start
For error log visit : cd /var/log/kibana.
Kibana is UP and Running now…!!!
http://10.0.8.17:5601
If Kibana red error is there go for deletion of prior .kibana index:
curl -XDELETE-http://hostIP:9200/.kibana 
service kibana restart
```
Run following commands to install Kibana 6.4.0 on Windows machine
```
Download kibana zip file
Edit kibana.yml file. (Add elasticsearch url)
Start Kibana in command line by using >> .\bin\kibana.bat
```
## Logstash Installation
Run following commands to install Logstash 6.4.0 on Linux machine
```
wget https://artifacts.elastic.co/downloads/logstash/logstash-6.4.0.rpm 
yum install logstash-6.4.0.rpm -y
```
If firewall issue is there use below command: systemctl stop firewalld
Add a Basic first-pipeline.cong in conf.d folder.
Basic filter example
        
    input {
        beats {
            port => 5044
        }
    }
    output {
        elasticsearch {
        hosts => ["<elastic-node-IP>:9200"]
        index => "testindex"
        }
    stdout {
        codec => rubydebug
        }
    }
```
Test the filter = /usr/share/logstash/bin/logstash -f first-pipeline.conf -t
```
If it gives OK output in logs like below then use start pipeline.
```
[root@**** conf.d]# /usr/share/logstash/bin/logstash -f first-pipeline.conf -t
Sending Logstash's logs to /var/log/logstash which is now configured via log4j2.properties
Configuration OK
```
```
Start pipeline = /usr/share/logstash/bin/logstash -f first-pipeline.conf OR systemctl start logstash
To check logstash logs use command: tail -f /var/log/logstash/logstash-plain.log 
```
If already another logstash process is  running as a service, It won't allow to start a new pipeline. (check it by using command: ps -ef | grep "logstash" and kill it)
```
To check error logs go to: tail -f /var/log/logstash/logstash-plain.log
Delete registery file from C:\ProgramData\filebeat (In windows) and "rm -rf /usr/share/filebeat/bin/data/registry" in Filebeat to send the same data file again.
```
If still logstash doesn't work then check this path (/var/lib/logstash) and every file in this path should belong to logstash user.
```
If it is not than change it by using command "chown logstash:logstash -R logstash"
Restart logstash: systemctl restart logstash
```
If still logstash doesn't work then you are on your own........!!!!!!!!! (Try Splunk for change)

Run following commands to install Logstash 6.4.0 on Windows machine

Download latest version 6.4.0
Unzip it and keep it on Desktop.
Add first-pipeline.conf
Open PowerShell as admin.
```
C:\Users\default.LAPTOP-VDTUFGAT\Desktop\logstash-6.1.2> .\bin\logstash -f .\config\first-pipeline.conf -t  (test filter)
C:\Users\default.LAPTOP-VDTUFGAT\Desktop\logstash-6.1.2> .\bin\logstash -f .\config\first-pipeline.conf  (Run filter by removing -t)
```
Once you see "Pipeline Running" message in logs then start filter (Ignore all other logs)
 Now pipeline has been started and we can start filebeat.

## Filebeat Installation
Run following commands to install FIlebeat 6.4.0 on Linux machine
```
For Linux:  curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.4.0-x86_64.rpm 
yum install filebeat-6.4.0-x86_64.rpm -y
```
Edit filebeat.yml (/etc/filebeat/filebeat.yml OR check folder filebeat-69)
And use: /usr/share/filebeat/bin/filebeat -e -c filebeat.yml -d "publish" (To start filebeat)
Delete registry file from this path if you are running same file in filebeat:  "rm -rf /usr/share/filebeat/bin/data/registry"
To check filebeat logs use: "tail -f /var/log/filebeat/filebeat"

Run following commands to install FIlebeat 6.4.0 on Windows machine

Download the Filebeat Windows zip https://elastic.co
Extract the contents of the zip file into C:\Program Files.
Rename the filebeat-<version>-windows directory to filebeat.
Open a PowerShell prompt as an Administrator (right-click the PowerShell icon and select Run As Administrator). If you are running Windows XP, you may need to download and install PowerShell.
From the PowerShell prompt, run the following commands to install Filebeat as a Windows service:
```
PS > cd 'C:\Program Files\Filebeat'
PS C:\Program Files\Filebeat> .\install-service-filebeat.ps1
```
If script execution is disabled on your system, you need to set the execution policy for the current session to allow the script to run by below command.
```
PowerShell.exe -ExecutionPolicy UnRestricted.
.\install-service-filebeat.ps1.
```
Use filebeat as a service on windows.
If filebeat is not working try using command: .\filebeat.exe -e in PowerShell to find exact error. IMP

Done...!!!!



