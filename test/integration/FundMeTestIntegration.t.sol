// SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity 0.8.19;

// 2. Imports
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "src/FundMe.sol";
import {FundMeScript} from "script/FundMe.s.sol";
import {FundFundMeScript} from "script/Interaction.s.sol";

// 3. Interfaces, Libraries, Contracts


contract FundMeTestIntegration is Test {
    FundMe public fundMe;
    address USER = makeAddr("user");
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        FundMeScript deploy = new FundMeScript();

        deploy.run();
        fundMe = deploy.fundMe();
        vm.deal(USER, STARTING_BALANCE);
    }

    function test_UserCanFund() public {
        FundFundMeScript fundFundMeScript = new FundFundMeScript();

        fundFundMeScript.fundFundMe(address(fundMe));

        assertEq(address(fundMe).balance, 1 ether);
    }
} 