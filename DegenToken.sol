// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Degen is ERC20, Ownable {

    enum StoreItems {  
        Pistol, 
        Armour, 
        Gun
    }

    constructor() ERC20("Degen", "DWN") Ownable(msg.sender) {}

    function calculateDecimals() private view returns(uint){
        return 10 ** decimals();
    }

    function mintDegenToken(uint256 amount) public onlyOwner {
        _mint(msg.sender, (amount * calculateDecimals()));
    }

    function buyStoreItems(StoreItems item) external {
        uint256 price = getStoreItemPrice(item);
        require(price <= balanceOf(msg.sender), "Insufficient Degen Token");
        _transfer(msg.sender, address(this), price);
    }

    function burnDegenToken(uint256 _amount) external {
        require((_amount * calculateDecimals()) <= balanceOf(msg.sender), "Insufficient Degen Token");
        
        _burn(msg.sender, (_amount * calculateDecimals()));
    }

    function getStoreItemPrice(StoreItems item) private view returns (uint256) {
        if (item == StoreItems.Pistol) {
            return 10 * calculateDecimals();
        } else if (item == StoreItems.Armour) {
            return 8 * calculateDecimals();
        } else if (item == StoreItems.Gun) {
            return 6 * calculateDecimals();
        }
        else {
            return 0;
        }
    }
}
