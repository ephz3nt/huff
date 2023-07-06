// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "openzeppelin-contracts/interfaces/IERC20.sol";
import "./lib/IWETH.sol";

contract DepositTest is Test {
    /// @dev Address of the Deposit contract.
    address public deposit;
    // IWETH weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2); // mainnet
    IWETH weth = IWETH(0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6); // goerli

    /// @dev Setup the testing environment.
    function setUp() public {
        vm.createSelectFork(vm.envString("GOERLI_URL")); // goerli
        // vm.createSelectFork(vm.envString("MAINNET_URL")); // mainnet

        deposit = HuffDeployer.deploy("Deposit");
        weth.deposit{value: 100 ether}();
        weth.transfer(deposit, 100 ether);
    }

    function testDeposit() public {
        uint256 value = 1 ether;
        uint256 depositBefourBalance = weth.balanceOf(deposit);
        bytes1 select = 0x05;
        bytes memory data = abi.encodePacked(select);
        deposit.call{value: value}(data);
        uint256 depositAfterBalance = weth.balanceOf(deposit);
        assertEq(depositAfterBalance, depositBefourBalance + value);
    }

    function testWithdraw() public {
        uint256 depositBalance = weth.balanceOf(deposit);
        bytes1 select = 0x4c;
        bytes memory data = abi.encodePacked(select, depositBalance);
        address(deposit).call(data);
        uint256 senderBalance = weth.balanceOf(address(this));
        assert(weth.balanceOf(deposit) == 0);
        assertEq(senderBalance, depositBalance);
    }
}

interface Deposit {}
