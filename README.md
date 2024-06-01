# Building-on-Avalanche---ETH-AVAX
# Project: Degen Token (ERC-20): Unlocking the Future of Gaming
## Overview
Degen Gaming, a renowned game studio, has approached you to create a unique token that can reward players and take their game to the next level. You have been tasked with creating a token that can be earned by players in their game and then exchanged for rewards in their in-game store. A smart step towards increasing player loyalty and retention.

To support their ambitious plans, Degen Gaming has selected the Avalanche blockchain, a leading blockchain platform for web3 gaming projects, to create a fast and low-fee token. With these tokens, players can not only purchase items in the store, but also trade them with other players, providing endless possibilities for growth.

# Description
This prgram is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. The smart contract should have the following functionality:-

(1) Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
(2) Transferring tokens: Players should be able to transfer their tokens to others.
(3) Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
(4) Checking token balance: Players should be able to check their token balance at any time.
(5) Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.

## Getting Started
### Functionalities
- mintTokens(): Initialize to mint a token. It needed a account address and amount value that you want to mint.
  
- burnToken():  Initialize to burn a token. It has a condition that token balance must be greater than 50 to burn.
  
- transferTokens(): It allow to transfer a token to another account. It has a contidtion that token balance must be greater than 100 to transfer token.
  
- redeemTokens(): It allow the user to redeem a tokens for item they want to redeem. This are the available items to redeem armor, sword, shield, potion and have a assigned prices to this items.
  
## Executing program 
- To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.
- Open a Solidity file in the repository and copy the code and paste it to the IDE you use.
-Add sol suffixes in your file name if you try to run it to the IDE so it read as a SOLIDITY FILE

        // SPDX-License-Identifier: MIT
        pragma solidity ^0.8.9;
        
        import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
        import "@openzeppelin/contracts/access/Ownable.sol";
        
        contract DegenToken is ERC20, Ownable{
            
            event ItemRedeemed(address indexed user, string item,uint256 quantity, uint256 itemCost);
            enum Item {Armor, Sword, Shield, Potion}
            mapping (string =>uint256) public itemPrices;
            
            constructor(uint256 initialSupply, address inputOwner) ERC20("DegenTokens", "DGN") Ownable(inputOwner) 
                   {
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
        
             function burnTokens( address to, uint256 amount) external {
                require(balanceOf(to) >= 50, "Your token balance must be greater than 50 to burn");
                _burn(to, amount);
            }
        
            function transferTokens(address from, address to, uint256 amount) external {
                require(balanceOf(from) >= 100, "Insufficient token balance to transfer. Your token balance must be greater than 100 to transfer token.");
                _transfer(from, to, amount);
                
            }
        
            function redeemTokens(address user,string memory itemName, uint256 quantity) external {
                require(itemPrices[itemName] > 0, "Invalid item name");
                uint256 itemCost = itemPrices[itemName] * quantity;
                require(balanceOf(user) >= itemCost, "Insufficient token balance to redeem item");
        
                _burn(user, itemCost);
        
                 emit ItemRedeemed(user, itemName, quantity, itemCost);
            }    
        }


## Reminder
Be aware and alert for some errors:

- You will notice if your code have an error check on the upper right side of your screen you will your mini-minimize entire code there that have a red lines, blue lines mean you are in that lines and red lines means error.
- You will see a Red Exclamation Mark in that line so you will notice that there some errors
- Check your File name if its red
- Don't forget to count and check some valuable symbols { } , [ ] , ( ) , ;

## Author
NTCIAN Rix
Email: 422003664@ntc.edu.ph
<br>
[Discord: @Rix](rix1473)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
