// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

import {FundMe} from "../src/FundMe.sol";

contract FundFundMeScript is Script {
    function fundFundMe(address mostRecentDeployed) public {
        uint256 SEND_VALUE = 1 ether;

        vm.startBroadcast();
        FundMe(mostRecentDeployed).fund{value: SEND_VALUE}();
        vm.stopBroadcast();

        console.log("Funded FundMe(%s) with %s", mostRecentDeployed, SEND_VALUE);
    }

    function run() public {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);

        fundFundMe(mostRecentDeployed);
    }
}