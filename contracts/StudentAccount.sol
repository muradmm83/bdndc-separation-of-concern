pragma solidity ^0.4.24;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract StudentAccount {
    using SafeMath for uint;

    address private onlyOwner;
    AccountDataContract dataContract;

    constructor(address dataContractAddress) public {
        dataContract = AccountDataContract(dataContractAddress);
    }

    function depositToAccount() public payable {
        dataContract.deposit.value(msg.value)(msg.sender);
    }

    function withdrawFromAccount(uint amount) public {
        uint fees = amount.div(100);
        dataContract.withdraw(msg.sender, amount, fees);
    }
}

contract AccountDataContract {
    function deposit(address) external payable;
    function withdraw(address _address, uint amount, uint fees) external;
}