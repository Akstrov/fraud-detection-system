@echo off
echo Initializing HBase tables and Kafka topics...
echo.

echo Waiting for HBase to be ready...
timeout /t 20 /nobreak > nul

echo Creating HBase tables...
docker exec -it hbase-master hbase shell
REM In HBase shell, manually run:
REM create 'transactions', {NAME => 'details', VERSIONS => 1}, {NAME => 'fraud', VERSIONS => 1}
REM create 'user_profiles', {NAME => 'stats', VERSIONS => 1}, {NAME => 'patterns', VERSIONS => 1}
REM create 'fraud_alerts', {NAME => 'alert', VERSIONS => 1}
REM list
REM exit

echo.
echo Creating Kafka topic...
docker exec -it kafka kafka-topics --create --bootstrap-server localhost:9092 --topic credit-card-transactions --partitions 3 --replication-factor 1

docker exec -it kafka kafka-topics --list --bootstrap-server localhost:9092

echo.
echo Initialization complete!
pause
