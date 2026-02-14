// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {MemoryChain} from "../src/MemoryChain.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();
        MemoryChain mc = new MemoryChain();
        console.log("MemoryChain deployed at:", address(mc));
        vm.stopBroadcast();
    }
}
