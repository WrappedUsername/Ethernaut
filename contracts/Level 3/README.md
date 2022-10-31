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
function flip(bool _guess) public returns (bool) {
  // local variable blockValue is assigned using the uint256 integer from the hash of the last block number 
  uint256 blockValue = uint256(blockhash(block.number.sub(1))); 
```
