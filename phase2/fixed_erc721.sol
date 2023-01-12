// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFT is ERC721Enumerable {
    uint256 price;
    bool inMinting;
    uint256 public balance;
    mapping(address=>bool) public canClaim;

    constructor(string memory tokenName, string memory tokenSymbol) ERC721(tokenName, tokenSymbol) {
        price = 1 ether;
    }

    modifier lockTheMinting {
        require(!inMinting, "Contract is minting, This function cannot be called while Minting.");
        inMinting = true;
        _;
        inMinting = false;
    }

    function deposit() public  payable{
        require(msg.value==1 ether,"INVALID_VALUE");
        balance+= msg.value;
        canClaim[msg.sender] = true;
        mint_an_nft();
        
    }

    function mint_an_nft() public lockTheMinting {
        require(canClaim[msg.sender],"CANT_MINT");
        _safeMint(msg.sender, totalSupply());
        canClaim[msg.sender] = false;
    }

 
}