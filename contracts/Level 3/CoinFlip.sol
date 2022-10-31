// SPDX-License-Identifier: MIT
/* 
use locked pragma for production to avoid SWC-103
floating pragma i.e. ^0.8.4, using a locked pragma that
has been thoroughly tested with the contract ensures
that contracts do not accidentally get deployed using, for example, 
an outdated compiler version that might introduce bugs that affect 
the contract system negatively
*/
pragma solidity ^0.5.0; // floating pragma SWC-103, use fixed version for production i.e. 0.5.0

// outdated import for SafeMath, pragma 0.8.0 has SafeMath included in version
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.0/contracts/math/SafeMath.sol";

/// @title Ethernaut challenge 3, guess correct side 10 times in a row
/// @author Kyle Riley
contract CoinFlip {

  /** @notice Using for directive, using imported SafeMath functions from openzeppelin
  for unit256 to prevent overflow and underflow attacks. */
  using SafeMath for uint256; 
  // state variable assigned in constructor 
  uint256 public consecutiveWins; 
  // state variable assigned in function flip()
  uint256 lastHash; 
  // state variable assigned in function flip()
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  /// @notice constructor sets wins to zero
  constructor() public {
    consecutiveWins = 0;
  }

  /// @notice The attack contract can use the same process as the victim contract to find the value for the flip.
  function flip(bool _guess) public returns (bool) {
    /** custom:notice blockhash and block.number are globally accessible variables available to everyone 
    this is the source of randomness and can be exploited in the attack to calculate the correct side of the coin flip
    best practice to introduce a source of randomness into a contract would be to use a decentralized oracle to compute 
    random numbers, because there is no native way to generate random numbers in Solidity and everything is
    publicly visible in the contract */ 
    /* local variable blockValue is assigned 
    using the uint256 integer from the hash of the last block number */
    uint256 blockValue = uint256(blockhash(block.number.sub(1))); 

    // ensures lastHash is a unique value, if not, it will revert transaction
    if (lastHash == blockValue) {
      revert();
    }

    /* if lastHash is found to be unique state variable lastHash 
    is assigned as the local variable blockValue */
    lastHash = blockValue; 
    /** @custom:notice local variable coinFlip assigned using the local variable blockValue 
    divided by the state variable FACTOR */
    uint256 coinFlip = blockValue.div(FACTOR); 
    /** @custom:notice local variable side is assigned as a correct _guess if 
    coinFlip is equal to 1 and is declared as true */ 
    bool side = coinFlip == 1 ? true : false;

    /* if side is equal to true it is entered as a correct _guess and consecutiveWins 
    is incremented by 1 and returns true */
    if (side == _guess) {
      consecutiveWins++;
      return true;
    // if side is not equal to true, consecutiveWins is set to zero, returns false
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}
