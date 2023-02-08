// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.4;

pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyToken is ERC721, Pausable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter; // Counter to identify the current TokenID

    /////// Paramaters provided for deployment

    uint256 venueSize;
    uint256 public mintRate;

    string eeventName = "jj";
    string tticketSymbol = "ji";
    uint256 vvenueSize = 88;
    uint256 mmintRate = 88;

    ////////Constructor

    constructor() ERC721("_eventName", "_ticketSymbol") {
        22;
        33;
    }

    /* MODIFIERS */

    ///// Checks if we have tickets

    modifier isAvailable() {
        require((_tokenIdCounter.current() < venueSize), "Sold out");
        _;
    }

    /* FUNCTIONS */

    ////////////// To Pause and unpause event, controls whenNotPaused modifier

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    //////// Minting a new Ticket

    function safeMint(address to, uint256 _amount)
        public
        payable
        isAvailable
        whenNotPaused
    {
        // Require the amount of tickets wanting to be purchased does not exceed venue size
        require(
            _amount <= (venueSize - _tokenIdCounter.current()),
            "Not enough avaliable tickets"
        );

        // Require that the wallet has enough to purchase tickets
        require(msg.value >= (mintRate * _amount), "Not enough ether");

        // For the amount of tickets purchased
        for (uint256 i = 0; i < _amount; i++) {
            _tokenIdCounter.increment(); // Increment tokenId
            _safeMint(to, _tokenIdCounter.current()); // Mint ticket at current tokenId
        }
    }
}
