#!/bin/bash
pushd "${0%/*}" || exit

docker build --rm -t torgie/deno.land:latest ../

popd || exit
