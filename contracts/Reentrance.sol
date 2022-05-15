// SPDX-License-Identifier: MIT
/* 
Please use locked pragma for production to avoid SWC-103
floating pragma (i.e. ^0.8.4). 
Using a locked pragma (i.e. 0.6.0) that
has been thoroughly tested with the contract ensures
that contracts do not accidentally get deployed using, for example, 
an outdated compiler version that might introduce bugs that affect 
the contract system negatively.
*/
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

/// @title Ethernaut challenge 10, hack contract and steal all the funds!
/// @author Alejandro Santander
contract Reentrance {
  
  // State variable of integers type, imported from openzeppelin.
  using SafeMath for uint256;
  /* Public state variable of mappings type, assigned in function donate each address will
  show the amount of tokens they own as their balance. */
  mapping(address => uint) public balances;

  /// @notice Allows players to donate funds to this contract.
  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  /// @notice Allows players to check the balance of an address.
  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  /** @notice Player will be able to use a re-entrancy attack after donating funds to this
  victim contract to pass the if statement. Player will create an attack contract that has a 
  recursive fallback function that exploits this vulnerable withdraw function. 
  See attack contract ReentrancyAttack. To avoid re-entrancy, use the Checks-Effects-Interactions 
  pattern. */
  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  /// @notice Fallback function
  receive() external payable {}
}