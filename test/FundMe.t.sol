// SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity 0.8.19;

// 2. Imports
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {FundMeScript} from "../script/FundMe.s.sol";

// 3. Interfaces, Libraries, Contracts


contract FundMeTest is Test {
    FundMe public fundMe;

    function setUp() external {
        FundMeScript fundMeScript = new FundMeScript();
        fundMeScript.run();
        
        fundMe = fundMeScript.fundMe();
    }

    function test_MINIMUM_USD_isFiveDolar() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function test_OwnerIsMsgSender() public view {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function test_version() public view {
        uint256 version = fundMe.getVersion();
        console.log(version);
        assertEq(version, 4);
    }
}
