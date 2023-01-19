// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract PrimitiveBank {

    uint8 public balance; //Overall balance in the bank
    mapping(address => uint8) public deposits;

    event Deposit(address indexed _from, uint8 _value);
    event Withdrawal(address indexed _to, uint8 _value);

    constructor() public {
        balance = 0;
    }

    function deposit() public payable {
        require(msg.value > 0, "Cannot deposit 0 or negative value");
        balance += uint8(msg.value);
        deposits[msg.sender] += uint8(msg.value);
        emit Deposit(msg.sender, uint8(msg.value));
    }

    function withdraw(uint8 _amount) public {
        require(_amount <= balance, "Insufficient balance");
        balance -= _amount;
        msg.sender.transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }

    function amountDeposited(address _account) public view returns (uint8) {
        return deposits[_account];
    }
}
