// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadOptimism, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';


/**
 * @title Generator
 * @author BGD labs
 * - Snapshot: https://notarealsnapshot
 * - Discussion: https://notarealproposal
 */
contract AaveV3_Optimism_Generator_20230808 is AaveV3PayloadOptimism {function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategies = new IEngine.RateStrategyUpdate[](1);

    // rateStrategies[0] = IEngine.RateStrategyUpdate({
    //   asset: AaveV3ArbitrumAssets.WETH_UNDERLYING,
    //   params: Rates.RateStrategyParams({
    //     optimalUsageRatio: _bpsToRay(80_00),
    //     baseVariableBorrowRate: _bpsToRay(1_00),
    //     variableRateSlope1: _bpsToRay(3_80),
    //     variableRateSlope2: _bpsToRay(80_00),
    //     stableRateSlope1: _bpsToRay(4_00),
    //     stableRateSlope2: _bpsToRay(80_00),
    //     baseStableRateOffset: _bpsToRay(3_00),
    //     stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
    //     optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
    //   })
    // });

    return rateStrategies;
  }

}