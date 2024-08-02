// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract FundMeScript is Script {
    FundMe public fundMe;

    function setUp() public {}

    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        (address priceFeed) = helperConfig.activeNetworkConfig();

        vm.startBroadcast();

        fundMe = new FundMe(priceFeed);

        vm.stopBroadcast();
    }
}
