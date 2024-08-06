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
    address USER = makeAddr("user");
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        FundMeScript fundMeScript = new FundMeScript();
        fundMeScript.run();
        
        fundMe = fundMeScript.fundMe();
        vm.deal(USER, STARTING_BALANCE);
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

    function test_Fund_FailsWithoutEnoughETH() public {
        vm.expectRevert();
        fundMe.fund();
    }

    modifier funded() {
        vm.prank(USER);
    
        fundMe.fund{value: 0.1 ether}();
        _;
    }

    function test_Fund_UpdatedFunder() public funded {
        assertEq(fundMe.getFunder(0), USER);
        
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(0.1 ether, amountFunded);
    }

    function test_OnlyOwnerCanWithdraw() public funded {
        vm.expectRevert();
        vm.prank(USER);
        fundMe.withdraw();
    }

    function test_WithdrawWithASingleFunder() public funded {
        uint256 currentBalance = msg.sender.balance;
    
        vm.prank(msg.sender);
        fundMe.withdraw();
        assertEq(fundMe.getAddressToAmountFunded(USER), 0);

        uint256 afterBalance = msg.sender.balance;
        assertEq(currentBalance + 0.1 ether, afterBalance);
        assertEq(0, address(fundMe).balance);
    }
}
