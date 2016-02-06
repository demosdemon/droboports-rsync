### ZLIB ###
_build_zlib() {
local VERSION="1.2.8"
local FOLDER="zlib-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://zlib.net/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --prefix="${DEPS}" --libdir="${DEST}/lib"
make
make install
rm -v "${DEST}/lib"/*.a
popd
}

### DROPBEAR ###
_build_rsync() {
local VERSION="3.1.2"
local FOLDER="rsync-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="https://download.samba.org/pub/rsync/src/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
CFLAGS="$CFLAGS -O3" rsync_cv_HAVE_SECURE_MKSTEMP=yes ./configure --host="${HOST}" --prefix="${DEST}" --mandir="${DEST}/man" --with-zlib="${DEST}" --with-rsyncd-conf="${DEST}/etc/rsyncd.conf" --with-nobody-group=nobody
make
make install
popd
}

_build() {
  _build_zlib
  _build_rsync
  _package
}
