#!/usr/bin/env sh
#
# install script

prog_dir="$(dirname "$(realpath "${0}")")"
name="$(basename "${prog_dir}")"
tmp_dir="/tmp/DroboApps/${name}"
logfile="${tmp_dir}/install.log"

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

# copy default configuration files
find "${prog_dir}" -type f -name "*.default" -print | while read deffile; do
  basefile="$(dirname ${deffile})/$(basename ${deffile} .default)"
  if [ ! -f "${basefile}" ]; then
    cp -v -f "${deffile}" "${basefile}"
  fi
done

mkdir -v -p "${prog_dir}/etc" "${prog_dir}/var/run" "${prog_dir}/var/log"
chmod -c a+x service.sh
chmod -c -R g+w etc var

# echo to stdout, since >&1 goes to logfile
echo "install.sh completed." >&3
