//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
//pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
/**
 * @title Minter contract
 * @dev Extends ERC721Enumerable Non-Fungible Token Standard
 */
contract Minter is ERC721, Ownable {
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    // Contract global variables.
    uint public constant mintPrice = 0.01 ether;
    //uint256 public constant mintPrice = 10000000000000000; // 0.01 ETH.
    uint256 public constant maxMint = 5;
    uint256 public MAX_TOKENS = 10000;

    Counters.Counter private _tokenIds;
    string public baseTokenURI;
    // Name token using inherited ERC721 constructor.
    //constructor() ERC721("Minter", "MINTER") {}

    constructor(string memory baseURI) ERC721("Minter", "MINTER") {
        setBaseURI(baseURI);
    }

    function reserveNFTs() public onlyOwner {
        uint totalMinted = _tokenIds.current();

        require(totalMinted.add(10) < MAX_TOKENS, "Not enough NFTs left to reserve");

        for (uint i = 0; i < 10; i++) {
            _mintSingleNFT();
        }
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function setBaseURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    /////////////////////////////////////////////////////////////////////

    function mintNFTs(uint _count) public payable {
        uint totalMinted = _tokenIds.current();
        // Number of tokens can't be 0.
        require(_count != 0, "You need to mint at least 1 token");
        // Check that the number of tokens requested doesn't exceed the max. allowed.
        require(_count <= maxMint, "You can only mint 5 tokens at a time");
        require(totalMinted.add(_count) <= MAX_TOKENS, "Not enough NFTs left!");
        require(_count >0 && _count <= maxMint, "Cannot mint specified number of NFTs.");
        require(msg.value >= mintPrice.mul(_count), "Not enough ether to purchase NFTs.");
        require(balanceOf(msg.sender) == 0, "Mint only once for each wallet.");

        for (uint i = 0; i < _count; i++) {
            _mintSingleNFT();
        }
    }

    function _mintSingleNFT() private {
        uint newTokenID = _tokenIds.current();
        _safeMint(msg.sender, newTokenID);
        _tokenIds.increment();
    }

    /*function tokensOfOwner(address _owner) external view returns (uint[] memory) {

        uint tokenCount = balanceOf(_owner);
        uint[] memory tokensId = new uint256[](tokenCount);

        for (uint i = 0; i < tokenCount; i++) {
            tokensId[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokensId;
    }*/

    function withdraw() public payable onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No ether left to withdraw");

        (bool success, ) = (msg.sender).call{value: balance}("");
        require(success, "Transfer failed.");
    }

    // The main token minting function (recieves Ether).
    /*function mint(uint256 numberOfTokens) public payable {
        // Number of tokens can't be 0.
        require(numberOfTokens != 0, "You need to mint at least 1 token");
        // Check that the number of tokens requested doesn't exceed the max. allowed.
        require(numberOfTokens <= maxMint, "You can only mint 10 tokens at a time");
        // Check that the number of tokens requested wouldn't exceed what's left.
        require(totalSupply().add(numberOfTokens) <= MAX_TOKENS, "Minting would exceed max. supply");
        // Check that the right amount of Ether was sent.
        require(mintPrice.mul(numberOfTokens) <= msg.value, "Not enough Ether sent.");

        // For each token requested, mint one.
        for(uint256 i = 0; i < numberOfTokens; i++) {
            uint256 mintIndex = totalSupply();
            if(mintIndex < MAX_TOKENS) {
                 
                 // Mint token using inherited ERC721 function
                 // msg.sender is the wallet address of mint requester
                 // mintIndex is used for the tokenId (must be unique)
                 
                _safeMint(msg.sender, mintIndex);
            }
        }
    }*/

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}