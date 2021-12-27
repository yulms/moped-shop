// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

contract mopedShop {
    address public owner;
    address public shopAddress;
    uint256 public price = 2 ether;
    mapping (address => bool) buyers;

    constructor() {
        owner = msg.sender;
        shopAddress = address(this);
    }

    function getBalance() public view returns(uint) {
        return shopAddress.balance;
    }

    function addBuyer(address _addr) public {
        require(msg.sender == owner, 'Not an owner');
        buyers[_addr] = true;
    }

    function getBuyer(address _addr) public view returns(bool) {
        // 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
        // 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 buyer
        // 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC not a buyer
        require(msg.sender == owner, 'Not an owner');
        return buyers[_addr]; 
    }

    receive() external payable {
        require(buyers[msg.sender] && msg.value <= price, 'Rejected');
    }

    function withdrawAll() public {
        require(msg.sender == owner, 'Not an owner');

        address payable receiveAddress = payable(owner);
        receiveAddress.transfer(shopAddress.balance);
    }
}