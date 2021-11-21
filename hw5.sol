//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Volcano is ERC20,Ownable {
    
  string private TOKEN_NAME = "Volcano";
  string private TOKEN_SYMBOL = "volc";

  uint private TOTAL_SUPPLY = 10000;

  struct Payment {
      address payable receip;
      uint amount;
  }
  
  mapping (address => Payment[]) public lstRecipPayment;

  event TotalSupply(uint);
 
  // Code 
  constructor() ERC20(TOKEN_NAME, TOKEN_SYMBOL) {
    _mint(msg.sender, TOTAL_SUPPLY);
  }

  function increaseSupply() public onlyOwner {
    _mint(msg.sender, 1000);
    TOTAL_SUPPLY = TOTAL_SUPPLY + 1000;
    emit TotalSupply(TOTAL_SUPPLY);
  }
  
  function transfert(uint amount, address payable sender, address payable receiver) public payable {
      require(msg.sender == sender);
      
      transfer(receiver, amount);
      emit Transfer(sender, receiver, amount);
      
     lstRecipPayment[msg.sender].push(Payment(receiver, amount));
     
  }
  
  function getListPayment(address add) public view returns(Payment[] memory) {
    return lstRecipPayment[add];
  }
  
}



