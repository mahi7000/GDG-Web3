// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {SimpleSavings} from "../src/SimpleSavings.sol";

contract SimpleSavingsTest is Test {
    SimpleSavings public bank;
    address public a = address(0x1);
    address public b = address(0x2);
    address public c = address(0x3);

    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed user, uint256 amount, uint256 timestamp);

    function setUp() public {
        bank = new SimpleSavings();

        vm.deal(a, 10 ether);
        vm.deal(b, 10 ether);
        vm.deal(c, 10 ether);
    }

    function testDeposit() public {
       vm.prank(a);
       
       emit Deposit(a, 1 ether, block.timestamp);
       bank.deposit{value: 1 ether}();

       assertEq(bank.getBalance(a), 1 ether);
       assertEq(bank.getTotalBalance(), 1 ether);
    }

    function testWithdrawal() public {
        vm.prank(a);
        bank.deposit{value: 2 ether}();

        vm.prank(a);
        emit Withdrawal(a, 1 ether, block.timestamp);

        bank.withdraw(1 ether);

        assertEq(bank.getBalance(a), 1 ether);
        assertEq(bank.getTotalBalance(), 1 ether);
    }
}
