// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title Our NFT contract
 */
contract MyNFT is ERC721, Ownable {
  // use Counters library
  using Counters for Counters.Counter;
  
  // max supply is 10k items
  uint256 public constant TOTAL_SUPPLY = 10000;

  // token counter
  Counters.Counter private currentTokenId;

  // base token URI for metadata
  string public baseTokenURI;

  /**
   * Contract constructor
   */
  constructor() ERC721("My NFT dogs", "NFTDGS") {
    baseTokenURI = "";
  }

  /**
   * @dev Mints a new token to recipient address
   * @param recipient new token owner address
   * @return tokenId minted token id
   */
  function mintTo(address recipient) public onlyOwner returns (uint256) {
    // check that max supply is not reached
    uint256 tokenId = currentTokenId.current();
    require(tokenId < TOTAL_SUPPLY, "Max supply reached");
    // increase current token count and mint it to a new owner
    currentTokenId.increment();
    uint256 newItemId = currentTokenId.current();
    _safeMint(recipient, newItemId);
    return newItemId;
  }

  /**
   * @dev Sets base token URI
   * @param _baseTokenURI base token URI
   */
  function setBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
    baseTokenURI = _baseTokenURI;
  }

  /**
   * @dev Returns base token URL
   * @return baseTokenURI base token URI 
   */
  function _baseURI() internal virtual override view returns (string memory) {
    return baseTokenURI;
  }
}
