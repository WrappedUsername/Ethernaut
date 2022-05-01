// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0; // floating pragma SWC-103, use fixed version for production i.e. 0.6.3
/* 
use locked pragma for production to avoid SWC-103
floating pragma i.e. ^0.8.4, using a locked pragma that
has been thoroughly tested with the contract ensures
that contracts do not accidentally get deployed using, for example, 
an outdated compiler version that might introduce bugs that affect 
the contract system negatively
*/
contract Instance {

  string public password; // set in memory with constructor 
  uint8 public infoNum = 42; // returned from await contract.infoNum() step 4
  string public theMethodName = 'The method name is method7123949.'; // returned from await contract.theMethodName() step 6
  bool private cleared = false; // set to false, must be true to clear instance 

  // constructor
  constructor(string memory _password) public {
    password = _password; // found using await contract.password() returns "ethernaut0" step 8
  }

  function info() public pure returns (string memory) {
    return 'You will find what you need in info1().'; // returned from await contract.info() step 1
  }

  function info1() public pure returns (string memory) {
    return 'Try info2(), but with "hello" as a parameter.'; // returned from await contract.info1() step 2
  }

  function info2(string memory param) public pure returns (string memory) {
    if(keccak256(abi.encodePacked(param)) == keccak256(abi.encodePacked('hello'))) { // must have 'hello' as parameter
      return 'The property infoNum holds the number of the next info method to call.'; // returned from await contract.info2('hello') step 3
    }
    return 'Wrong parameter.';
  }

  function info42() public pure returns (string memory) {
    return 'theMethodName is the name of the next method.'; // returned from await contract.info42() step 5
  }

  function method7123949() public pure returns (string memory) {
    return 'If you know the password, submit it to authenticate().'; // returned from await contract.method7123949() step 7
  }

  function authenticate(string memory passkey) public {
    if(keccak256(abi.encodePacked(passkey)) == keccak256(abi.encodePacked(password))) {
      cleared = true; // change bool from false to true using await contract.authenticate("ethernaut0") step 9
    }
  }

  function getCleared() public view returns (bool) { // click submit instance button step 10
    return cleared; // checks if bool cleared is true in order to clear level instance. 
  }
}