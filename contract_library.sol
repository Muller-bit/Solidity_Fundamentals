//SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
// This line specifies the version of Solidity to be used
//Library and inheritence are two important concepts in Solidity that help in code reusability and organization
//Contain hlful functions that can be used by other contracts
library MathUtils {
    //find the smallest of two numbers
    function min(uint256 a, uint256 b) public pure returns (uint256) {
        //Pure function does not read or modify the state
        //view function can read but not modify the state

        return a < b ? a : b; //Ternary operator to return the smaller value
        //this function just  compares two numbers and returns the smaller one , doest not read or modify the state that is why pure is used
    }

    function max(uint256 a, uint256 b) public pure returns (uint256) {
        return a > b ? a : b; //Ternary operator to return the larger value
    }
}
