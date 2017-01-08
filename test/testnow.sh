#!/bin/bash

set -x

function die
{
    local message=$1
    [ -z "$message" ] && message="Died"
    echo "${BASH_SOURCE[1]}: line ${BASH_LINENO[0]}: ${FUNCNAME[1]}: $message." >&2
    exit 1
}

# test if we're in the right directory.
pwd | grep now/test || die "running in the wrong directory."


rm nowfile
touch nowfile

export NOW_FILE=nowfile
export NOW_TIME_FORMAT=h,hm,hms
export NOW_ESTIMATES=1
export NOW_DEBUG=0

cat > $NOW_FILE <<EOF
2000-01-01 09:00:00 task1
2000-01-01 09:10:00 task2
2000-01-01 09:20:00 task1
2000-01-01 09:30:00 break
EOF

# cat nowfile
# now
now | egrep -q '0:10\/.*? task2' || die "Task 2 missing."
now -d 1
now -d 1 | egrep -q '0:20\/.*? task1' || die "Task 1 not agregated"


