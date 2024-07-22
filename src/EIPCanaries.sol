// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

contract EIPCanaries {
    address public EIP_3855_CANARY;
    address public EIP_1153_CANARY;

    constructor() {
        deployEIP3855Canary();
        deployEIP1153Canary();
    }

    function deployEIP3855Canary() internal {
        // $ solc --evm-version=london --strict-assembly --bin yul/EIP3855Canary.yul
        bytes memory bytecode = hex"6001600d60003960016000f3fe5f";
        assembly { sstore(EIP_3855_CANARY.slot, create(0, add(bytecode, 0x20), mload(bytecode))) }
    }

    function deployEIP1153Canary() internal {
        // $ solc --evm-version=london --strict-assembly --bin yul/EIP1153Canary.yul
        bytes memory bytecode = hex"6004600d60003960046000f3fe60005c50";
        assembly { sstore(EIP_1153_CANARY.slot, create(0, add(bytecode, 0x20), mload(bytecode))) }
    }

    function hasEIP3855() external view returns (bool yes) {
        (yes, ) = EIP_3855_CANARY.staticcall(hex"deadbeef");
    }

    function hasEIP1153() external view returns (bool yes) {
        (yes, ) = EIP_1153_CANARY.staticcall(hex"deadbeef");
    }
}
