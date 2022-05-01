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

  using SafeMath for uint256; // state variable of intergers type, imported from openzeppelin
  mapping(address => uint) public contributions; /* state variable of mappings type, 
  assigned in function contribute() */ 
  address payable public owner; // state variable of address type, assigned in constructor 

  constructor() public {
    owner = msg.sender; // address deploying contract is assigned as owner
    contributions[msg.sender] = 1000 * (1 ether); // address deploying contract is paid 1000 * (1 ether)
  }

  // modifer used in function withdraw()
  modifier onlyOwner {
        require( 
            msg.sender == owner,
            "caller is not the owner"
        );
        _;
    }

  function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if(contributions[msg.sender] > contributions[owner]) {
      owner = msg.sender;
    }
  }

  function getContribution() public view returns (uint) {
    return contributions[msg.sender];
  }

  function withdraw() public onlyOwner {
    owner.transfer(address(this).balance);
  }

  receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
}