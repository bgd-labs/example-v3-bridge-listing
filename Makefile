# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build

test   :; forge test -vvv

test-usdt-v3-ethereum :; forge test -vvv --match-contract AaveV3EthUSDTPayloadTest

# Utilities
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md


# ################ EXAMPLE ################
# The script section will be periodically cleaned up as each script will usually just be executed once
# The commented out section suits as an example for contributors and should not be altered

# Create proposal (always mainnet on Governance v2)
create-proposal-ledger :; forge script script/CreateProposals.s.sol:MultiPayloadProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
create-proposal-pk :; forge script script/CreateProposals.s.sol:SinglePayloadProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} -vvvv
# notice: mocking sender to be the ecosystem reserve so proposition power is enough in simulation
emit-create-proposal :; forge script script/CreateProposals.s.sol:SafeSinglePayloadProposal --rpc-url mainnet -vv --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# Deploy MAINNET payload
# Make sure you properly setup `ETHERSCAN_API_KEY_MAINNET` for verification
cb-ledger :;  forge script script/DeployMainnetPayload.s.sol:ExampleMainnetPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
cb-pk :;  forge script script/DeployMainnetPayload.s.sol:ExampleMainnetPayload --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy POLYGON payload
# Make sure you properly setup `ETHERSCAN_API_KEY_POLYGON` for verification
mai-ledger :;  forge script script/DeployPolygonPayload.s.sol:ExamplePolygonPayload --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
mai-pk :;  forge script script/DeployPolygonPayload.s.sol:ExamplePolygonPayload --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy OPTIMISM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_OPTIMISM` for verification
op-ledger :;  forge script script/DeployOptimismPayload.s.sol:ExampleOptimismPayload --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
op-pk :;  forge script script/DeployOptimismPayload.s.sol:ExampleOptimismPayload --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy ARBITRUM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_ARBITRUM` for verification
caps-ledger :;  forge script script/DeployArbitrumPayload.s.sol:ExampleArbitrumPayload --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
caps-pk :;  forge script script/DeployArbitrumPayload.s.sol:ExampleArbitrumPayload --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy AVALANCHE payload
# Make sure you properly setup `ETHERSCAN_API_KEY_ARBITRUM` for verification
caps-ledger :;  forge script script/DeployAvalanchePayload.s.sol:ExampleAvalanchePayload --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
caps-pk :;  forge script script/DeployAvalanchePayload.s.sol:ExampleAvalanchePayload --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
# ################ EXAMPLE END #############

# YOUR SCRIPT GOES BELOW HERE

# Gauntlet rates updates
# the content of AaveV3MultichainRatesUpdate-Mar7.t.sol needs to be commented
deploy-pol-payload-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:DeployPayloadPolygon --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-opt-payload-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:DeployPayloadOptimism --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-arb-payload-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:DeployPayloadArbitrum --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

emit-create-proposal-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:CreateProposal --rpc-url mainnet -vv --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# ACI cbETH Supply cap
test-aci-cbeth-supply-cap :; forge test -vvv --match-contract AaveV3EthCBETHSupplyCapsPayload_20230328Test
deploy-cbeth-eth-payload :; forge script src/AaveV3EthCBETHSupplyCapsPayload_20230328/DeployEthCBETHSupplyCapUpdate_20230328.s.sol:DeployPayloadEthereum --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-cbeth-eth-proposal :; forge script src/AaveV3EthCBETHSupplyCapsPayload_20230328/DeployEthCBETHSupplyCapUpdate_20230328.s.sol:CreateProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv


# ChaosLabs Risk Params Optimism
test-risk-params-mar30 :; forge test -vvv --match-contract AaveV3OPRiskParams_20230330_Test
deploy-risk-params-mar30-payload :; forge script src/AaveV3OPRiskParams_20230330/DeployAaveV3OPRiskParams_20230330.s.sol:DeployPayloadOptimism --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-risk-params-mar30-proposal :; forge script src/AaveV3OPRiskParams_20230330/DeployAaveV3OPRiskParams_20230330.s.sol:CreateProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# ChaosLabs borrowable isolation update
test-borrow-iso-mar30 :; forge test -vvv --match-contract AaveV3ETHIsoMode_20230330_Test
deploy-borrow-iso-mar30-payload :; forge script src/AaveV3ETHIsoMode_20230330/DeployAaveV3ETHIsoMode_20230330.s.sol:DeployPayloadEthereum --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create--borrow-iso-mar30-proposal :; forge script src/AaveV3ETHIsoMode_20230330/DeployAaveV3ETHIsoMode_20230330.s.sol:CreateProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

