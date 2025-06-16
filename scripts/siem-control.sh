#!/bin/bash

# Start the whole SIEM stack

start_siem() {
local attempt=1
local max_attempt=3

echo "Starting SIEM stack - MongoDB, Opensearch, Greylog Server"
while [ $attempt -le $max_attempt ]; do
	echo "Attempt: $attempt/$max_attempt"

	#Start MongoDB
	echo "Starting MongoDB..."
	sudo systemctl start mongod
	sleep 10

	if systemctl is-active --quiet mongod; then
		echo "Started succesfully"

		#Start Opensearch
		echo "Starting Opensearch..."
		sudo systemctl start opensearch
		sleep 10

		if systemctl is-active --quiet opensearch; then
			echo "Started succesfully"

			#Start Graylog
			echo "Starting Graylog..."
			sudo systemctl start graylog-server
			if systemctl is-active --quiet graylog-server; then
				echo "Started succesfully"
				return 0
			else
				echo "Failed to start Graylog, Displaying logs.."
        sudo journalctl -xeu graylog-server.service
			fi
		else
			echo "Failed to start Opensearch, Displaying logs.."
			sudo journalctl -xeu opensearch.service
		fi
	else
		echo "Failed to start MongoDB, Displaying logs.."
		sudo journalctl -xeu mongod.service
	fi

	echo "Stopping all services before retry..."
	sudo systemctl stop graylog-server opensearch mongod
	sleep 5
	
	((attempt++)) 

done 
echo "ERROR: Failed to start SIEM stack after $attempt attempts"
    return 1
}

# Fuction to check if a service is active and running

check_service() {
local service=$1
local max_attempt=$2
local attempt=1

echo "Waiting for $service to be ready..."
while [ $attempt -le $max_attempt ]; do
	if systemctl is-active --quiet $service; then
 #Check if MongoDB server is not just active but ready to received requests 
		if [ "$service" = "mongod" ]; then
			if mongosh --eval "db.serverStatus()" &>/dev/null; then
				echo "$service is active and running "
				return 0
			else 
				echo" Attempt $attempt/$max_attempt:  MongoDb is active but not responding"
			fi

		# Check if Opensearch is ready
		elif [ "$service" = "opensearch" ]; then
			if curl -s "http://localhost:9200/_cluster/health" | grep -q  '"status":"green\|yellow"'; then
				echo "$service is ready"
				return 0
			else 
				echo "$service is not ready "
			fi 
		fi
	else 
		echo "Attempt $attempt/$max_attempt:  $service is not active"
	fi 

	sleep 300
	((attempt++))
done 
echo "ERROR: Reached attempt limit of $attempt/$max_attempt"
}
stop_siem() {
    echo "Stopping SIEM stack..."
    sudo systemctl stop graylog-server
    sudo systemctl stop opensearch
    sudo systemctl stop mongod
    echo "All services stopped"
}

case "$1" in
    "start")
        start_siem
        ;;
    "stop")
        stop_siem
        ;;
    "check")
        if [ -z "$2" ]; then
            echo "Usage: $0 check <service_name>"
            exit 1
        fi
        max_attempts=${3:-5}
        check_service "$2" "$max_attempts"
        ;;
    *)
        echo "Usage: $0 {start|stop|check <service>}"
        echo "Examples:"
        echo "  $0 start          # Start SIEM stack"
        echo "  $0 stop           # Stop SIEM stack"
        echo "  $0 check mongod   # Check if MongoDB is ready"
        exit 1
        ;;
esac



