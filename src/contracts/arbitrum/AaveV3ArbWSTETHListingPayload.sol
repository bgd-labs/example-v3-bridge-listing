// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IGenericV3ListingEngine, AaveV3ListingArbitrum} from 'aave-helpers/v3-listing-engine/AaveV3ListingArbitrum.sol';

/**
 * @title List wstETH on AaveV3Arbitrum
 * @author Llama
 * @dev This proposal lists wstETH on Aave V3 Arbitrum
 * Governance: https://governance.aave.com/t/arc-add-support-for-wsteth-on-arbitrum-aave-v3/11387/11
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x402647b83c436aecbe2fe404870f08767b5509225cbe606913e50801f87f5db8
 */
contract AaveV3ArbWSTETHListingPayload is AaveV3ListingArbitrum {
  address public constant WSTETH = 0x5979D7b546E38E414F7E9822514be443A4800529;
  address public constant WST_ETH_PRICE_FEED = 0xB1552C5e96B312d0Bf8b554186F846C40614a540; // TODO: wstETH/stETH, need wstETH/USD
  address public constant INTEREST_RATE_STRATEGY = 0x4b8D3277d49E114C8F2D6E0B2eD310e29226fe16;

  constructor() AaveV3ListingArbitrum(IGenericV3ListingEngine(AaveV3Arbitrum.LISTING_ENGINE)) {}

  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: WSTETH,
      assetSymbol: 'wstETH',
      priceFeed: WST_ETH_PRICE_FEED,
      rateStrategy: INTEREST_RATE_STRATEGY,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: false,
      ltv: 70_00,
      liqThreshold: 79_00,
      liqBonus: 7_20,
      reserveFactor: 15_00,
      supplyCap: 1_200,
      borrowCap: 190,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 1
    });

    return listings;
  }
}
