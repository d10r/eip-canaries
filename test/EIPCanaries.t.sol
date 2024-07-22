// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test, console } from "forge-std/Test.sol";
import { EIPCanaries } from "../src/EIPCanaries.sol";

contract EIPCanariesTest is Test {
    EIPCanaries private _c;

    function setUp() public {
        _c = new EIPCanaries();
    }

    function testHasEIP3855() external view {
        console.log("EIP_3855_CANARY", _c.EIP_3855_CANARY());
        assertTrue(_c.hasEIP3855());
    }

    function testHasEIP1153() external view {
        console.log("EIP_1153_CANARY", _c.EIP_1153_CANARY());
        assertTrue(_c.hasEIP1153());
    }
}
