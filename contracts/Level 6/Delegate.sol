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

/// @title Ethernaut challenge 6, assume ownership 
/// @author Alejandro Santander
contract Delegate {

    // public state variable assigned in constructor
    address public owner;

    /// @notice address entered into constructor is assigned as the owner 
    constructor(address _owner) public {
        owner = _owner;
    }

    /** @notice player will call this function using a variable of the function signature in console
    from the fallback function within Delegation contract using delegatecall to reassign the 
    public state variable owner inside the Delegation contract, 
    player will assign the variable in console var pwnFuncSignature = web3.utils.sha3("pwn()"), 
    player will use the delegatecall in the fallback function with pwnFuncSignature as the msg.data, 
    using contract.sendTransaction({data: pwnFuncSignature}) */
    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {

    // public state variable assigned in constructor
    address public owner;
    // state variable assigned in constructor
    Delegate delegate;
    
    /** @notice address entered into constructor is assigned as delegate state variable
    representing Delegate contract and msg.sender is assigned as owner */
    constructor(address _delegateAddress) public {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    /** this fallback function contains delegatecall allowing the player to call a function 
    from another contract, player will call pwn() function from Delegate contract to reassign 
    ownership of this contract */
    fallback() external {
        (bool result,) = address(delegate).delegatecall(msg.data);
        if (result) {
        this;
        }
    }
}