//SPDX-License-Identifier: mit
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Volcano is ERC20 {
  string private TOKEN_NAME = "Volcano";
  string private TOKEN_SYMBOL = "volc";

  uint private TOTAL_SUPPLY = 10000;

  address private _owner;
  
  modifier OnlyOwner() {
      require (msg.sender == owner);
      _;
  }
  
  event TotalSupply(uint);
  
  constructor() ERC20(TOKEN_NAME, TOKEN_SYMBOL) {
    owner = msg.sender;  
    _mint(msg.sender, TOTAL_SUPPLY);
  }


  function GetTotalSupply() public view returns (uint) {
      return TOTAL_SUPPLY;
  }

  function increaseSupply() public OnlyOwner {
    _mint(msg.sender, 1000);
    TOTAL_SUPPLY = TOTAL_SUPPLY + 1000;
    emit TotalSupply(TOTAL_SUPPLY);
  }
  
}
