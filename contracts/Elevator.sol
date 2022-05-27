// SPDX-License-Identifier: MIT
/** @custom:dev
Please use locked pragma for production to avoid SWC-103
floating pragma (i.e. ^0.8.4). 
Using a locked pragma (i.e. 0.6.0) that
has been thoroughly tested with the contract ensures
that contracts do not accidentally get deployed using, for example, 
an outdated compiler version that might introduce bugs that affect 
the contract system negatively.
*/
pragma solidity ^0.8.0;

/// @notice Player will use this "building" interface for the "elevator".
interface Building {
  /** @notice Player will be able to change the state of this interface 
  function because it has an external visibilty specifier only, player will enter an 
  unsigned integer and return a boolean value of false, then true. */
  function isLastFloor(uint) external returns (bool);
}

/// @title Ethernaut challenge # 11, go to the top of the building!
/// @author Martin Triay
contract Elevator {
  /** @notice Public state variable of boolean value type, assigned 
  in function goTo() using function isLastFloor() from interface Building. 
  Player can check current value for top using await contract.top(),
  will return false, but player needs top to return a true value. */
  bool public top;
  /** @notice Public state variable of integer value type, player will enter 
  a value using function goTo() and that will be assigned as floor. Player
  can check current floor using await contract.floor(), will return 0, but
  player will need to set a floor value as the top. */
  uint public floor;

  /** @notice Player will call goTo function using the Building interface. 
  Player will set floor and toggle the boolean for building.isLastFloor(floor),
  this will intiate the attack to indicate public state variable top as false to 
  pass the if statement, this will allow the player to set the floor as top is true. 
  See attack contract ElevatorAttack. */
  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}