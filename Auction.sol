pragma solidity ^0.8.0;

contract Auction {
    address public owner;
    mapping (string => Item) public items;
    mapping (address => bool) public whitelist;

    struct Item {
        uint auctionEndTime;
        address highestBidder;
        uint highestBid;
        string name;
    }

    constructor() public {
        owner = msg.sender;
    }

    function addItem(string memory _itemName) public {
        require(items[_itemName].auctionEndTime == 0);
        items[_itemName] = Item(block.timestamp + 7 days, address(0), 0, _itemName);
    }

    function addToWhitelist(address _user) public {
        whitelist[_user] = true;
    }

    function bid(string memory _itemName) public payable {
        uint _bid = msg.value;
        require(whitelist[msg.sender], "User is not in whitelist");
        require(_bid > items[_itemName].highestBid && block.timestamp < items[_itemName].auctionEndTime, "Invalid bid");

        if (items[_itemName].highestBidder != address(0)) {
            payable(items[_itemName].highestBidder).transfer(items[_itemName].highestBid);
        }
        items[_itemName].highestBidder = msg.sender;
        items[_itemName].highestBid = _bid;
    }

    function endAuctionForItem(string memory _itemName) public {
        require(block.timestamp >= items[_itemName].auctionEndTime && items[_itemName].highestBidder != address(0));
        payable(owner).transfer(items[_itemName].highestBid);
    }

    function getCurrentBid(string memory _itemName) public view returns (uint) {
        return items[_itemName].highestBid;
    }

    function getTimeRemaining(string memory _itemName) public view returns (uint) {
        return items[_itemName].auctionEndTime - block.timestamp;
    }

    function endContract() public{
        selfdestruct(payable(msg.sender));
    }    
    
}