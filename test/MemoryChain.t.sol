// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test} from "forge-std/Test.sol";
import {MemoryChain} from "../src/MemoryChain.sol";

contract MemoryChainTest is Test {
    MemoryChain mc;

    function setUp() public {
        mc = new MemoryChain();
    }

    function test_updateAndGetHead() public {
        mc.updateHead("bafyabc123");
        assertEq(mc.getHead(address(this)), "bafyabc123");
    }

    function test_separateHeadsPerAddress() public {
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        vm.prank(alice);
        mc.updateHead("cid-alice");

        vm.prank(bob);
        mc.updateHead("cid-bob");

        assertEq(mc.getHead(alice), "cid-alice");
        assertEq(mc.getHead(bob), "cid-bob");
    }

    function test_overwriteHead() public {
        mc.updateHead("cid-v1");
        assertEq(mc.getHead(address(this)), "cid-v1");

        mc.updateHead("cid-v2");
        assertEq(mc.getHead(address(this)), "cid-v2");
    }

    function test_emitsHeadUpdated() public {
        vm.expectEmit(true, false, false, true);
        emit MemoryChain.HeadUpdated(address(this), "bafynew", block.timestamp);
        mc.updateHead("bafynew");
    }

    function test_getHeadReturnsEmptyForUnknown() public {
        assertEq(mc.getHead(makeAddr("nobody")), "");
    }
}
