// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VendingMachineV1 is Initializable {
    // State variables and their values will be preserved across upgrades
    uint256 numberOfSodas;
    address public owner;

    function initialize(uint256 _numberOfSodas) public initializer {
        numberOfSodas = _numberOfSodas;
        owner = msg.sender;
    }

    function buySoda() public payable {
        require(msg.value >= 1000 wei, "Not enough funds to buy a soda");
        numberOfSodas--;
    }
}
