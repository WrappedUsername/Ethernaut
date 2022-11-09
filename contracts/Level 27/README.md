# Good Samaritan challenge - Level 27 

<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level27&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>

```yml
This smart contract has a vulnerability, because:
```

- when the player calls the requestDonation() and receives 10 tokens, the player can use this as an opportunity to attack, player simply reverts the transaction with the error NotEnoughBalance(),
- below, in the NatSpec comments I describe in further detail, how this attack unfolds over the various dependencies of the victim contract.

```Solidity
/// @notice This function is the main target in the attack from the victim contract GoodSamaritan.sol. 
function requestDonation() external returns(bool enoughBalance){
  // donate 10 coins to requester
  try wallet.donate10(msg.sender) {
    return true;
  } catch (bytes memory err) {
    if (keccak256(abi.encodeWithSignature("NotEnoughBalance()")) == keccak256(err)) {
      // send the coins left
      wallet.transferRemainder(msg.sender);
      return false;
    }
  }
}

/**
* @notice This is the interface used to notify attack contract called from the main attack suface, 
* a dependency of the victim contract.
*/
interface INotifyable {
    function notify(uint256 amount) external;
}

/** @notice This transfer function from contract Coin.sol, is the main attack surface from this dependency 
* of the victim contract, because of the second if() statement. Player will use INotifyable() from the attack 
* contract to intiate the attack on the main attack target from the victim contract. 
*/
   function transfer(address dest_, uint256 amount_) external {
        uint256 currentBalance = balances[msg.sender];

        // transfer only occurs if balance is enough
        if(amount_ <= currentBalance) {
            balances[msg.sender] -= amount_;
            balances[dest_] += amount_;

            if(dest_.isContract()) {
                // notify contract 
                INotifyable(dest_).notify(amount_);
            }
        } else {
            revert InsufficientBalance(currentBalance, amount_);
        }
    }

```

## 🆘 The victim contract in detail

```yml
The victim references three dependencies here, contract Coin has the main attack surface:
```
- the contract Coin uses the interface INotifyable that is also used in the attack inconjuction with the main attack surface, 

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/Address.sol";

contract GoodSamaritan {
    Wallet public wallet;
    Coin public coin;
```

- the main target of the attack is the if() statement inside the requestDonation() function,

```Solidity
constructor() {
        wallet = new Wallet();
        coin = new Coin(address(wallet));

        wallet.setCoin(coin);
    }

    function requestDonation() external returns(bool enoughBalance){
        // donate 10 coins to requester
        try wallet.donate10(msg.sender) {
            return true;
        } catch (bytes memory err) {
            /** 
            * @notice This if() statement is the main attack target specifically "NotEnoughBalance()",
            * player must send this error to satisfy this if statement.
            */
            if (keccak256(abi.encodeWithSignature("NotEnoughBalance()")) == keccak256(err)) {
                // send the coins left
                wallet.transferRemainder(msg.sender);
                return false;
            }
        }
    }
}
 ```
 
 ## 🆘 The victim contract's dependency
 
 - this code snippet below from the victim contract's dependency contract Coin.sol, shows that if a contract is receiving the tokens, the contract will calls the interface INotifyable to send the notice,

```Solidity
 function transfer(address dest_, uint256 amount_) external {
        uint256 currentBalance = balances[msg.sender];

        // transfer only occurs if balance is enough
        if(amount_ <= currentBalance) {
            balances[msg.sender] -= amount_;
            balances[dest_] += amount_;

            if(dest_.isContract()) { // <--- Player is using an attack contract, so attack contract will receive notice
                // notify contract 
                INotifyable(dest_).notify(amount_);
            }
        } else {
            revert InsufficientBalance(currentBalance, amount_);
        }
    }
```

## 🆘 The victim contract's dependency uses an interface 

- The attack contract uses this notice to intiate the attack.

```Solidity
interface INotifyable {
    function notify(uint256 amount) external;
}
```

## ⚠️ The vulnerability in detail

```yml
The vulnerability:
```
- TODO

## 💥 The attack contract in detail

```yml
The attack contract:
```

- TODO

```Solidity

```

## 💥 The attack in detail

```yml
The secret to the attack:
```

- The trick with using the notice to intiate the attack is to *not* revert the *entire* transaction with the error, so player will receive the coins, and after that revert NotEnoughBalance() 

```Solidity
/** 
    * @notice When the attack contract is notified about receiving 10 
    * tokens the attack contract reverts NotEnoughBalance() to the victim contract.
    */
    if (amount == 10) {
        revert NotEnoughBalance();
    } 
```

## 🩺 How can we fix this problem?

- Simple, limit the amount that can be transfered with a simple require() statement.

```Solidity
 function requestDonation() public payable returns(bool enoughBalance){
        // donate 10 coins to requester
        try wallet.donate10(msg.sender) {
            return true;
        } catch (bytes memory err) {
            if (keccak256(abi.encodeWithSignature("NotEnoughBalance()")) == keccak256(err)) {
                // send the coins left
                require(msg.value <= 10); /// @notice <-------- Add require statement here!
                wallet.transferRemainder(msg.sender);
                return false;
            }
        }
    }

```




