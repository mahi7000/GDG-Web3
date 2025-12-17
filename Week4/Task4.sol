// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ATM {
    address public owner;
    bool public paused = false;

    struct Account {
        string name;
        string account_no;
        string pin;
        int balance;
    }

    Account[] public accounts;

    mapping(string => uint256) public accountNoToIndex;

    constructor() {
        owner = msg.sender;
    }


    function createAccount(string calldata _name, string calldata _account_no, string calldata _pin) public {
        require(!paused, "Contract is paused");
        require(accountNoToIndex[_account_no] == 0, "Account already exists");
        
        Account memory person = Account(_name, _account_no, _pin, 0);
        accounts.push(person);
        accountNoToIndex[_account_no] = accounts.length;
    }

    function withdraw(string calldata _account_no, string calldata _pin, int _amountToWithdraw) public {
        require(!paused, "Contract is paused");
        uint256 index = accountNoToIndex[_account_no] - 1;
        require(accountNoToIndex[_account_no] > 0, "Account not found");

        Account storage person = accounts[index];
        require(keccak256(bytes(person.pin)) == keccak256(bytes(_pin)), "Incorrect pin");
        require(person.balance >= _amountToWithdraw, "Not enough in your account");

        person.balance -= _amountToWithdraw;
    }

    function deposit(string calldata _account_no, string calldata _pin, int _amountToDeposit) public {
        require(!paused, "Contract is paused");
        uint256 index = accountNoToIndex[_account_no] - 1;
        require(accountNoToIndex[_account_no] > 0, "Account not found");

        Account storage person = accounts[index];
        require(keccak256(bytes(person.pin)) == keccak256(bytes(_pin)), "Incorrect pin");

        person.balance += _amountToDeposit;
    }

    function checkDeposit(string calldata _account_no, string memory _pin) public view returns (int) {
        require(!paused, "Contract is paused");
        uint256 index = accountNoToIndex[_account_no] - 1;
        require(accountNoToIndex[_account_no] > 0, "Account not found");
        
        Account storage person = accounts[index];
        require(keccak256(bytes(person.pin)) == keccak256(bytes(_pin)), "Incorrect pin");
        
        return person.balance;
    }

    function pause() public {
        require(msg.sender == owner, "Only owner can pause");
        paused = true;
    }

    function unpause() public {
        require(msg.sender == owner, "Only owner can unpause");
        paused = false;
    }
}