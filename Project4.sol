// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    
    event ItemRedeemed(address indexed user, string item, uint256 quantity, uint256 itemCost);
    enum Item { Armor, Sword, Shield, Potion }
    mapping(string => uint256) public itemPrices;
    mapping(address => string[]) private userItemNames; // Mapping to track redeemed item names
    mapping(address => mapping(string => uint256)) public userItems; // Mapping to track redeemed item quantities
    
    constructor(uint256 initialSupply, address inputOwner) ERC20("DegenTokens", "DGN") Ownable(inputOwner) {
        _mint(msg.sender, initialSupply);

        // Set items prices
        itemPrices["Armor"] = 500;
        itemPrices["Sword"] = 200;
        itemPrices["Shield"] = 300;
        itemPrices["Potion"] = 100;
    }
    
    function mintTokens(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burnTokens(address to, uint256 amount) external {
        require(balanceOf(to) >= 50, "Your token balance must be greater than 50 to burn");
        _burn(to, amount);
    }

    function transferTokens(address from, address to, uint256 amount) external {
        require(balanceOf(from) >= 100, "Insufficient token balance to transfer. Your token balance must be greater than 100 to transfer token.");
        _transfer(from, to, amount);
    }

    function redeemTokens(address user, string memory itemName, uint256 quantity) external {
        require(itemPrices[itemName] > 0, "Invalid item name");
        uint256 itemCost = itemPrices[itemName] * quantity;
        require(balanceOf(user) >= itemCost, "Insufficient token balance to redeem item");

        _burn(user, itemCost);

        // If this is the first time the user redeems this item, add it to the list of item names
        if (userItems[user][itemName] == 0) {
            userItemNames[user].push(itemName);
        }

        userItems[user][itemName] += quantity; // Track the redeemed item

        emit ItemRedeemed(user, itemName, quantity, itemCost);
    }

    // Function to check the names and quantities of the items a user has redeemed
    function displayUserItems(address user) external view returns (string[] memory itemNames, uint256[] memory itemQuantities) {
        uint256 itemCount = userItemNames[user].length;
        itemQuantities = new uint256[](itemCount);
        
        for (uint256 i = 0; i < itemCount; i++) {
            itemQuantities[i] = userItems[user][userItemNames[user][i]];
        }
        
        return (userItemNames[user], itemQuantities);
    }
}
