# Telephone challenge - Level 4
```yml
This smart contract has a vulnerability, it's use of tx.origin as authorization is a vulnerability because:
```
- if msg.sender is not tx.origin address _owner will equal owner.

```Solidity
/** 
* @notice function changeOwner() uses tx.origin to change ownership 
* to whatever address calls this function just as long as it is not the 
* address that started the original transaction that created this contract 
*/
function changeOwner(address _owner) public {
  if (tx.origin != msg.sender) {
    owner = _owner;
  }
}
```
## 💥 The attack contract locked and loaded in REMIX IDE

```yml
Click hackContract button to initiate the attack:
```

- lower left of the image, under the Deployed Contracts section 

<p align="left" >
<img width="512" height="512" src="https://user-images.githubusercontent.com/104662990/199756044-16a699f2-5111-4dfe-a25f-fac81cd4b1ab.png">
</P>
