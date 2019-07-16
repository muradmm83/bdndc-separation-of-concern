pragma solidity ^0.4.24;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract StudentAccount {
    using SafeMath for uint;

    bool isOperational = true;
    address _owner;

    AccountDataContract dataContract;
    

    modifier operational() {
        require(isOperational);
        _;
    }

    modifier isOwner() {
        require(msg.sender == _owner);
        _;
    }

    constructor(address dataContractAddress) public {
        dataContract = AccountDataContract(dataContractAddress);
        _owner = msg.sender;
    }

    function setOperational(bool status) public isOwner {
        isOperational = status;
    }
    
    function depositToAccount() public payable operational  {
        dataContract.deposit.value(msg.value)(msg.sender);
    }

    function withdrawFromAccount(uint amount) public operational {
        uint fees = amount.div(100);
        dataContract.withdraw(msg.sender, amount, fees);
    }    
}

contract AccountDataContract {
    function deposit(address) external payable;
    function withdraw(address _address, uint amount, uint fees) external;
}