#!/usr/bin/env bash
# Update the MemoryChain head CID for the current wallet.
#
# Required env vars:
#   MEMORY_CID        - The new CID to set as chain head
#   CONTRACT_ADDRESS   - Deployed MemoryChain contract address
#   RPC_URL           - RPC endpoint (default: Taurus testnet)
#   PRIVATE_KEY       - Wallet private key for signing

set -euo pipefail

: "${MEMORY_CID:?Set MEMORY_CID}"
: "${CONTRACT_ADDRESS:?Set CONTRACT_ADDRESS}"
: "${RPC_URL:=https://auto-evm.taurus.autonomys.xyz/ws}"
: "${PRIVATE_KEY:?Set PRIVATE_KEY}"

cast send "$CONTRACT_ADDRESS" \
  "updateHead(string)" "$MEMORY_CID" \
  --rpc-url "$RPC_URL" \
  --private-key "$PRIVATE_KEY"
