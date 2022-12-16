pragma solidity 0.8.17;

contract AccessControl {

//Totalsupply is zero as of now
    uint256 public totalsupply;

    mapping(address => uint256) balance_;
    address owner;
    constructor() {
       owner = msg.sender;
    }

    function mint(uint256 _token) public {
        //Everytime someone mints a token it will be added to the totalsupply
        totalsupply += _token;
        balance_[msg.sender] += _token;
   
    }

    function burn(address toAddress, uint256 _token) public{
        totalsupply -= _token;
        balance_[toAddress] -= _token;


    }

    //custom function not openzeppelin's function
    function transfer(address to, uint256 tokens) public {
        balance_[msg.sender] -= tokens;
        balance_[to] += tokens;

    }

    function totalSupply() public view returns(uint256){
        return totalsupply;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    
}