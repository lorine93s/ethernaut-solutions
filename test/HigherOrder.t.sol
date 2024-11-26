// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";

contract TestHigherOrder {
    address public commander;

    uint256 public treasury;

    function registerTreasury(uint8) public {
        uint256 value;
        assembly {
            value := calldataload(4)
            sstore(treasury_slot, calldataload(4))
        }
        console.log("value", value);
    }

    function claimLeadership() public {
        if (treasury > 255) commander = msg.sender;
        else revert("Only members of the Higher Order can become Commander");
    }
}

contract HigherOrder is Test {
    TestHigherOrder public testHigherOrder;

    function setUp() public {
        testHigherOrder = new TestHigherOrder();
    }

    function test_higherOrder() public {
        console.log("hola");
        testHigherOrder.registerTreasury(42);
    }
}
