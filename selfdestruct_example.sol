pragma solidity 0.8.17;

contract VulnerableCode {
  
  address owner;
  
  constructor() payable {
	owner = msg.sender;    
  }
  
 function doSomething() public {
   
   //Extra code here  
 }
  
 function self_destruct(address _to) external onlyOwner {
   
   selfdestruct(payable(_to));
 } 

 function check_address() public view  returns(address){
     return address(this);
 } 
  
 modifier onlyOwner(){
   
   require(msg.sender==owner, "You are not the owner");
   _;
   
 }

}