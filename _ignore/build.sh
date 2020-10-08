#!/bin/bash
pushd "${0%/*}" || exit

docker build --rm -t helppoelama/deno:latest ../

popd || exit
