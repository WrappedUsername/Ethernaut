# Fallout challenge - Level 2
```yml
This challenge is more about best practices and how using a constructor is the best practice because:
```
- using a constructor prevents slight mistakes from becoming critical vulnerabilities
  - in this challenge a spelling error creates a critical vulnerabilitiy, the author should have used a constructor instead of a function

```Solidity

/** @notice this is the vulnerability to be exploited during the attack,
  using constructor is the best practice to avoid this vulnerability,
  function fal1out does not match contract name making it a public function, to 
  attack and assume ownership player calls await contract.fal1out() to complete this level */
  function Fal1out() public payable {
    owner = msg.sender;
    allocations[owner] = msg.value;
  }
  
  ```
