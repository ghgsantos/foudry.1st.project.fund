// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "../../lib/forge-std/src/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 8 ether;
    uint256 constant STARTING_BALANCE = 9999 ether;
    uint256 GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deployfundme = new DeployFundMe();
        fundMe = deployfundme.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInterations() public {
        FundFundMe fundFundMe = new FundFundMe();
        //vm.prank(USER);
        //vm.deal(USER, 1e18);
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        //address funder = fundMe.getFunder(0);
        assert(address(fundMe).balance == 0);
    }
}
