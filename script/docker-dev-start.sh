#!/usr/bin/env bash

set -xeuo pipefail

bundle

if [[ -f ./test/dummy/tmp/pids/server.pid ]]; then
  rm ./test/dummy/tmp/pids/server.pid
fi

cd test/dummy

bin/rails db:setup

bin/rails server --port 3000 --binding 0.0.0.0
