// SPDX-License-Identifier: MIT
/* 
Please use locked pragma for production to avoid SWC-103
floating pragma (i.e. ^0.8.4). 
Using a locked pragma (i.e. 0.6.0) that
has been thoroughly tested with the contract ensures
that contracts do not accidentally get deployed using, for example, 
an outdated compiler version that might introduce bugs that affect 
the contract system negatively.
*/
pragma solidity ^0.6.0;

/// @title Ethernaut challenge 8, unlock the vault to pass the level!
/// @author Kyle Riley
contract Vault {

    // Public state variable of boolean value type, assigned in constructor.
    bool public locked;
    /** @dev Private state variable of reference type, this dynamically sized 
    byte array is only visible in this contract and is entered and assigned 
    in the constructor. */
    bytes32 private password;

    /** @notice Password is entered during deployment of the contract and is assigned 
    as bytes32 private state variable password, public state variable boolean locked 
    is assigned as true. */
    constructor(bytes32 _password) public {
        locked = true;
        password = _password;
    }

    /** @notice Player will be able to access the password in storage using web3.eth.getStorageAt()
    in console. Player will create a variable in console var pwd and assign pwd as the result when 
    calling web3.eth.getStorageAt(contract.address, 1, function(err, result){ pwd = result }).
    Player uses contract.address to specify the address, then player specifies the storage slot,
    player uses the optional callback function, this callback option returns an error object as the
    first parameter and an result as the second, player assigns the result as pwd inside this
    optional callback function. Player can convert the hexadecimal representation of the binary password
    from storage into ASCII using web3.utils.hexToAscii(pwd), web3.utils.toAscii() is deprecated.
    Player calls unlock function using contract.unlock(pwd), player enters the pwd variable that 
    has been assigned to the password from storage to complete this level! */
    function unlock(bytes32 _password) public {
        if (password == _password) {
        locked = false;
        }
    }
}