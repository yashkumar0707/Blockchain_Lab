pragma solidity ^0.5.10;
contract SmartContract{
    uint monthlyfee;
    constructor(uint _monthlyfee) public {
        monthlyfee = _monthlyfee;
    }

    function payment_to_company() payable public {
    }
    function withdraw_fund() public {
        msg.sender.transfer(address(this).balance);
    }

    function acct_status(uint months) public view returns (bool) {
        return months * monthlyfee == address(this).balance;
    }
    
}