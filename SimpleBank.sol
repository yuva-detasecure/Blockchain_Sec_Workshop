pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint) public balances;
    address public owner;
    
    constructor() public {
        owner = msg.sender;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient funds");
        (bool withdrawn, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(withdrawn, "Transaction failed");
        balances[msg.sender] = 0;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
}