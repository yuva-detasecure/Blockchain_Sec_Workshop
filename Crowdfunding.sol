pragma solidity ^0.7.0;

contract CrowdFunding {
    address public owner;
    uint public balance;

    constructor() public {
        owner = msg.sender;
        balance = 0;
    }

    function deposit() public payable {
        require(msg.value > 0, "Cannot deposit 0 or negative value");
        balance += msg.value;
    }

    function withdraw(uint amount) public {
        require(amount > 0, "Cannot withdraw 0 or negative value");
        require(amount <= balance, "Cannot withdraw more than current balance");
        msg.sender.transfer(amount);
        balance -= amount;
    }

    function selfDestruct() public {
        require(msg.sender == owner, "Only owner can self-destruct contract");
        selfdestruct(payable(owner));
    }
}
