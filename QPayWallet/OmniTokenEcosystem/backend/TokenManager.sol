// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title TokenManager
 * @dev Manages the token-related functionalities in the OmniTokenEcosystem.
 * Includes advanced features for token creation, burning, and administration.
 * @author QPayWallet Team
 */
contract TokenManager is Ownable {
    mapping(address => uint256) public tokenSupply;
    mapping(address => bool) public isToken;

    event TokenCreated(address indexed tokenAddress, uint256 initialSupply);
    event TokenBurned(address indexed tokenAddress, uint256 amount);

    function createToken(string memory name, string memory symbol, uint256 initialSupply) external onlyOwner returns(address) {
        IERC20 newToken = new IERC20(name, symbol);
        newToken.mint(msg.sender, initialSupply);
        tokenSupply[address(newToken)] = initialSupply;
        isToken[address(newToken)] = true;

        emit TokenCreated(address(newToken), initialSupply);
        return address(newToken);
    }

    function burnToken(address tokenAddress, uint256 amount) external onlyOwner {
        require(isToken[tokenAddress], "Not a valid token");
        require(tokenSupply[tokenAddress] >= amount, "Insufficient supply to burn");

        IERC20 token = IERC20(tokenAddress);
        token.burn(amount);
        tokenSupply[tokenAddress] -= amount;

        emit TokenBurned(tokenAddress, amount);
    }
}
