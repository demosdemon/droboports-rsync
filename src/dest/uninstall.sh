#!/usr/bin/env sh
#
# uninstall script

prog_dir="$(dirname "$(realpath "${0}")")"
name="$(basename "${prog_dir}")"
tmp_dir="/tmp/DroboApps/${name}"
logfile="${tmp_dir}/uninstall.log"

# script hardening
set -o errexit  # exit on uncaught error code
set -o nounset  # exit on unset variable
set -o pipefail # propagate last error code on pipe
set -o xtrace   # enable script tracing

# ensure log folder exists
if [ ! -d "${tmp_dir}" ]; then mkdir -p "${tmp_dir}"; fi
# redirect all output to logfile
exec 3>&1 4>&2 1>> "${logfile}" 2>&1
# log current date, time, and invocation parameters
echo "$(date +"%Y-%m-%d %H-%M-%S"): ${0}" "${@}"

# echo to stdout, since >&1 goes to logfile
echo "uninstall.sh completed." >&3
