rsync
===

This is a set of scripts to package a DroboApp from scratch, i.e., download sources, unpackage, compile, install, and package in a TGZ file.

## I just want to install the DroboApp, what do I do?

Check the [releases](https://github.com/demosdemon/droboports-rsync/releases) page. If there are no releases available, then you have to compile.

## How to compile

First make sure that you have a [working cross-compiling VM](https://github.com/droboports/droboports.github.io/wiki/Setting-up-a-VM).

Log in the VM, pick a temporary folder (e.g., `~/build`), and then do:

```
git clone https://github.com/demosdemon/droboports-rsync.git rsync
cd rsync
./build.sh
ls -la *.tgz
```

Each invocation creates a log file with all the generated output.

* `./build.sh distclean` removes everything, including downloaded files.
* `./build.sh clean` removes everything but downloaded files.
* `./build.sh package` repackages the DroboApp, without recompiling.

## Sources

* zlib: http://zlib.net/
* rsync: https://rsync.samba.org/
