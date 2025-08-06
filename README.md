## EIP Canaries

This project collects canaries that detect EIP availability on chain. These canaries can be used to detect the evm
version of the chain.

## Usage

The current version is deployed to address 0xC1D917D2E025856AC24ec7c4D325E6990FfC858e on the following networks:

Mainnets:
- [Ethereum](https://etherscan.io/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Gnosis Chain](https://gnosisscan.io/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Polygon Pos](https://polygonscan.com/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Optimism](https://optimistic.etherscan.io/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Arbitrum One](https://arbiscan.io/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Avalanche C-chain](https://snowtrace.io/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [BNB Smart Chain](https://bscscan.com/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Celo](https://explorer.celo.org/mainnet/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e/read-contract)
- [Base](https://basescan.org/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Scroll](https://scrollscan.com/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Degen Chain](https://explorer.degen.tips/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e?tab=read_contract)

Testnets:
- [Ethereum Sepolia](https://sepolia.etherscan.io/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Optimism Sepolia](https://sepolia-optimism.etherscan.io/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Scroll Sepolia](https://sepolia.scrollscan.com/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)
- [Avalanche Fuji](https://testnet.snowtrace.io/address/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e#readContract)

It is verified [on sourcify](https://sourcify.dev/#/lookup/0xC1D917D2E025856AC24ec7c4D325E6990FfC858e) and on some explorers.

In order to query the contract, any tooling able to make a contract call can be used, including explorer UIs where verified.

Example for querying with [cast](https://book.getfoundry.sh/reference/cast/cast-call):
```
$ cast call --rpc-url https://rpc.sepolia.org 0xC1D917D2E025856AC24ec7c4D325E6990FfC858e 'hasEIP5656()'
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
forge verify-contract --rpc-url <RPC_URL> --verifier sourcify --watch <CONTRACT_ADDRESS> src/EIPCanaries.sol:EIPCanaries
```

On Etherscan-based explorers:
```
forge verify-contract --rpc-url <RPC_URL> --verifier etherscan --etherscan-api-key <API_KEY> --watch <CONTRACT_ADDRESS> src/EIPCanaries.sol:EIPCanaries
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