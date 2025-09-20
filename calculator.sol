//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19; // make sure the version matches the one in MathUtils.sol
import "./MathUtils.sol"; // Import the library
contract Calculator {
    //attach the library to uint256 type
    using MathUtils for uint256;

    //methode 1: call as  library function

    function getMinimum(uint256 a, uint256 b) public pure returns (uint256) {
        return MathUtils.min(a, b); // Call the min function from MathUtils library
    }
}
