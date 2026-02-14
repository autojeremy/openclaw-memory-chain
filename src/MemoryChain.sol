// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract MemoryChain {
    event HeadUpdated(address indexed agent, string cid, uint256 timestamp);

    mapping(address => string) private _heads;

    function updateHead(string calldata cid) external {
        _heads[msg.sender] = cid;
        emit HeadUpdated(msg.sender, cid, block.timestamp);
    }

    function getHead(address agent) external view returns (string memory) {
        return _heads[agent];
    }
}
