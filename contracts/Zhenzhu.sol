// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ZhenzhuToken is ERC20 {
    uint256 public burnRate; // Burn rate as a percentage (e.g., 2 means 2%)
    uint256 public minimumSupply = 100 * 10 ** decimals(); // Minimum supply set to 100 tokens

    constructor(uint256 _burnRate) ERC20("Zhenzhu", "BELLA") {
        require(_burnRate <= 100, "Burn rate cannot exceed 100%");
        burnRate = _burnRate;
        _mint(msg.sender, 1000 * 10 ** decimals()); // Mint 1000 tokens
    }

    // Override transfer function
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        uint256 burnAmount = (amount * burnRate) / 100; // Calculate burn amount
        uint256 transferAmount = amount - burnAmount;   // Remaining amount to transfer

        _burnWithMinimumSupplyCheck(msg.sender, burnAmount); // Burn tokens with safeguard
        return super.transfer(recipient, transferAmount);    // Perform the transfer
    }

    // Override transferFrom function
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        uint256 burnAmount = (amount * burnRate) / 100; // Calculate burn amount
        uint256 transferAmount = amount - burnAmount;   // Remaining amount to transfer

        _burnWithMinimumSupplyCheck(sender, burnAmount);     // Burn tokens with safeguard
        return super.transferFrom(sender, recipient, transferAmount); // Perform the transfer
    }

    // Internal function to check minimum supply before burning
    function _burnWithMinimumSupplyCheck(address account, uint256 amount) internal {
        uint256 currentSupply = totalSupply();
        if (currentSupply - amount < minimumSupply) {
            amount = currentSupply - minimumSupply; // Adjust burn amount to leave minimum supply intact
        }
        super._burn(account, amount); // Burn the adjusted amount
    }
}