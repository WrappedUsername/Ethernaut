# Token challenge - Level 5 

```yml
This smart contract has a vulnerability, it does not account for overflow and underflow leaving it vulnerable because:
```

- this transfer function allows for unsafe math operations resulting in an underflow vulnerability,

```Solidity
/** 
* @notice this transfer function has an underflow vulnerability that can be exploited, 
* if the player sends 21 tokens to another address it will create an underflow because the player
* only has 20 tokens and this underflow will leave the player with 2**256 - 1 tokens completing 
* this level! 
*/
function transfer(address _to, uint _value) public returns (bool) {
  require(balances[msg.sender] - _value >= 0);
  balances[msg.sender] -= _value;
  balances[_to] += _value;
  return true;
}
```

🆘 The victim contract in detail

```yml
The victim contract should use the OpenZeppelin safeMath library:
```
- without the safeMath library overflow/underflow vulnerabilities remain, 

```Solidity

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

/// @title Ethernaut challenge 5, hack contract steal as many tokens as you can 
/// @author Alejandro Santander
contract Token {
  /* 
  * state variable of mappings type, assigned in constructor each address will
  * show the amount of tokens they own as their balance 
  */
  mapping(address => uint) balances;
```



