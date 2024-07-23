## EIP Canaries

This project collects canaries that detect EIP availability on chain. These canaries can be used to detect the evm
version of the chain.

## Usage

(TODO)

- deploy to more networks;
- publish to the world as a public goods.

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
