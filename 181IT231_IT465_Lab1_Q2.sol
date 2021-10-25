pragma solidity ^0.5.10;

contract BankContract {

    mapping (address => uint) private balance;

    function deposit() public payable returns (uint) {
        balance[msg.sender] += msg.value;
        return balance[msg.sender];
    }


    function withdraw(uint withdraw_amount) public returns (uint) {
        if (withdraw_amount <= balance[msg.sender]) {
            balance[msg.sender] -= withdraw_amount;
            msg.sender.transfer(withdraw_amount);
        }
        return balance[msg.sender];
    }

    function remaining_balance() public view returns (uint) {
        return balance[msg.sender];
    }

}