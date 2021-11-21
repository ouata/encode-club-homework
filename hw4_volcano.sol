//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Volcano is ERC20 {
    
  string private TOKEN_NAME = "Volcano";
  string private TOKEN_SYMBOL = "volc";

  uint private TOTAL_SUPPLY = 10000;

  address private owner;
  
  mapping (address => uint) public balance;
  
  struct Payment {
      address payable receip;
      uint amount;
  }
  
  mapping (address => Payment[]) lstRecipPayment;


  modifier OnlyOwner() {
      require (msg.sender == owner);
      _;
  }
  
  event TotalSupply(uint);
 
  // Code 
  constructor() ERC20(TOKEN_NAME, TOKEN_SYMBOL) {
    owner = msg.sender;  
    _mint(msg.sender, TOTAL_SUPPLY);
    balance[msg.sender] = TOTAL_SUPPLY;
  }

  function GetTotalSupply() public view returns (uint) {
      return TOTAL_SUPPLY;
  }
  
  function GetBalance(address receip) public view returns (uint) {
      return balance[receip];
  }

  function increaseSupply() public OnlyOwner {
    _mint(msg.sender, 1000);
    TOTAL_SUPPLY = TOTAL_SUPPLY + 1000;
    emit TotalSupply(TOTAL_SUPPLY);
  }
  
  function transfert(uint amount, address payable recip) public payable {

      recip.transfer(msg.value);
      emit Transfer(msg.sender, recip, amount);
      
      lstRecipPayment[msg.sender].push(Payment(recip, msg.value));
      
      balance[recip] = balance[recip] + amount;
      balance[msg.sender] = balance[msg.sender] - amount;
     
  }
  
}
