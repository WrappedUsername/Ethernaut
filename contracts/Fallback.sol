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

import '@openzeppelin/contracts/math/SafeMath.sol'; 

/// @title Ethernaut challenge 1, assume ownership, reduce balance of contract to 0 using console
/// @author Alejandro Santander
contract Fallback {

  using SafeMath for uint256; // state variable of integers type, imported from openzeppelin
  mapping(address => uint) public contributions; /* state variable of mappings type, 
  assigned in function contribute() */ 
  address payable public owner; // state variable of address type, assigned in constructor 

  constructor() public {
    owner = msg.sender; // address deploying contract is assigned as owner
    contributions[msg.sender] = 1000 * (1 ether); // address deploying contract is paid 1000 * (1 ether)
  }

  /// @notice modifer used in function withdraw()
  modifier onlyOwner {
        require( 
            msg.sender == owner,
            "caller is not the owner"
        );
        _;
    }

  /** @notice it may be possible to brute force attack this function, but there is
  an easier attack below */
  function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if(contributions[msg.sender] > contributions[owner]) {
      owner = msg.sender;
    }
  }

  /// @notice used to check a players contribution 
  function getContribution() public view returns (uint) {
    return contributions[msg.sender];
  }

  /** @notice could use a withdraw limit, but this allows player to exploit the 
  vulnerability to withdraw all funds using await contract.withdraw() to complete this level! */
  function withdraw() public onlyOwner {
    owner.transfer(address(this).balance);
  }

  /** @notice this fallback function receive() is the main attack target, in order to pass the 
  require statement player must use function contribute() 1 wei will be enough, using the console
  player calls await contract.contribute({value: 1}), then player calls await contract.sendTransaction({value: 1}),
  player can verify ownership with await contract.owner(), player will now be able to withdraw all tokens */
  receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender; 
  }
}