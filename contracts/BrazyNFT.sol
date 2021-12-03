// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// Import OpenZepplin contracts
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// Inherit contract imported from OpenZepplin,
// giving BrazyNFT inherited contract methods
contract BrazyNFT is ERC721URIStorage {
    // Counter from openzepplin to keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // baseSvg variable that all NFTs can use
    // Dynamic, can change words being displayed
    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><rect width='100%' height='100%'/><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' style='fill:#fff;font-family:serif;font-size:14px'>";

    // Three string arrays that will be used for svg content
    string[] firstWords = [
        "Naruto",
        "Kakashi",
        "Sotoglo",
        "Biju",
        "TenTails",
        "Seahorse"
    ];
    string[] secondWords = [
        "Shamuri",
        "Sand",
        "Dave",
        "9Tails",
        "8Tails",
        "WTF"
    ];
    string[] thirdWords = [
        "Reniggan",
        "Goku",
        "Vegeta",
        "Sasulri",
        "Biakugan",
        "BlueEyes"
    ];

    // Pass in NFTs token and symbol
    constructor() ERC721("COWNFT", "MOOOO") {
        console.log("Hello from smart contact");
    }

    // Functions to randomly pick a word from string array
    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // seed random generator
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        // Remove # between 0 and the length of the array to avoid going out of bounds.
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // When invoked, creates NFT for user
    function makeABrazyNFT() public {
        // Get current tokenId
        uint256 newItemId = _tokenIds.current();

        // Get one word for each of three arrays.
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);

        // Use concatenation to create final svg
        string memory finalSvg = string(
            abi.encodePacked(baseSvg, first, second, third, "</text></svg>")
        );

        console.log("n------------------");
        console.log(finalSvg);
        console.log("-------------------\n");

        // Mint NFT to sender
        _safeMint(msg.sender, newItemId);

        // Set NFT data
        _setTokenURI(newItemId, "blah");

        // Increment counter to allow next NFT to be minted
        _tokenIds.increment();

        console.log(
            "An NFT w/ ID %s has beed minted to %s",
            newItemId,
            msg.sender
        );
    }
}
