// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract AdditionTest is Test {
    /// @dev Address of the Addition contract.
    Addition public addition;

    /// @dev Setup the testing environment.
    function setUp() public {
        addition = Addition(HuffDeployer.deploy("Addition"));
    }

    /// @dev Ensure that you can set and get the value.
    function testAddValue(uint256 value_a, uint256 value_b) public {
        console.log(value_a, value_b);
        uint256 a = addition.add(value_a, value_b);
        console.log(a);
        assertEq(a, value_a + value_b);
    }
}

interface Addition {
    function add(uint256, uint256) external returns (uint256);
}
