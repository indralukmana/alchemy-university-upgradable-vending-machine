// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VendingMachineV2 is Initializable {
    // State variables and their values will be preserved across upgrades
    uint256 numberOfSodas;
    address public owner;
    mapping(address => uint) public purchases;

    function initialize(uint256 _numberOfSodas) public initializer {
        numberOfSodas = _numberOfSodas;
        owner = msg.sender;
    }

    function buySoda() public payable {
        require(numberOfSodas > 0, "No more sodas left");
        require(msg.value >= 1000 wei, "Not enough funds to buy a soda");
        numberOfSodas--;

        purchases[msg.sender]++;
    }

    function addSoda(uint256 _numberOfSodas) public onlyOwner {
        numberOfSodas += _numberOfSodas;
    }

    function getNumberOfSodas() public view returns (uint256) {
        return numberOfSodas;
    }

    function withdrawProfits() public onlyOwner {
        require(msg.sender == owner, "Only the owner can withdraw profits");
        payable(owner).transfer(address(this).balance);
    }

    function setNewOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}
