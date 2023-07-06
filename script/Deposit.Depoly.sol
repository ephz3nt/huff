// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Script.sol";

contract Deploy is Script {
    function run() public {
        // address deposit = HuffDeployer.deploy("Deposit");
        HuffDeployer.broadcast("Deposit");
    }
}
