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
pragma solidity ^0.6.0; 

/// @title Ethernaut introduction, and tutorial, interact with contract abi in console to beat level
/// @author Alejandro Santander
contract Instance {

  /// @notice set in memory with constructor
  string public password;
  /// @notice returned from await contract.infoNum() step 4
  uint8 public infoNum = 42; 
  /// @notice returned from await contract.theMethodName() step 6
  string public theMethodName = 'The method name is method7123949.'; 
  /// @notice set to false, must be true to clear instance 
  bool private cleared = false; 

  /**  @notice password is assigned during deployment of contract in constructor,
  password found using await contract.password() returns "ethernaut0" step 8 */
  constructor(string memory _password) public {
    password = _password;
  }
  /// @notice returned from await contract.info() step 1
  function info() public pure returns (string memory) {
    return 'You will find what you need in info1().'; 
  }
  /// @notice returned from await contract.info1() step 2
  function info1() public pure returns (string memory) {
    return 'Try info2(), but with "hello" as a parameter.'; 
  }
  /// @notice returned from await contract.info2('hello') step 3, must have 'hello' as parameter
  function info2(string memory param) public pure returns (string memory) {
    if(keccak256(abi.encodePacked(param)) == keccak256(abi.encodePacked('hello'))) {  
      return 'The property infoNum holds the number of the next info method to call.'; 
    }
    return 'Wrong parameter.';
  }
  /// @notice returned from await contract.info42() step 5
  function info42() public pure returns (string memory) {
    return 'theMethodName is the name of the next method.'; 
  }
  /// @notice returned from await contract.method7123949() step 7
  function method7123949() public pure returns (string memory) {
    return 'If you know the password, submit it to authenticate().'; 
  }
  /// @notice change bool from false to true using await contract.authenticate("ethernaut0") step 9
  function authenticate(string memory passkey) public {
    if(keccak256(abi.encodePacked(passkey)) == keccak256(abi.encodePacked(password))) {
      cleared = true; 
    }
  }
  /** @notice click submit instance button step 10, checks if bool cleared is true in order 
  to clear level instance. */
  function getCleared() public view returns (bool) { 
    return cleared;  
  }
}