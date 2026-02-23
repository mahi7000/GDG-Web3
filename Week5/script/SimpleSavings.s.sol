// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {SimpleSavings} from "../src/SimpleSavings.sol";

contract SimpleSavingsScript is Script {
    SimpleSavings public bank;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        bank = new SimpleSavings();

        vm.stopBroadcast();
    }
}
