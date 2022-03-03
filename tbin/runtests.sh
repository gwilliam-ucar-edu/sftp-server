#!/bin/sh
PROG=runtests.sh
DESC="Run unit and integration test suite with minimal dependencies"
USAGE1="$PROG [-h|--help]"
HELP_TEXT="
        Run all unit tests and integration tests for sftp-server.

        The script does *not* use docker-compose.

        The script can be run from CircleCI, which uses a \"remote docker\"
        service which precludes the use of conventional docker volumes and
        bind mounts; volume data is therefore shared using the
        \"--volumes-from\" option of \"docker run\" (see
        sftp-server/sbin/run-test-server for details).
"

case $1 in
    -h|--help)
        cat <<EOF
NAME
        $PROG - $DESC

SYNOPSIS
        $USAGE1

DESCRIPTION$HELP_TEXT
EOF
        exit 0 ;;
esac
SCRIPTDIR=`cd \`dirname $0\`; pwd`

cd ${SCRIPTDIR}/../sbin
./run-test-server --wait=30
./run-test-client --rm tbin/run-sftp-tests
