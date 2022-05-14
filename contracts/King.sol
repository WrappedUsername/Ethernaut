// SPDX-License-Identifier: MIT
/* 
Please use locked pragma for production to avoid SWC-103
floating pragma (i.e. ^0.8.4). 
Using a locked pragma (i.e. 0.6.0) that
has been thoroughly tested with the contract ensures
that contracts do not accidentally get deployed using, for example, 
an outdated compiler version that might introduce bugs that affect 
the contract system negatively.
*/
pragma solidity ^0.6.0;

/// @title Ethernaut challenge 9, remain king no matter what!
/// @author Alejandro Santander
contract King {

    // State variable of value type, payable address is assigned in constructor.
    address payable king;
    // Public state variable of value type, integer value is assigned in constructor.
    uint public prize;
    // Public state variable of value type, payable address is assigned in constructor.
    address payable public owner;

    /** @notice The address that deploys this contract is assigned as the owner and king,
    a value is entered before deployment, and is assigned as the prize when the contract 
    is deployed. */
    constructor() public payable {
        owner = msg.sender;  
        king = msg.sender;
        prize = msg.value;
    }

    /** @notice Player will pass the require statement with a payment greater than the 
    current prize amount. Player will find current prize amount with await contract.prize(), 
    player can use await web3.utils.fromWei('150002600', 'ether") to determine amount in 
    ether. Player will become king when calling this transaction, see attack contract KingAttack
    for description of the hack. */
    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        king.transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    // Player can call this function to determine who the king is.
    function _king() public view returns (address payable) {
        return king;
    }
}