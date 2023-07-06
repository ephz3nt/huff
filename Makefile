include .env
test:
	@forge test --match-contract DepositTest -vvvv
deploy-goerli:
	@forge script script/Deposit.Depoly.sol --broadcast --fork-url ${GOERLI_URL} --private-key ${PRIVATE_KEY}
.PHONY: test deploy-goerli