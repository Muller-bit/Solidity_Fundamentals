//SPDX-License-identifier: MIT //this specifies how others can use your code with an SPDX license identifier
pragma solidity ^0.8.19;
contract MyContract {
    // Contract code goes here
}
//Variables: Storing Information
contract StorageExample {
    //state variables
    //we label variables as stored in storage using the s_ prefix e.g. s_balance or s_owner
    uint256 public myNumber = 42; // A number
    string public myText = "Hello"; // Text
    bool public isActive = true; // A true/false value
    address public owner; // An Ethereum address
    uint256 private secretNumber; // A private number
}
//Constant and Immutable variables
contract TokenContract {
    // Must be assigned at declaration
    uint256 public constant DECIMAL_PLACES = 18;
    string public constant TOKEN_NAME = "My Token";
    address public constant DEAD_ADDRESS =
        0x000000000000000000000000000000000000dEaD;
}
