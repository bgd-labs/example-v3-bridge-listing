// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {console2} from 'forge-std/Test.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {SwapFor80BAL20WETHPayload} from './AaveV2CollectorSwap80BAL20WETH_20230403_Payload.sol';

contract SwapFor80BAL20WETHPayloadTest is ProtocolV3TestBase, TestWithExecutor {
    SwapFor80BAL20WETHPayload payload;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("mainnet"), 17123211);
        _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

        payload = new SwapFor80BAL20WETHPayload();
    }

    function test_AGDApproval() public {
        assertEq(IERC20(payload.aUSDTV1()).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()), payload.AMOUNT_AUSDT());
        assertEq(IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()), 0);


        vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
        _executePayload(address(payload));
        vm.stopPrank();

        assertEq(IERC20(payload.aUSDTV1()).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()), 0);
        assertEq(IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()), payload.AMOUNT_AUSDT());

        vm.prank(payload.AGD_MULTISIG());
        IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).transfer(makeAddr("new-addy"), payload.AMOUNT_AUSDT());
    }

    // function test_swap() public {

    // }

    // function test_RevertIf_alreadyExecuted() public {
    //     _executePayload(address(payload));
    //     vm.expectRevert(SwapFor80BAL20WETHPayload.AlreadyExecuted.selector);
    //     _executePayload(address(payload));
    // }
}