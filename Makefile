-include .env

build:; forge build

deploy-sepolia:
	forge script script/FundMe.s.sol:FundMeScript --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -vvvv
