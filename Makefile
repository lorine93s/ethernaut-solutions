-include .env

.PHONY: source .env

Telephone :; @forge script script/Telephone.s.sol:Telephone --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvv --verify --etherscan-api-key ${ETHERSCAN_API_KEY}