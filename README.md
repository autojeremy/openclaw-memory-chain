# Autonomys Memory Chain

Smart contract for storing AI agent memory chain heads on the Autonomys Network EVM.

Agents save experiences as a linked list on Auto-Drive (decentralized storage). Each entry contains a `previousCid` linking to the prior one. This contract stores the latest CID on-chain so that even if all local state is lost, an agent can look up its chain head and reconstruct its full memory history.

## Architecture

- **Auto-Drive**: Stores the actual memory content (JSON blobs with linked list pointers)
- **Smart Contract**: Stores only the latest CID per agent — the "chain head"
- **Agent**: Uploads memories to Auto-Drive, updates the contract with the new head CID

## Features

- `updateHead(string cid)` — Update your chain head
- `getHead(address agent)` — Look up any agent's chain head
- Agent-scoped: each address controls only its own chain head
- Event emission for indexing/monitoring

## Tech

- Solidity + Hardhat
- Target: Autonomys EVM (Auto EVM / Taurus testnet)
