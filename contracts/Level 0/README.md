# Instance - Level 0 - Introduction to Ethernaut
<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level0&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>

```yml
How to play:
```

- How do we start playing/learning this game/lesson Ethernaut?

## 🆘 After using help() we get the manual 

- This manual describes some of the functions that can be used in the console of developer tools, for Ethernaut.

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
- code snippets will help show what section of the smart contract we need to focus our attention to,

## 🔍👀 While on our search for more clues before the 💥 attack!

```yml
According to the instructions on the Etharnaut DApp for this level we start with step 1:
```
- a [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) JavaScript await in console of the Ethernaut Instance web page in developer tools,

```JavaScript
await contract.info()
```
- here is the code snippet from the contract showing this function and what it returns to us, as a string of info in console,

```Solidity

  /// @notice step 1
  function info() public pure returns (string memory) {
    return 'You will find what you need in info1().'; 
  }
```

~~~yml
On to step 2:
~~~

- more [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) await,

```JavaScript
await contract.info1()
```
- here is the code snippet from the contract showing this function and what it returns to us, as a string of info in console,

```Solidity
/// @notice step 2
  function info1() public pure returns (string memory) {
    return 'Try info2(), but with "hello" as a parameter.'; 
  }
```

~~~yml
On to step 3:
~~~

- more [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) await, but with a parameter!

```JavaScript
await contract.info2('hello')

```
- here is the code snippet from the contract showing this function and what it returns to us, as a string of info in console,

```Solidity
/// @notice returned from await contract.info2('hello') step 3, must have 'hello' as parameter
  function info2(string memory param) public pure returns (string memory) {
    if(keccak256(abi.encodePacked(param)) == keccak256(abi.encodePacked('hello'))) {  
      return 'The property infoNum holds the number of the next info method to call.'; 
    }
    return 'Wrong parameter.';
  }

```

~~~yml
On to step 4:
~~~

- 💯 *more* 🕵️‍♂️ [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) await,

```JavaScript
await contract.infoNum()

```
- here is the code snippet from the contract showing this function and what it returns to us, as a string of info in console,

```Solidity
/// @notice returned from await contract.infoNum() step 4
  uint8 public infoNum = 42;

```

~~~yml
On to step 5:
~~~

- more, more, mooOOAAAAR [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) await, lol 😂 better get some ☕️ coffee we are only half way! lol 🤣

```JavaScript
await contract.info42()

```
- here is the code snippet from the contract showing this function and what it returns to us, as a string of info in console,

```Solidity
/// @notice returned from await contract.info42() step 5
  function info42() public pure returns (string memory) {
    return 'theMethodName is the name of the next method.'; 
  }

```

~~~yml
On to step 6:
~~~

- more [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) await, 🥱 😴 💤 lol, jk 🤩 let's do this! Bring on more await, lol!

```JavaScript
await contract.theMethodName()

```
- here is the code snippet from the contract showing this function and what it returns to us, as a string of info in console,

```Solidity
/// @notice returned from await contract.theMethodName() step 6
  string public theMethodName = 'The method name is method7123949.';

```

~~~yml
On to step 7:
~~~

- 💯 🏆 💪 **MORE** 💪 🏆 🕵️‍♂️ [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) await,

```JavaScript
await contract.method7123949()

```
- here is the code snippet from the contract showing this function and what it returns to us, as a string of info in console,

```Solidity
/// @notice returned from await contract.method7123949() step 7
  function method7123949() public pure returns (string memory) {
    return 'If you know the password, submit it to authenticate().'; 
  }

```

## ✨ And here we go, what do we have here, a 🆘 vulnerability!

- ethereum is transparent and public so storing vulnerable data like passwords is extremely risky ⚠️

~~~yml
On to step 8:
~~~

- 💯 *more* 🕵️‍♂️ [top level](https://developer.chrome.com/blog/new-in-devtools-62/#await) await,

```JavaScript
await contract.password()

```
- here is the code snippet from the contract showing this function and what it returns to us, as a string of info in console,

```Solidity
/**  @notice password is assigned during deployment of contract in constructor,
  password found using await contract.password() returns "ethernaut0" step 8 */
  constructor(string memory _password) public {
    password = _password;
  }

``` 
- 🎉 get [rekt](https://rekt.news/), lol! 😇🤣

~~~yml
On to step 9:
~~~

## 💣💥 The attack

```JavaScript
await contract.authenticate("ethernaut0")

```
- here is the code snippet from the contract showing this function and what it returns to us, as a string of info in console,

```Solidity

/// @notice change bool from false to true using await contract.authenticate("ethernaut0") step 9
  function authenticate(string memory passkey) public {
    if(keccak256(abi.encodePacked(passkey)) == keccak256(abi.encodePacked(password))) {
      cleared = true; 
    }
  }

```

~~~yml
On to step 10:
~~~

- Well that was fun! 🎉 
- Click submit instance button on the Ethernaut Instance web page, step 10, checks if bool is true in order to clear level instance.

```Solidity
  function getCleared() public view returns (bool) { 
    return cleared;  
  }
}

```
