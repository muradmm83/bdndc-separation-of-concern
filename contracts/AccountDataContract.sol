pragma solidity ^0.4.24;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract AccountDataContract {
    using SafeMath for uint;

    address private owner;
    mapping(address => uint) accounts;

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner is allowed");
        _;
    }

    modifier enoughBalance(address _address, uint amount) {
        require(accounts[_address] > amount, "balance is not enought");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function getBalance() public view returns(uint) {
        return accounts[msg.sender];
    }

    function deposit(address _address) external payable  {
        accounts[_address] = accounts[_address].add(msg.value);
    }

    function withdraw(address _address, uint amount, uint fees) external enoughBalance(_address, amount) {
        accounts[_address] = accounts[_address].sub(amount).sub(fees);
        _address.transfer(amount);
    }
}