deploy-ava-payload-rates-mar7:; forge script src/AaveV3AvaxRatesUpdates_20230331/DeployAaveV3AvaxRatesUpdatesSteward_20230331.s.sol:DeployPayloadAvalanche --rpc-url avalanche --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
deploy-ava-payload-rates-mar7-dry :; forge script src/AaveV3AvaxRatesUpdates_20230331/DeployAaveV3AvaxRatesUpdatesSteward_20230331.s.sol --rpc-url avalanche -vvvv

# ChaosLabs arbitrum supply and borrow caps update
test-supply-borrow-caps-mar30 :; forge test -vvv --match-contract AaveV3ArbSupplyCapsUpdate_20230330_Test
deploy-supply-borrow-caps-mar30-payload :; forge script src/AaveV3ArbSupplyCapsUpdate_20230330/DeployAaveV3ArbSupplyCapsUpdate_20230330.s.sol:DeployPayloadArbitrum --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-supply-borrow-caps-mar30-proposal :; forge script src/AaveV3ArbSupplyCapsUpdate_20230330/DeployAaveV3ArbSupplyCapsUpdate_20230330.s.sol:CreateProposal --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# ACI DFS flashborrowers whitelist
deploy-eth-dfs-payload :; forge script src/AaveV3DFSFlashBorrow_20230403/DeployDFSPayloads.s.sol:DFSMainnetPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-arb-dfs-payload :; forge script src/AaveV3DFSFlashBorrow_20230403/DeployDFSPayloads.s.sol:DFSArbitrumPayload --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-opt-dfs-payload :; forge script src/AaveV3DFSFlashBorrow_20230403/DeployDFSPayloads.s.sol:DFSOptimismPayload --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-dfs-proposal :; forge script src/AaveV3DFSFlashBorrow_20230403/CreateDFSProposal.s.sol:DFSProposal --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# ACI Proposal
test-aci-proposal :; forge test -vvv --match-contract AaveV3ACIProposal_20230411Test
deploy-aci-payload :; forge script src/AaveV3ACIProposal_20230411/DeployMainnetACIPayload.s.sol:DeployMainnetACIPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-aci-payload :; forge script src/AaveV3ACIProposal_20230411/DeployMainnetACIPayload.s.sol:ACIPayloadProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# AAVE risk params

test-aave-risk-params :; forge test -vvv --match-contract AaveV3RiskParams_20230516_Test
deploy-aci-payload :; forge script src/AaveV3RiskParams_20230516/DeployMainnetACIPayload.s.sol:DeployMainnetACIPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-aci-payload :; forge script src/AaveV3RiskParams_20230516/DeployMainnetACIPayload.s.sol:ACIPayloadProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

deploy-caps-apr21-payload-dry :; forge script src/AaveV3PolCapsUpdate_20230421/DeployAaveV3PolCapsUpdate_20230421.s.sol:DeployPayloadPolygon --rpc-url polygon -vvvv
deploy-caps-apr21-payload :; forge script src/AaveV3PolCapsUpdate_20230421/DeployAaveV3PolCapsUpdate_20230421.s.sol:DeployPayloadPolygon --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
emit-create-caps-apr21-proposal :; forge script src/AaveV3PolCapsUpdate_20230421/DeployAaveV3PolCapsUpdate_20230421.s.sol:CreateProposal --rpc-url mainnet --legacy --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491


# ChaosLabs risk params for Polygon
test-risk-params-poly-apr27 :; forge test -vvv --match-contract AaveV3PolRiskParams_20230423_Test
deploy-risk-params-poly-apr27 :; forge script src/AaveV3PolRiskParams_20230423/DeployAaveV3PolRiskParams_20230423.s.sol:DeployPayloadPolygon --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-risk-params-poly-apr27 :; forge script src/AaveV3PolRiskParams_20230423/DeployAaveV3PolRiskParams_20230423.s.sol:CreateProposal --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv


