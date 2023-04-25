//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;
// Define a new contract named JointSavings
contract JointSavings {
    //  Two variables of type address payable named accountOne and accountTwo
    address payable accountOne;
    address payable accountTwo;
    // A variable of type address public named lastToWithdraw
    address payable public lastToWithdraw;
    //Two variables of type uint public named lastWithdrawAmount and contractBalance
    uint public lastWithdrawAmount;
    uint public contractBalance;
// Define a function named withdraw that accepts two arguments: amount of type uint and recipient of type payable address
    function withdraw(uint amount, address payable recipient) public {
    //Define a require statement that checks if recipient is equal to either accountOne or    accountTwo. If it isn't, the require statement will return the "You don't own this account!" text.
        require(recipient == accountOne || recipient == accountTwo, "You dont own this account!");
//Define a require statement that checks if balance is sufficient for accomplishing the withdrawal operation. If insufficient funds exist, it will return the "Insufficient funds!" text.
        require(amount <= contractBalance, "Insufficient funds!");
        // Add an if statement to check if lastToWithdraw is not equal to (!=) recipient. If it isn't equal, set it to the current value of recipient.
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
    }
    // Call the transfer function of the recipient, and pass it the amount to transfer as an argument.
        recipient.transfer(amount);
        // Set lastWithdrawAmount equal to amount.
        lastWithdrawAmount = amount;
        //Set the contractBalance variable equal to the balance of the contract by using address(this).balance to reflect the new balance of the contract.
        contractBalance = address(this).balance;
    }
// Define a public payable function named deposit.
    function deposit() public payable {
    //Set the contractBalance variable equal to the balance of the contract by using address(this).balance
        contractBalance = address(this).balance;
    }
    // Define a public function named setAccounts that takes two address payable arguments, named account1 and account2. In the body of the function, set the values of accountOne and accountTwo to account1 and account2, respectively.
    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
    }
    // Add a fallback function so that your contract can store ether that's sent from outside the deposit function.
    receive() external payable {}
}