// SPDX-License-Identifier: MIT
/* 
use locked pragma for production to avoid SWC-103
floating pragma i.e. ^0.8.4, using a locked pragma i.e. 0.6.0 that
has been thoroughly tested with the contract ensures
that contracts do not accidentally get deployed using, for example, 
an outdated compiler version that might introduce bugs that affect 
the contract system negatively
*/
pragma solidity ^0.6.0;

/// @title Ethernaut challenge 7, increase contract balance
/// @author Alejandro Santander
/** @notice using selfdestruct player will be able to forcibly send ether to this contract
before the attack contract storage and code is removed from the state */
contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}