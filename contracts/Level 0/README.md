# Instance - Level 0 - Introduction to Ethernaut - Work In Progress
<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level0&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>

```yml
How to play:
```

- how do we start playing/learning this game/lesson Ethernaut?

## 🆘 After using help() we get the manual 

- this manual describes some of the functions that can be used in the console of developer tools, for Ethernaut.

| (index) |	Value |
| :--: | :--: |
| player | 'current player address' |	
| ethernaut	| 'main game contract'	|
| level	| 'current level contract address'	|
| contract	| 'current level contract instance (if created)' |	
| instance	| 'current level instance contract address (if created)'	|
| version	| 'current game version'	|
| getBalance(address)	| 'gets balance of address in ether'	|
| getBlockNumber()	| 'gets current network block number'	|
| sendTransaction({options})	| 'send transaction util'	|
| getNetworkId()	| 'get ethereum network id'	|
| toWei(ether) |	'convert ether units to wei'	|
| fromWei(wei) | 	'convert wei units to ether' |

- Got it! So let's get hacking! 

## ✂️ Code Snippets and 📝 Notes

```yml
Hopefully my notes throughout are clear and easy to follow:
```
- code snippets will help show what section of the cmart contract we need to focus our attention to,

## 🔍 While on our search for more clues

```yml
According to the instructions on the Etharnaut DApp for this level we start with step 1:
```
- a [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) JavaScript await in console of the Ethernaut Instance web page in developer tools,

```JavaScript
await contract.info()
```
- here is the code snippet from the contract showing this function and what it returns,

```Solidity

  /// @notice step 1
  function info() public pure returns (string memory) {
    return 'You will find what you need in info1().'; 
  }
```

~~~yml
On to step 2:
~~~

- TODO

```Solidity
/// @notice returned from await contract.info1() step 2
  function info1() public pure returns (string memory) {
    return 'Try info2(), but with "hello" as a parameter.'; 
  }
```

- TODO



```Solidity

/// @title Ethernaut introduction, and tutorial, interact with contract abi in console to beat level
/// @author Alejandro Santander
contract Instance {

/// @notice set in memory with constructor
  string public password;

/// @notice set to false, must be true to clear instance 
  bool private cleared = false;

/// @notice returned from await contract.info() step 1
  function info() public pure returns (string memory) {
    return 'You will find what you need in info1().'; 
  }

/// @notice returned from await contract.info1() step 2
  function info1() public pure returns (string memory) {
    return 'Try info2(), but with "hello" as a parameter.'; 
  }

/// @notice returned from await contract.info2('hello') step 3, must have 'hello' as parameter
  function info2(string memory param) public pure returns (string memory) {
    if(keccak256(abi.encodePacked(param)) == keccak256(abi.encodePacked('hello'))) {  
      return 'The property infoNum holds the number of the next info method to call.'; 
    }
    return 'Wrong parameter.';
  }

/// @notice returned from await contract.infoNum() step 4
  uint8 public infoNum = 42;

/// @notice returned from await contract.info42() step 5
  function info42() public pure returns (string memory) {
    return 'theMethodName is the name of the next method.'; 
  }

/// @notice returned from await contract.theMethodName() step 6
  string public theMethodName = 'The method name is method7123949.';

/// @notice returned from await contract.method7123949() step 7
  function method7123949() public pure returns (string memory) {
    return 'If you know the password, submit it to authenticate().'; 
  }

/**  @notice password is assigned during deployment of contract in constructor,
  password found using await contract.password() returns "ethernaut0" step 8 */
  constructor(string memory _password) public {
    password = _password;
  }

/// @notice change bool from false to true using await contract.authenticate("ethernaut0") step 9
  function authenticate(string memory passkey) public {
    if(keccak256(abi.encodePacked(passkey)) == keccak256(abi.encodePacked(password))) {
      cleared = true; 
    }
  }

/** @notice click submit instance button step 10, checks if bool cleared is true in order 
  to clear level instance. */
  function getCleared() public view returns (bool) { 
    return cleared;  
  }
}

```
