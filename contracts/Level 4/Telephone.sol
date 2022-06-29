// SPDX-License-Identifier: MIT
/* 
use locked pragma for production to avoid SWC-103
floating pragma i.e. ^0.8.4, using a locked pragma that
has been thoroughly tested with the contract ensures
that contracts do not accidentally get deployed using, for example, 
an outdated compiler version that might introduce bugs that affect 
the contract system negatively
*/
// floating pragma SWC-103, use fixed version for production i.e. 0.6.0
pragma solidity ^0.6.0;

/// @title Ethernaut challenge 4, assume ownership 
/// @author Kyle Riley
contract Telephone {

  // public state variable assigned in constructor
  address public owner;

  // constructor sets owner to address that created contract
  constructor() public {
    owner = msg.sender;
  }

  /** @notice function changeOwner() uses tx.origin to change ownership 
  to whatever address calls this function just as long as it is not the 
  address that started the original transaction that created this contract */
  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}