/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface DelegateERC20 {
    function delegateTransfer(
        address to,
        uint256 value,
        address origSender
    ) external returns (bool);
}

interface ILegacyToken {
    function delegate() external view returns (DelegateERC20);

    function mint(address to, uint256 amount) external;

    function delegateToNewContract(DelegateERC20 newContract) external;

    function transfer(address to, uint256 value) external returns (bool);
}

interface IDoubleEntryPoint {
    function cryptoVault() external view returns (address);

    function delegatedFrom() external view returns (address);

    function forta() external view returns (IForta);
}

interface ICryptoVault {
    function sweptTokensRecipient() external view returns (address);

    function underlying() external view returns (IERC20);

    function sweepToken(IERC20 token) external;
}

interface IForta {
    function setDetectionBot(address detectionBotAddress) external;

    function notify(address user, bytes calldata msgData) external;

    function raiseAlert(address user) external;
}

contract DetectionBot {
    IForta public forta;
    address public cryptoVaultAddress;

    constructor(IForta _forta, address _cryptoVaultAddress) {
        forta = IForta(_forta);
        cryptoVaultAddress = _cryptoVaultAddress;
    }

    function handleTransaction(address user, bytes calldata) public {
        address origSender;
        assembly {
            origSender := calldataload(0xa8)
        }

        if (origSender == cryptoVaultAddress) {
            forta.raiseAlert(user);
        }
    }
}

contract DoubleEntryPoint is Script {
    function run() public {
        vm.startBroadcast();

        IDoubleEntryPoint doubleEntryPoint = IDoubleEntryPoint(
            0xF06DF7d0452e8a5edfA29250D1dd0Ccb128bEC47
        );
        ICryptoVault cryptoVault = ICryptoVault(doubleEntryPoint.cryptoVault());
        ILegacyToken legacyToken = ILegacyToken(
            doubleEntryPoint.delegatedFrom()
        );
        // Sets up detection bot
        DetectionBot detectionBot = new DetectionBot(
            doubleEntryPoint.forta(),
            address(cryptoVault)
        );
        doubleEntryPoint.forta().setDetectionBot(address(detectionBot));

        // This would check it fails
        // cryptoVault.sweepToken(IERC20(address(legacyToken)));

        vm.stopBroadcast();
    }
}
