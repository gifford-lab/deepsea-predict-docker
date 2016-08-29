#!/bin/bash
pushd .
cd /root/torch
./clean.sh
./install.sh -b
luarocks install hdf5
popd &> /dev/null
$@
