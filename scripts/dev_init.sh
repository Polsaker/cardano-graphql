#!/usr/bin/env bash

set -euo pipefail

BIN_DIR=../bin

mkdir -p \
  state/network/mainnet/node-ipc \
  state/network/testnet/node-ipc \
  state/network/allegra/node-ipc \
  state/network/launchpad/node-ipc
cabal update
cd cardano-node
cabal install cardano-node \
  --install-method=copy \
  --installdir=${BIN_DIR} \
  --overwrite-policy=always \
  -f -systemd
cabal install cardano-cli \
  --install-method=copy \
  --installdir=${BIN_DIR} \
  --overwrite-policy=always \
  -f -systemd
curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | INSTALL_PATH=${BIN_DIR} bash
${BIN_DIR}/hasura --skip-update-check update-cli --version v1.3.3