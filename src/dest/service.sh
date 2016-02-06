#!/usr/bin/env sh
#
# rsyncd file service

# import DroboApps framework functions
. /etc/service.subr

# framework-mandated variables
version="3.1.2"
name="rsync"
description="rsyncd file server"
depends=""
#webui=""

# app-specific variables
prog_dir="$(dirname "$(realpath "${0}")")"
daemon="${prog_dir}/bin/${name}"
tmp_dir="/tmp/DroboApps/${name}"
pidfile="${prog_dir}/var/run/pid.txt"
logfile="${prog_dir}/var/log/log.txt"
conffile="${prog_dir}/etc/rsyncd.conf"

start() {
  if [ ! -f "${conffile}" ]; then
    cp -v -f "${conffile}.default" "${conffile}"
  fi

  "${daemon}" --daemon \
    --dparam=pidfile="${pidfile}" \
    --config="${conffile}" \
    --log-file="${logfile}" >> logfile 2>&1
}

# common section
# script hardening
set -o errexit  # exit on uncaught error code
set -o nounset  # exit on unset variable
set -o pipefail # propagate last error code on pipe
# ensure log folder exists
if [ ! -d "${tmp_dir}" ]; then mkdir -p "${tmp_dir}"; fi
# redirect all output to logfile
exec 3>&1 4>&2 1>> "${logfile}" 2>&1
STDOUT=">&3"
STDERR=">&4"
# log current date, time, and invocation parameters
echo "$(date +"%Y-%m-%d %H-%M-%S"): ${0}" "${@}"
set -o xtrace   # enable script tracing

main "$@"
