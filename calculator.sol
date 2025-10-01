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
    // virtual => can be overridden or can be can be lteredged in derived contract
    function getInfo() public view virtual returns (string memory) {
        return string.concat("Token:", name);
    }
}

//Enhanced contract that inherits and extends BaseToken
contract GoldToken is BaseToken {
    constructor() BaseToken("Gold Token") {}

    //Add new functionality
    function getSymbol() public pure returns (string memory) {
        return "GLD";
    }
    //In this example, GoldToken inherits all features from BaseToken and adds a new function.
}

//Function overriding ,the rules as follows:
//Mark the parent function with virtual (meaning "can be altered")
//Mark the child function with override (meaning "this alters a parent function")

contract NewBaseToken {
    // The virtual keyword allows this function to be overridden
    function getTokenName() public pure virtual returns (string memory) {
        return "New BaseToken";
    }
}

contract CustomToken is NewBaseToken {
    // The override keyword indicates that this function overrides a parent function
    function getTokenName() public pure override returns (string memory) {
        return "CustomToken";
    }
}

//Using super to call parent function
//Sometimes, you want to extend a function rather than completely replace it:
contract ExtendedToken is NewBaseToken {
    function getTokenName() public pure override returns (string memory) {
        // Call the parent function and add to it using the super keyword
        return string.concat(super.getTokenName(), " Plus");
        // Returns "NewBaseToken Plus"
    }
}

//Multiple inheritance
//Solidity allows a contract to inherit from multiple parents, but this requires careful handling.

contract Mintable {
    function canMint() public pure returns (bool) {
        return true;
    }
}

contract Burnable {
    function canBurn() public pure returns (bool) {
        return true;
    }
}

//Inherite from both Mintable and Burnable
contract Token is Mintable, Burnable {
    function getCapabilities() public pure returns (string memory) {
        return "Can Mint and Burn";
    }
}

//When Parent Contracts Have Functions with the Same Name
//We need to explicitly specify which one we are overriding

contract BaseA {
    function getValue() public pure virtual returns (string memory) {
        return "A";
    }
}

contract BaseB {
    function getValue() public pure virtual returns (string memory) {
        return "B";
    }
}

// Multiple inheritance with function name conflict

contract Combined is BaseB, BaseA {
    //Must specify all the contracts being overridden
    function getValue()
        public
        pure
        override(BaseB, BaseA)
        returns (string memory)
    {
        return string.concat(BaseB.getValue(), BaseA.getValue());
        // Returns "AB"
    }
}

//Important Rule: Inheritance Order Matters
//The order in which you list parent contracts is important:

// BaseB comes first in the inheritance list
contract TokenX is BaseB, BaseA {
    function getValue()
        public
        pure
        override(BaseB, BaseA)
        returns (string memory)
    {
        // This calls BaseB's implementation first
        return super.getValue(); // Returns "B"
    }
}

// BaseA comes first in the inheritance list
contract TokenY is BaseA, BaseB {
    function getValue()
        public
        pure
        override(BaseA, BaseB)
        returns (string memory)
    {
        // This calls BaseA's implementation first
        return super.getValue(); // Returns "A"
        //super means like ask the parents who told the story first to thier child
    }
}

//Using OpenZeppelin Contracts
//uses of inheritance is extending standardized contracts from dependencies like OpenZeppelin:
//import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//create a custom  token by inheriting the ERC20 standard implementation

import {ERC20} from "./ERC2O/ERC20.sol";
contract MyToken is ERC20 {
    constructor() ERC20("My Token", "MTK") {
        //Mint 1 million tokens to the deployer
        _mint(msg.sender, 1000000 * 10 ** 18);
    }

    //Add custom features
    function burn(uint256 amount) public {
        //allow token holders to burn their tokens
        _burn(msg.sender, amount);
    }
}

//Adding a fee to tokens transfer
//Inheritence lets you customize standard behaviour :

contract FeeToken is ERC20 {
    address public feeCollector;

    constructor(address _feeCollector) ERC20("Fee Toekn", "FEE") {
        feeCollector = _feeCollector;
        //Mint 1 million tokens to the deployer
        _mint(msg.sender, 1000000 * 10 ** 18);
    }

    //Override the transfer function to add  a 1% fee

    function transfer(
        address to,
        uint256 amount
    ) public override returns (bool) {
        uint256 fee = amount / 100; // 1 % fee
    }
}
