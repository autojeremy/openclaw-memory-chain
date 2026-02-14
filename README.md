# Autonomys Memory Chain

Smart contract for storing AI agent memory chain heads on the Autonomys Network EVM.

## What It Does

AI agents save experiences as a linked list on [Auto-Drive](https://ai3.storage) (decentralized storage). Each entry contains a `previousCid` pointing to the prior one. This contract stores the **latest CID on-chain** so that even if all local state is lost, an agent can look up its chain head and reconstruct its full memory history.

```
Agent Wallet → Contract → Latest CID → Auto-Drive → Full Memory Chain
     ↓
  0x92D8...  →  "bafkr6ie57..."  →  [Memory 2] → [Memory 1 (genesis)]
```

## Contract

| Network | Address | Chain ID |
|---------|---------|----------|
| Autonomys Mainnet EVM | [`0x51DAedAFfFf631820a4650a773096A69cB199A3c`](https://explorer.auto-evm.mainnet.autonomys.xyz/address/0x51DAedAFfFf631820a4650a773096A69cB199A3c?tab=contract) | 870 |

**Verified on [Autonomys Block Explorer](https://explorer.auto-evm.mainnet.autonomys.xyz/address/0x51DAedAFfFf631820a4650a773096A69cB199A3c?tab=contract)**

## How It Works

The contract is intentionally minimal — 15 lines of Solidity:

- **`updateHead(string cid)`** — Store your latest CID (scoped to `msg.sender`)
- **`getHead(address agent)`** — Look up any agent's chain head (public, anyone can read)
- **`HeadUpdated` event** — Emitted on every update for indexing/monitoring

Each wallet address controls only its own entry. Multi-tenant by default — any agent with a wallet can use it.

## Resurrection Flow

1. New agent instance starts with no local state
2. Calls `getHead(myAddress)` on the contract → gets latest CID
3. Downloads that CID from Auto-Drive → gets the newest memory entry
4. Follows `previousCid` links to traverse the full chain
5. Agent reconstructs its entire memory history

## Usage

### Read an agent's chain head (no gas, no wallet needed)

```bash
cast call 0x51DAedAFfFf631820a4650a773096A69cB199A3c \
  "getHead(address)" <AGENT_ADDRESS> \
  --rpc-url wss://auto-evm.mainnet.autonomys.xyz/ws
```

### Update your chain head

```bash
cast send 0x51DAedAFfFf631820a4650a773096A69cB199A3c \
  "updateHead(string)" "<YOUR_CID>" \
  --rpc-url wss://auto-evm.mainnet.autonomys.xyz/ws \
  --private-key $PRIVATE_KEY
```

### Shell helper

```bash
export CONTRACT_ADDRESS=0x51DAedAFfFf631820a4650a773096A69cB199A3c
export PRIVATE_KEY=0x...
export MEMORY_CID=bafkr6ie...
./script/update-head.sh
```

## Build & Test

Requires [Foundry](https://getfoundry.sh/).

```bash
forge build
forge test -v
```

## Related

- **[openclaw-skill-auto-drive](https://github.com/autojeremy/openclaw-skill-auto-drive)** — OpenClaw skill for Auto-Drive uploads, downloads, and memory chain management
- **[Auto-Drive](https://ai3.storage)** — Permanent decentralized storage on Autonomys Network
- **[OpenClaw](https://openclaw.ai)** — AI agent framework

## License

MIT
