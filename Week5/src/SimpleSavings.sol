// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SimpleSavings {
    mapping(address => uint256) private balances;

    uint256 private totalBalance;
    address private owner;

    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    event Withdraw(address indexed user, uint256 amount, uint256 timestamp);

    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");

        balances[msg.sender] += msg.value;
        totalBalance += msg.value;

        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount should be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        totalBalance -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdraw(msg.sender, amount, block.timestamp);
    }

    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    function getTotalBalance() external view returns (uint256) {
        return totalBalance;
    }
}
