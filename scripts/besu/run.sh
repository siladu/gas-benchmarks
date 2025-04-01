 # For profiling purposes
sysctl kernel.perf_event_paranoid=1
sysctl kernel.kptr_restrict=0

# Prepare nethermind image that we will use on the script
cd scripts/besu

rm -rf execution-data
mkdir execution-data
chown -R $USER_USER:$USER_USER execution-data

cp besu.json /tmp/besu.json
cp jwtsecret /tmp/jwtsecret

# Get current date and time
CURRENT_DATE=$(date '+%Y-%m-%dT%H-%M-%S')

# Export JAVA_TOOL_OPTIONS with the current date
# cpu profiling:
#export JAVA_TOOL_OPTIONS="-agentpath:/async-profiler/lib/libasyncProfiler.so=start,event=cpu,file=/profiles/profile-${CURRENT_DATE}.jfr"
# wall clock profiling:
export JAVA_TOOL_OPTIONS="-agentpath:/async-profiler/lib/libasyncProfiler.so=start,event=wall,threads,file=/profiles/profile-${CURRENT_DATE}.html"

docker compose up -d

sleep 15

docker compose logs
