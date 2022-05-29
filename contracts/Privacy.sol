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

/// @title Ethernaut challenge # 12, unlock this contract to beat the level.
/// @author Alejandro Santander
contract Privacy {

  /** @notice Public state variable of boolean value type, assigned in unlock function as false,
  player can check the current value of locked using await contract.locked() returns true. 
  Player needs to have this variable return false to beat this level. */
  /// @dev Slot 0 - 1 byte
  bool public locked = true;
  /** @notice Public state variable, special globally accessible variable for the current block time 
  when called, or in this case the block time when the contract was deployed and this block time was set in storage
  at slot 1. Player can access this block time using await contract.ID() but there is not really any need 
  to do this. */
  /// @dev Slot 1 - 32 bytes
  uint256 public ID = block.timestamp;
  /** @notice Private state variable of integer value type, assigned to storage only, this variable is not 
  used in any function or needed to attack this contract. */
  /// @dev Slot 2 - 1 byte
  uint8 private flattening = 10;
  /** @notice Private state variable of integer value type, assigned to storage only, this variable is not 
  used in any function or needed to attack this contract. */
  /// @dev Slot 2 - 1 byte
  uint8 private denomination = 255;
  /** @notice Private state variable, special globally accessible variable for the current block time converted 
  to uint16, assigned to storage only, this variable is not used in any function or needed to attack this contract. */
  /// @dev Slot 2 - 2 bytes
  uint16 private awkwardness = uint16(block.timestamp);
  /** @notice Private state variable of array reference type, assigned in constructor using three slots in storage. 
  According to the require statement in the unlock function the player will need to use the last index in the array. */
  /// @dev Slots 3, 4, and 5 - 32 bytes
  bytes32[3] private data;

  /** @notice Private state variable of array reference type is assigned in this constructor with three indexes, 
  with the values entered before the contract is deployed. */
  constructor(bytes32[3] memory _data) public {
    data = _data;
  }
  
  /** @notice Player can find the correct storage slot for index [2] in private state variable data using the console,
  web3.js storage retrieval function author - Web3 Blockchain Developer,
  let storage = []

  let callbackFNConstructor = (index) => (error, contractData) => {
    storage[index] = contractData
  }

  for(var i = 0; i < 6; i++) {
    web3.eth.getStorageAt(contract.address, i, callbackFNConstructor(i))
  }
  Player will call storage and the fifth storage slot is the third index for private state variable data, player will
  need to convert this unit32 value to unit16 to pass the require statement. See attack contract PrivacyAttack. */
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }

  /// @notice Awesome Nyan Cat ASCII art from author!
  /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}