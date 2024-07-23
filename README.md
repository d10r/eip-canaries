## EIP Canaries

This project collects canaries that detect EIP availability on chain. These canaries can be used to detect the evm
version of the chain.

## Usage

The current version is deployed to address 0x585a44ab8b8babb3a37dbe4590f475dbe0a80285 on the following networks:

Mainnets:
- [Ethereum](https://etherscan.io/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Gnosis Chain](https://gnosisscan.io/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Polygon Pos](https://polygonscan.com/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Optimism](https://optimistic.etherscan.io/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Arbitrum One](https://arbiscan.io/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Avalanche C-chain](https://snowtrace.io/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [BNB Smart Chain](https://bscscan.com/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Celo](https://explorer.celo.org/mainnet/address/0x585a44aB8b8BABb3a37dbe4590F475DbE0a80285/read-contract)
- [Base](https://basescan.org/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Scroll](https://scrollscan.com/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Degen Chain](https://explorer.degen.tips/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285?tab=read_contract)

Testnets:
- [Ethereum Sepolia](https://sepolia.etherscan.io/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Optimism Sepolia](https://sepolia-optimism.etherscan.io/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Scroll Sepolia](https://sepolia.scrollscan.com/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)
- [Avalanche Fuji](https://testnet.snowtrace.io/address/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285#readContract)

It is verified [on sourcify](https://sourcify.dev/#/lookup/0x585a44ab8b8babb3a37dbe4590f475dbe0a80285) and on some explorers.

In order to query the contract, any tooling able to make a contract call can be used, including explorer UIs where verified.

Example for querying with [cast](https://book.getfoundry.sh/reference/cast/cast-call):
```
$ cast call --rpc-url https://rpc.sepolia.org 0x585a44ab8b8babb3a37dbe4590f475dbe0a80285 'hasEIP3855()'
0x0000000000000000000000000000000000000000000000000000000000000001
```

## Deployment

In order to deploy to additional chains, first install dependencies and compile the contract:
```
forge install
forge compile
```

There's 2 possibilities for deploying:

**Recommended: Deterministic Address**

The recommended way of deploying is by using the [deterministic deployment proxy](https://github.com/Zoltu/deterministic-deployment-proxy) which is available on many EVM chains at address 0x7A0D94F55792C434d74a40883C6ed8545E406D12. By using CREATE2, it allows the contract to be deployed to an address deterministically derived from the bytecode.

Command used for deployment:
```
cast send --account <ACCOUNT_NAME> --rpc-url <RPC_URL> 0x7A0D94F55792C434d74a40883C6ed8545E406D12 $(jq -r '.bytecode.object' out/EIPCanaries.sol/EIPCanaries.json)
```

If the contract was already deployed to the connected chain, this command will revert.

**Fallback: Conventional**

If the recommended way of deploying isn't available on a chain, the contract can still be deployed in the _conventional_ way, with the drawback of yielding a different address:
```
forge create --account <ACCOUNT_NAME> --rpc-url <RPC_URL> src/EIPCanaries.sol:EIPCanaries
```

**Verification**

On sourcify:
```
forge verify-contract --rpc-url <RPC_URL> --verifier sourcify --watch 0x332e2c3e157a5d15415d25cbc920b2969c6fb3e8 src/EIPCanaries.sol:EIPCanaries
```

On Etherscan-based explorers:
```
forge verify-contract --rpc-url <RPC_URL> --verifier etherscan --etherscan-api-key <API_KEY> --watch 0x332e2c3e157a5d15415d25cbc920b2969c6fb3e8 src/EIPCanaries.sol:EIPCanaries
```

## Development

**Add A New Canary**

- Create a new yul object under `yul/` folder.
- Compile the yul object `solc --evm-version=london --strict-assembly --bin`. Note: use london as target.
- Create a new deployer and detection function in the `EIPCanaries` contract.
- Create a new test case in `EIPCanaries.t.sol`, and modify `test.sh`.
- Deploy the EIPCanaries and publish.

**Local Test**

```
$ ./test.sh
```

This will run EIPCanaries.t.sol for different evm versions (paris, shanghai, cancun) using foundry.

## TODO

- publish to the world as a public goods.