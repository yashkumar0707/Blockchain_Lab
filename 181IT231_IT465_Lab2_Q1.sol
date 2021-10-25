pragma solidity ^0.5.10;
contract Crowdfunding
{
address owner;
uint256 goal;
uint256 deadline;
mapping(address => uint256) public paid;
constructor(uint256 numberOfSeconds, uint256 Goal) public
{
owner = msg.sender;
deadline = now + (numberOfSeconds * 1 seconds);
goal = Goal;
}
function fund() public payable
{
require(now < deadline,"Deadline has been passed");
uint256 amount = msg.value;
paid[msg.sender] += amount;
}
function GoalReached() public {
require(address(this).balance >= goal,"The funding goal has not been met");
require(now >= deadline,"Deadline has not been passed");
require(msg.sender == owner,"Only the owner of the contract can claim the funds");
msg.sender.transfer(address(this).balance);
}
function getRefund() public
{
require(address(this).balance < goal,"The goal has been met. Refund not possible");
require(now >= deadline,"The deadline has not yet been passed.");
uint256 amount = paid[msg.sender];
require(amount>0 ,"No funds to refund.");
paid[msg.sender] = 0;
msg.sender.transfer(amount);
}
function checkBalance() public view returns(uint256)
{
return address(this).balance;
}
function checkDeadline() public view returns(uint256)
{
if(now>=deadline)
{
return 0;
}
else
{
return deadline - now;
}
}
}