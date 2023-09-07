// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title Freeze Stewards
 * @author BGD Labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Arbitrum_FreezeStewards_20230907 is IProposalGenericExecutor {
  address public immutable FREEZING_STEWARD;

  constructor(address freezingSteward) {
    FREEZING_STEWARD = freezingSteward;
  }

  function execute() external {
    AaveV3Arbitrum.ACL_MANAGER.addRiskAdmin(FREEZING_STEWARD);
  }
}
