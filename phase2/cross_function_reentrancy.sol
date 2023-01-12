pragma solidity 0.8.9;

contract Cross_function{

    mapping(address=>uint256) public balances;

    function deposit() public  payable{
        require(msg.value > 0,"Amount should not be zero");
        balances[msg.sender] += msg.value;
    }

    function transfer(address to, uint amount) external  {
      amount=amount * 1e18;
      if (balances[msg.sender] >= amount) {
        payable(to).send(amount);
        // balances[to] += amount;
        // balances[msg.sender] -= amount;
      
  }
    }

  
  function withdraw2() public {
          uint bal = balances[msg.sender];
          require(bal > 0);

          (bool sent, ) = msg.sender.call{value: bal}("");
          require(sent, "Failed to send Ether");

          balances[msg.sender] = 0;

      }

  receive() external payable{

    }


function checkBalance() public view returns(uint256){
          return balances[msg.sender];
      }
}