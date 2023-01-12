pragma solidity 0.8.13;

contract Game{

    uint256 contractBalance = address(this).balance;
    uint256 rewardAmount;
    mapping(address => uint256) balance_;

    constructor() payable {
       // rewardAmount=10 ether;

    }


    function deposit() external payable{
        require(msg.value > 0,"Amount should not be zero");
        contractBalance += msg.value;

    }



    function withdraw(uint256 amount) external { 
        (bool sent, ) = msg.sender.call{value: amount *1e18}("");
        require(sent, "Failed to send Ether");
        

    }

    
    function transferto(address to, uint256 amount) external{

    }

    function balanceOf() public view returns(uint256){
        return balance_[msg.sender];
    }

    function contractbalance() public view returns(uint256){
        return address(this).balance;
    }
}