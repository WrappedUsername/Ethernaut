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

/// @title Ethernaut challenge 2, assume ownership using console 
/// @author Alejandro Santander
contract Fallout {
  
  using SafeMath for uint256; // state variable of integers type, imported from openzeppelin
  mapping (address => uint) allocations; /* state variable of mappings type, 
  assigned in function allocate() */ 
  address payable public owner; /* state variable of address type, 
  assigned in flawed constructor below */


  /** @notice this is the vulnerability to be exploited during the attack,
  using constructor is the best practice to avoid this vulnerability,
  function fal1out does not match contract name making it a public function, to 
  attack assume ownership player calls await contract.fal1out() to complete this level */
  function Fal1out() public payable {
    owner = msg.sender;
    allocations[owner] = msg.value;
  }
  
  /// @notice modifer used in function collectAllocations()
  modifier onlyOwner {
	        require(
	            msg.sender == owner,
	            "caller is not the owner"
	        );
	        _;
	    }

  function allocate() public payable {
    allocations[msg.sender] = allocations[msg.sender].add(msg.value);
  }

  function sendAllocation(address payable allocator) public {
    require(allocations[allocator] > 0);
    allocator.transfer(allocations[allocator]);
  }
  
  /** @notice could use a withdraw limit, as is this could transfer all 
  allocations in one transaction */
  function collectAllocations() public onlyOwner {
    msg.sender.transfer(address(this).balance);
  }

  function allocatorBalance(address allocator) public view returns (uint) {
    return allocations[allocator];
  }
}
  