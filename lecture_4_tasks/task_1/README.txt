 ChooseADoor Smart Contract
Overview
ChooseADoor is a simple Ethereum smart contract for a betting game, developed in Solidity. In this game, a player chooses one of three doors (A, B, or C), each having different outcomes:

Door A: The player loses their bet, and the amount is added to the bank.
Door B: The player's bet is doubled, half coming from the bank.(only small amount works as example bank: 0.1 eth, player bet: 0.001 eth)
Door C: The player wins the entire bank jackpot in addition to their bet.
The contract also allows the owner (the deployer) to deposit and withdraw funds from the bank.

How to Play
Setup
To use this contract, deploy it to an Ethereum network using Truffle. Make sure you have Truffle installed and configured.

Contract Functions
depositToBank: Allows the owner to deposit funds into the bank.
play: Allows a player to choose a door and place a bet.
withdrawFromBank: Allows the owner to withdraw funds from the bank.
getBankBalance: Returns the current balance of the bank.
getPlayerBalance: Returns the balance of a given player.
getCurrentGameMessage: Returns the latest game message, including outcomes of the last action.

1.Playing the Game in Truffle Console
Compile the Contract:
truffle compile

2.Deploy the Contract:
truffle migrate --network sepolia

3.Interact with the Contract:
Open the Truffle console:
truffle console --network sepolia

4.Get the Deployed Contract Instance:
const chooseADoor = await ChooseADoor.deployed();

5.Get Accounts:
const accounts = await web3.eth.getAccounts();
const owner = accounts[0]; // Owner (usually the first account)
const player = accounts[1]; // Player (different account or your own account than accounts[0])

6.Deposit to the Bank:
await contract.depositToBank({ from: owner, value: web3.utils.toWei('0.1', 'ether') });

7. Check Bank Balance and Player Balance:
const bankBalance = await contract.getBankBalance();
console.log(`Bank balance: ${web3.utils.fromWei(bankBalance, 'ether')} ETH`);

const playerBalance = await web3.eth.getBalance(player);
console.log(`Player balance: ${web3.utils.fromWei(playerBalance, 'ether')} ETH`);


8.Play the Game:
await contract.play('B', { from: player, value: web3.utils.toWei('0.001', 'ether') });

9.Check the Game Message(commentator of this game gives information about the status):
const message = await contract.getCurrentGameMessage();
console.log(message);
//But need to redeploy again for the newest Message updates in GameMessage

10.Withdraw from the Bank (To get your Money back):
await contract.withdrawFromBank(web3.utils.toWei('0.1', 'ether'), { from: owner });





