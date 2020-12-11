#!/bin/bash -e
if [ -z "$NETWORK" ]; then 
    net=10.0.0.1/16
else
    net=$NETWORK
fi

append_params=""

if [ -n "$JOBS" ]; then
    append_params="$append_params --jobs $JOBS"
fi

distccd --allow=$net --daemon --verbose --no-detach $append_params &
distccd-armv5 --port=3633 --allow=$net --daemon --verbose --no-detach $append_params &
distccd-armv6h --port=3634 --allow=$net --daemon --verbose --no-detach $append_params &
distccd-armv7h --port=3635 --allow=$net --daemon --verbose --no-detach $append_params &
distccd-armv8 --port=3636 --allow=$net --daemon --verbose --no-detach $append_params &
tail -f /dev/null
