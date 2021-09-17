#!/bin/bash
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

# NOTE: Without the wait the script exists before giving the server time to properly stop
function clean_up {
	kill -SIGINT $(pidof "valheim_server.x86_64")
	wait
	kill -SIGINT $serverPID
}

# Setup trap
trap "clean_up" SIGINT SIGTERM

cd ${STEAMAPPDIR}
# Add in Password length check
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.

./valheim_server.x86_64 -name "${SERVER_NAME}" -port ${PORT} -world "${WORLD}" -password "${SERVER_PASSWORD}" & serverPID=$!

wait $serverPID

export LD_LIBRARY_PATH=$templdpath

exit 0
