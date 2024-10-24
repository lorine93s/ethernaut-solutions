-include .env

.PHONY: source .env

Telephone :; @forge script script/Telephone.s.sol:Telephone --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

Force :; @forge script script/Force.s.sol:Force --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

King :; @forge script script/King.s.sol:King --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

ReEntrancy :; @forge script script/ReEntrancy.s.sol:ReEntrancy --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

Elevator :; @forge script script/Elevator.s.sol:Elevator --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

GatekeeperOne :; @forge script script/GatekeeperOne.s.sol:GatekeeperOne --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

Preservation :; @forge script script/Preservation.s.sol:Preservation --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

Recovery :; @forge script script/Recovery.s.sol:Recovery --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

AlienCodex :; @forge script script/AlienCodex.s.sol:AlienCodex --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}
