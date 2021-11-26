// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// Import OpenZepplin contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// Inherit contract imported from OpenZepplin,
// giving BrazyNFT inherited contract methods
contract BrazyNFT is ERC721URIStorage {
    // Counter from openzepplin to keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Pass in NFTs token and symbol
    constructor() ERC721("CircleNFT", "CIRCLE") {
        console.log("Hello from smart contact");
    }

    // When invoked, creates NFT for user
    function makeABrazyNFT() public {
        // Get current tokenId
        uint256 newItemId = _tokenIds.current();

        // Mint NFT to sender
        _safeMint(msg.sender, newItemId);

        // Set NFT data
        _setTokenURI(newItemId, "Hello Hello");

        // Increment counter to allow next NFT to be minted
        _tokenIds.increment();
    }
}
