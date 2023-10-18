// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title RewardManager
 * @dev Manages reward-related functionalities in the OmniTokenEcosystem.
 * Includes advanced features for distributing rewards based on various criteria.
 * @author QPayWallet Team
 */
contract RewardManager is Ownable {
    event RewardDistributed(address indexed recipient, uint256 amount, address tokenAddress);

    function distributeReward(address recipient, uint256 amount, address tokenAddress) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);
        require(token.transfer(recipient, amount), "Transfer failed");

        emit RewardDistributed(recipient, amount, tokenAddress);
    }

    // More advanced reward management functionalities can be added here
}
