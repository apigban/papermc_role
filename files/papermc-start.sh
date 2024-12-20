#!/usr/bin/env sh

#!/usr/bin/env bash

# Set JAVA_HOME if not already set
if [ -z "$JAVA_HOME" ]; then
  JAVA_HOME=$(update-alternatives --query java | grep "Value:" | awk '{print $2}')
  export JAVA_HOME
fi

# Use JAVA_HOME if set, otherwise fall back to the 'java' command
JAVA_EXECUTABLE="${JAVA_HOME}/bin/java"
if [[ ! -x "$JAVA_EXECUTABLE" ]]; then
  JAVA_EXECUTABLE="java"
fi


# Define JVM options
JVM_OPTIONS=(
  "-Xms2G"
  "-Xmx2G"
  "-XX:+AlwaysPreTouch"
  "-XX:+DisableExplicitGC"
  "-XX:+ParallelRefProcEnabled"
  "-XX:+PerfDisableSharedMem"
  "-XX:+UnlockExperimentalVMOptions"
  "-XX:+UseG1GC"
  "-XX:G1HeapRegionSize=8M"
  "-XX:G1HeapWastePercent=5"
  "-XX:G1MaxNewSizePercent=40"
  "-XX:G1MixedGCCountTarget=4"
  "-XX:G1MixedGCLiveThresholdPercent=90"
  "-XX:G1NewSizePercent=30"
  "-XX:G1RSetUpdatingPauseTimePercent=5"
  "-XX:G1ReservePercent=20"
  "-XX:InitiatingHeapOccupancyPercent=15"
  "-XX:MaxGCPauseMillis=200"
  "-XX:MaxTenuringThreshold=1"
  "-XX:SurvivorRatio=32"
  "-Dusing.aikars.flags=https://mcflags.emc.gs"
  "-Daikars.new.flags=true"
)

# Define server JAR file
SERVER_JAR="/usr/local/bin/papermc-server.jar"

# Check if the server JAR exists
if [[ ! -f "$SERVER_JAR" ]]; then
  echo "Error: Server JAR file '$SERVER_JAR' not found."
  exit 1
fi

# Start the server
"$JAVA_EXECUTABLE" "${JVM_OPTIONS[@]}" -jar "$SERVER_JAR"