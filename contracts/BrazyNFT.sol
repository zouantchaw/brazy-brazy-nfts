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
    constructor() ERC721("COWNFT", "MOOOO") {
        console.log("Hello from smart contact");
    }

    // When invoked, creates NFT for user
    function makeABrazyNFT() public {
        // Get current tokenId
        uint256 newItemId = _tokenIds.current();

        // Mint NFT to sender
        _safeMint(msg.sender, newItemId);

        // Set NFT data
        _setTokenURI(
            newItemId,
            "data:application/json;base64,ewogICAgIm5hbWUiOiAiR290IE1pbGsiLAogICAgImRlc2NyaXB0aW9uIjogIkdvdCBNaWxrIFByb2R1Y3Rpb25zLi4uIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0OGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaTgrUEhSbGVIUWdlRDBpTlRBbElpQjVQU0kxTUNVaUlHUnZiV2x1WVc1MExXSmhjMlZzYVc1bFBTSnRhV1JrYkdVaUlIUmxlSFF0WVc1amFHOXlQU0p0YVdSa2JHVWlJSE4wZVd4bFBTSm1hV3hzT2lObVptWTdabTl1ZEMxbVlXMXBiSGs2YzJWeWFXWTdabTl1ZEMxemFYcGxPakUwY0hnaVBrZHZkRTFwYkdzOEwzUmxlSFErUEM5emRtYysiCn0="
        );

        console.log(
            "An NFT w/ ID %s has beed minted to %s",
            newItemId,
            msg.sender
        );

        // Increment counter to allow next NFT to be minted
        _tokenIds.increment();
    }
}
