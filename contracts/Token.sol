// SPDX-License-Identifier: MIT
/* 
use locked pragma for production to avoid SWC-103
floating pragma i.e. ^0.8.4, using a locked pragma i.e. 0.6.0 that
has been thoroughly tested with the contract ensures
that contracts do not accidentally get deployed using, for example, 
an outdated compiler version that might introduce bugs that affect 
the contract system negatively
*/
pragma solidity ^0.6.0;

/// @title Ethernaut challenge 5, hack contract steal as many tokens as you can 
/// @author Alejandro Santander
contract Token {

    /* state variable of mappings type, assigned in constructor each address will
    show the amount of tokens they own as their balance */
    mapping(address => uint) balances;
    // public state variable of integers type, assigned in constructor
    uint public totalSupply;

    /** @notice address that deployed this contract assigns initial supply amount
    as total supply and total supply is assigned to the balance of that address */
    constructor(uint _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    /** @notice this transfer function has an underflow vulnerability that can be exploited, 
    if the player sends 21 tokens to another address it will create an underflow because the player
    only has 20 tokens and this underflow will leave the player with 2**256 - 1 tokens completing 
    this level! */
    function transfer(address _to, uint _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    /// @notice returns balance of the address that calls this function
    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }
}