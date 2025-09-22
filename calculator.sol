//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19; // make sure the version matches the one in MathUtils.sol
import "./MathUtils.sol"; // Import the library
contract Calculator {
    //attach the library to uint256 type
    using MathUtils for uint256;

    //methode 1: call as  library function

    function getMinimum(uint256 a, uint256 b) public pure returns (uint256) {
        return MathUtils.min(a, b); // Call the min function from MathUtils library , embeded library function
    }

    function getMaximum(uint256 a, uint256 b) public pure returns (uint256) {
        return MathUtils.max(a, b); // Call the max function from MathUtils library
    }

    //methode 2: call as attached function
    function getMaximumAsAttached(
        uint256 a,
        uint256 b
    ) public pure returns (uint256) {
        return a.max(b); // Call the max function as if it were a method on uint256
        //same as return MathUtils.max(a,b);
    }

    //benefits of library
    //Write once, use multiple times: Libraries allow you to write code once and reuse it across multiple contracts, reducing redundancy and potential errors.
    //Gas efficiency: Using libraries can save gas costs,internal function get embedded in the contract bytecode , especially for frequently used functions, as the library code is deployed only once and can be called by multiple contrac
    //No state variables: Libraries cannot have state variables, which helps in maintaining a clear separation between logic and data, reducing the risk of unintended side effects,makes them perfect for pure utility functions.
}
//Contract inheritence
//It lets a contract inherit properties and methods from another contract

//Base  contract with core functionality
contract BaseToken {
    string public name;
    uint256 public totalSupply;

    constructor(string memory _name) {
        name = _name;
        totalSupply = 1000000; // Initial supply
    }

    function getInfo() public view virtual returns (string memory) {
        return string.concat("Token:", name);
    }
}
//Enhanced contract that inherits and extends BaseToken
contract GoldToken is BaseToken {
    constructor() BaseToken("Gold Token") {}
}
