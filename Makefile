-include .env

.PHONY: source .env

Telephone :; @forge script script/Telephone.s.sol:Telephone --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

Force :; @forge script script/Force.s.sol:Force --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

King :; @forge script script/King.s.sol:King --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

