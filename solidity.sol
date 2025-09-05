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
//Immutable variables
//Immutable Variables: Variables marked as immutable can be assigned only once, but this assignment can happen in the constructor:
contract TokenDeployer {
    // Declared but not assigned yet
    address public immutable deployer;
    uint256 public immutable deploymentTime;
    //constructor function runs once when the contract is deployed,its just special function
    constructor() {
        // Assigned once in the constructor
        deployer = msg.sender;
        deploymentTime = block.timestamp;
    }
}
//Data Types in Solidity , value types and reference types
/*// Let's say we create a variable with a value:
uint a = 5;
​// When we assign it to another variable:
uint b = a;
​
// Now b has its own copy of the value 5
​
// If we change b:
b = 10;
​
// The value of a still remains 5
// The value of b is now 10
*/
contract ValueTypeExample {
    uint256 public score = 100; //uint no decimals, only positive whole numbers
    int256 public temperature = -5;
    bool public isComplete = false;
    address public contractCreator = 0x1234567890123456789012345678901234567890;
    bytes32 public dataHash =
        0xabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcd;

    function demonstrateValueTypes() external pure {
        uint256 a = 5; // Original variable
        uint256 b = a; // b gets a copy of a's value
        b = 10; // Changing b does not affect a
        // a is still 5, b is now 10

        /*List of the Refence types
        string public message = "welcome";  ---> string
        uint256 public[] scores =[1,2,3,4];--->array
        mapping(address => untin256)public balances; i.e key-value pairs, dictionary --->mapping

        struct Person(){
        string name:"Mullyer";
        uint256 age:30;
        address wallet:0x1234567890123456789012345678901234567890;
        }
        --->struct i.e custom grouping the related  data 
*/
    }
}
contract RefenceTypeExample {
    // Conceptual example in Solidity-like pseudocode
    /*Declare and initialize an array in storage (blockchain permanent memory)
array storageArray = [1, 2, 3];  original array in storage

// Create a pointer to the storage array
// This doesn't copy the data, it just creates a reference to the same storage location
array storagePointer = storageArray; // points to the same data

// Modify the array through the pointer
storagePointer[0] = 100; // changes the actual storage array

// At this point:
// storageArray is [100, 2, 3]  (it was_changed !)

// Create a memory copy of the storage array
// This copies the entire array to a new location in temporary memory
array memoryCopy = copy of storageArray; // memoryCopy is [100, 2, 3]

// Modify the memory copy
memoryCopy[1] = 200; // only changes the copy, not the original

// Final result:
// storageArray is [100, 2, 3]  (unchanged by memory modifications)
/* memoryCopy is [100, 200, 3]  (modified locally)
*/
}

contract PointerExample {
    // State array in storage
    uint256[] public storageArray = [1, 2, 3];

    function manipulateArray() public {
        // This creates a pointer to the storage array
        uint256[] storage storageArrayPointer = storageArray;

        // This modifies the actual storage array through the pointer
        storageArrayPointer[0] = 100;

        // At this point, storageArray is now [100, 2, 3]

        // This creates a copy in memory, not a pointer to storage
        uint256[] memory memoryArray = storageArray;

        // This modifies only the memory copy, not the storage array
        memoryArray[1] = 200;

        // At this point, storageArray is still [100, 2, 3]
        // and memoryArray is [100, 200, 3]
    }
}
contract StorageLocation {
    // State variable - stored in storage
    uint256[] permanentArray;
    function processArray(uint256[] calldata inputValues) external {
        // 'inputValues' exists in calldata - can't be modified
        // Local variable in memory - temporary copy

        uint256[] memory tempArray = new uint256[](inputValues.length);
        for (uint i = 0; i < inputValues.length; i++) {
            tempArray[i] = inputValues[i] * 2;
        }
        // Reference to storage - changes will persist
        uint256[] storage myStorageArray = permanentArray;
        myStorageArray.push(tempArray[0]); // This updates the blockchain state
    }
}
contract Counter {
    uint256 public count = 0;
    // This function increases the count by 1
    function increment() public {
        count = count + 1; // You can also write: count += 1;
    }
    // This function decreases the count by 1
    function decrement() public {
        count = count - 1; // You can also write: count -= 1;
    }
}
//inheritance key concept => is , virtual , ovverride
//Parent contract
contract parent {
    uint256 public favoriteNumber;
    function storeNumber(uint256 number) public virtual {
        favoriteNumber = number;
    }
}

//Child contract
contract child is parent {
    function storeNumber(uint256 number) public override {
        favoriteNumber = number + 5;
    }
    //main function part name,parameters,visibility ,return type
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
    //Special Function Types
    //view: Can read but not modify state
    function getCount() public view returns (uint256) {
        return count;
    }
    //pure: Cannot read or modify state
    function addNumbers(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    //constructor: Runs only once when the contract is deployed
    constructor() {
        owner = msg.sender; // Sets the contract creator as the owner
    }
    //payable: means that the function can be sent ether.
    mapping(address => uint256) balances;

    function sendMeMoney() public payable {
        balances[user] += msg.value; // more on this "msg.value" coming in a second!
    }
}

//Transaction Context Variables
contract OwnerExample {
    address public owner;

    constructor() {
        owner = msg.sender; // The address that deploys the contract becomes the owner
    }
}
//msg.value: The amount of ETH (in wei) sent with the function call:
contract PaymentExample {
    mapping(address => uint256) public payments;
    //We create function that can receive ETH
    function makePayment() public payable {}
}
