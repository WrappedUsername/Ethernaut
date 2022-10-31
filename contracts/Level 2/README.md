# Fallout challenge - Level 2

<p align="left"> <img src="https://komarev.com/ghpvc/?username=Level2&label=Repository%20views&color=0e75b6&style=flat" alt="wrappedusername" /> </p>

```yml
This challenge is more about best practices and how using a constructor is the best practice because:
```
- using a constructor prevents slight mistakes from becoming critical vulnerabilities,
  - in this challenge a spelling error creates a critical vulnerabilitiy, the author should have used a constructor instead of a function,

```Solidity
/** 
* @notice this is the vulnerability to be exploited during the attack,
* using a constructor is the best practice to avoid this vulnerability,
* function fal1out does not match contract name making it a public function, to 
* attack and assume ownership player calls await contract.fal1out() to complete this level 
*/
function Fal1out() public payable {
  owner = msg.sender;
    allocations[owner] = msg.value;
}
```
- as you can see the first step in securing your smart contracts is to write simple, clean code that follows all best practices.

## 💥 Critical attack
```yml
This attack was so critical because:
```
- according to this formula “likelihood + impact = severity” the vulnerability was:
  - easy to attack giving it a high likelihood for a successful attack to occur,
  - and the impact if this attack would occur would be extreme (complete loss),
  - making this vulnerability a Cat 5 critical vulnerability

| Likelihood(ease of attack) + | Impact = | Severity |
| :--: | :--: | :--: | 
| High(easy to attack) | Extreme | Cat 5 (Critical) | 
| Medium | Severe | Cat 4 (Dangerous) |
| Low(hard to attack) | Major | Cat 3 (Unsafe) |
