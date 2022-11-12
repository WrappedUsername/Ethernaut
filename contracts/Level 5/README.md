# Token challenge - Level 5  🚧 Work In Progress 🏗

```yml
This smart contract has a vulnerability, it does not account for overflow or underflow leaving it vulnerable because:
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
  balances[msg.sender] -= _value; // <----- underflow here if 21 tokens transfered
  balances[_to] += _value;
  return true;
}
```

## 🆘 The victim contract in detail

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

- TODO

```Solidity
// public state variable of integers type, assigned in constructor
    uint public totalSupply;

    /** @notice address that deployed this contract assigns initial supply amount
    as total supply and total supply is assigned to the balance of that address */
    constructor(uint _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }
 ```
 
 - TODO

```Solidity
 /** @notice this transfer function has an overflow vulnerability that can be exploited, 
    if the player sends 21 tokens to another address it will create an overflow because the player
    only has 20 tokens and this underflow will leave the player with 2**256 - 1 tokens completing 
    this level! */
    function transfer(address _to, uint _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    /// @notice returns balance of the address that calls this function
    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }
}
```
## ⚠️ The vulnerability in detail

```yml
The vulnerability:
```

- I will demonstrate using uint8 underflow as an example below, and the best description I have found is from the hint,

- What is an odometer? According to my research an underflow or overflow is a lot like a odometer rolling over from 9999999 to 0000000, but that would be an overflow. In our situation, an underflow would be, similar to the "odometer" rolling backwards from 00000000 to 11111111.

| 0 | 0 | 0 | 0| 0| 0 | 0 | 0 |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |


- The result of a underflow, a *very* large number!

| 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |


## 💥 The attack in browser developer tools console

```yml
The attack:
```

- TODO



