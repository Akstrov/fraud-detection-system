#!/bin/bash

echo "Initializing HBase tables and Kafka topics..."
echo ""

# Wait for HBase to be ready
echo "Waiting for HBase to be ready..."
sleep 20

# Create HBase tables
echo "Creating HBase tables..."
docker exec -it hbase-master hbase shell <<EOF
create 'transactions', {NAME => 'details', VERSIONS => 1}, {NAME => 'fraud', VERSIONS => 1}
create 'user_profiles', {NAME => 'stats', VERSIONS => 1}, {NAME => 'patterns', VERSIONS => 1}
create 'fraud_alerts', {NAME => 'alert', VERSIONS => 1}
list
exit
EOF

echo ""
echo "Creating Kafka topic..."
docker exec -it kafka kafka-topics --create \
  --bootstrap-server localhost:9092 \
  --topic credit-card-transactions \
  --partitions 3 \
  --replication-factor 1

docker exec -it kafka kafka-topics --list --bootstrap-server localhost:9092

echo ""
echo "Initialization complete!"
echo "HBase tables created: transactions, user_profiles, fraud_alerts"
echo "Kafka topic created: credit-card-transactions"
