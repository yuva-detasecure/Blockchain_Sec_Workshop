pragma solidity 0.8.17;

contract Bank {

    mapping(address => uint256) balance_;

    constructor() payable {
        
    }

    function deposit() public  payable{
        require(msg.value > 0,"Amount should not be zero");
        balance_[msg.sender] += msg.value;

        
    }

    function withdraw() public {
        uint bal = balance_[msg.sender];
        require(bal > 0);

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balance_[msg.sender] = 0;

    }

    receive() external payable{

    }
    

    

    function checkBalance() public view returns(uint256){
        return balance_[msg.sender];
    }

    function contractbalance() public view returns(uint256){
        return address(this).balance;
    }
}