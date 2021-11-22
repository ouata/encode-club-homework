//SPDX-License-Identifier: UNLICENSED


pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721URIStorage, Ownable {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

    struct MetadataToken {
        uint id;
        uint timestamps;
        string tokenURI;
        
    }
    
    //mapping (address => MetadataToken[]) public lstOwner;
    
    MetadataToken[] lstOwner;
    mapping (uint  => address) public TokenOwner;
    
    string private uri;
    
    constructor() ERC721("Volc", "vol") public {
        uri = "https://api.heroesofnft.com/token/";
    }

    function mint(address player) public onlyOwner returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        
        _mint(player, newItemId);
        _setTokenURI(newItemId, uri);
        
        lstOwner.push(MetadataToken(newItemId, block.timestamp, uri));
        TokenOwner[newItemId] = player;

        return newItemId;
    }
    
    function burnToken(uint256 id) private{
        _burn(id);
    }
    
    function delToken(uint tokenID) public {
        for (uint i=0; i < lstOwner.length ; i++) {
            if (lstOwner[i].id == tokenID) {
              require(msg.sender == TokenOwner[tokenID]);
              burnToken(tokenID);
              delete TokenOwner[tokenID];
            }
        }
    }
    
    
    function getTokenOwner(uint tokenID) public view returns(address) {
        return TokenOwner[tokenID];
    }
    
    function getListOwner() public view returns(MetadataToken[] memory) {
        return lstOwner;
    }
    
}
