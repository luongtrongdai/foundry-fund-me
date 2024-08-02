// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MockAggregatorV3} from "../test/mocks/MockAggregatorV3.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        if (block.chainid == 11155111) {
            getSepoliaEthConfig();
        } else {
            getAnvilEthConfig();
        }
    }
    function getSepoliaEthConfig() public {
        activeNetworkConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
    }

    function getAnvilEthConfig() public {
        vm.startBroadcast();

        MockAggregatorV3 mockAggregatorV3 = new MockAggregatorV3(8, 2000e8);

        vm.stopBroadcast();

        activeNetworkConfig = NetworkConfig({
            priceFeed: address(mockAggregatorV3)
        });
    }
}