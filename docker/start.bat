@echo off
echo Starting Fraud Detection System...
echo This may take 2-3 minutes on first run...

docker compose up -d

echo.
echo Waiting for services to be ready...
timeout /t 30 /nobreak > nul

echo.
echo Checking service status...
docker compose ps

echo.
echo Services are starting. Access points:
echo   - Kafka: localhost:9092
echo   - HDFS NameNode UI: http://localhost:9870
echo   - HBase Master UI: http://localhost:16010
echo   - Spark Master UI: http://localhost:8080
echo.
echo Run 'initialize.bat' next to create HBase tables and Kafka topics
pause
