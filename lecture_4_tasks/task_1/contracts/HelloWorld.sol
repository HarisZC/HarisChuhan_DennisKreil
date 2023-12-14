// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChooseADoor {
    address public owner;
    uint256 public bankBalance;
    string public gameMessage = "Welcome to Choose a Door!";

    event GameResult(address indexed player, string door, string result, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function depositToBank() external payable {
        require(msg.sender == owner, "Only the owner can deposit");
        bankBalance += msg.value;
        gameMessage = "Bank balance updated.";
    }

    function play(string memory doorChoice) external payable {
        require(msg.value > 0, "You must bet some amount");
        require(bankBalance > 0, "The bank must have funds");
        uint256 betAmount = msg.value;
        string memory result;

        if (keccak256(abi.encodePacked(doorChoice)) == keccak256(abi.encodePacked("A"))) {
            // Door A: Lose all your money
            bankBalance += betAmount;
            result = "Door A: You lost all your bet.";
            gameMessage = result;
        } else if (keccak256(abi.encodePacked(doorChoice)) == keccak256(abi.encodePacked("B"))) {
            // Door B: Double your bet
            require(bankBalance >= betAmount, "Bank can't cover the bet");
            payable(msg.sender).transfer(betAmount * 2);
            bankBalance -= betAmount;
            result = "Door B: You doubled your bet!";
            gameMessage = result;
        } else if (keccak256(abi.encodePacked(doorChoice)) == keccak256(abi.encodePacked("C"))) {
            // Door C: Win the bank jackpot
            payable(msg.sender).transfer(bankBalance + betAmount);
            result = "Door C: You won the bank jackpot!";
            gameMessage = result;
            bankBalance = 0;
        } else {
            revert("Invalid door choice");
        }

        gameMessage = result;
        emit GameResult(msg.sender, doorChoice, result, betAmount);
    }

    function withdrawFromBank(uint256 amount) external {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(amount <= bankBalance, "Insufficient funds in the bank");
        payable(owner).transfer(amount);
        bankBalance -= amount;
        gameMessage = "Withdrawal from bank successful.";
    }

      function getBankBalance() public view returns (uint256) {
        return bankBalance;
    }

    function getPlayerBalance(address player) public view returns (uint256) {
        return player.balance;
    }

    function getCurrentGameMessage() public view returns (string memory) {
        return gameMessage;
    }
}


