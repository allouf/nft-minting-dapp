# NFT Minting dApp 

A full stack dApp for minting NFTs built on Ethereum (Solidity) with Next.js (React).

This repo contains code for minting NFTs from the client-side using [Solidity](https://soliditylang.org/), [React](https://reactjs.org/) and [TailwindCSS](https://tailwindcss.com/).

![NFT Minting dApp ](/public/screenshot.png)

## Prerequisites

- [Node.js](https://nodejs.org/en/download/)
- [MetaMask wallet browser extension](https://metamask.io/download.html).

## Getting Started

Smart contracts :
a. Develop and Deploy NFT smart contracts
b. The smart contracts should be able to mint NFT
	i. Mint only valid certain duration (example between 7 Jan to 14 Jan 2023)
	ii. Mint only once for each wallet
	iii. Only able to mint 5 NFT
	iv. The NFT should have metadata (name, description, image)
c. Script to deploy the smart contract

### Environment Setup

Duplicate `.env.example` to `.env` and fill out the `HARDHAT_CHAIN_ID` environment variable and your wallet account. 

Run `npm install`.

### Running The Smart Contract Locally

Compile the ABI for the smart contract using `npx hardhat compile`.

If you're successful, you'll recieve a confirmation message of:

```
Compilation finished successfully
```

And, a `src/artifacts` folder will be created in your project.

Deploy the smart contract to the local blockchain for testing with `npx hardhat node`.

If you're successful, you'll be presented with a number of account details in the CLI. Here's an example:

```
Account #0: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266 (10000 ETH)
Private Key: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

Then in a new terminal window, `npx hardhat run scripts/deploy.js --network localhost`.

If you're successful, you'll get something like the following CLI output:

```
Minter deployed to: 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
```

### Adding A Local Account To MetaMask

Open your MetaMask browser extension and change the network to `Localhost 8545`.

Next, import one of the accounts by adding its Private Key (for example, `0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80` to MetaMask.

If you're successful, you should see the a balance resembling something like `10000 ETH` in the wallet.

### Connecting The Front-End

In `.env` set the `NEXT_PUBLIC_MINTER_ADDRESS` environment variable to the address your smart contract was deployed to. For example, `0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0`.

In a new terminal window, load the front-end with `npm run dev`. If you want to use an alternate port from `3000`, use `npm run dev -- --port=1234`, or whatever port number you prefer.

## Demo'ing The Functionality

Once set up, go to `localhost:3000` (or whatever post number you used), to view your dApp in the browser.

First, connect your wallet by clicking `Connect wallet`. Ensure you're connected to the `Localhost 8454` network in your MetaMask extension. Select the wallet that you imported earlier.

You can now test minting tokens, between 1 and 10 per transaction, by filling out the input with your desired amount and clicking the `Mint` button.

If you successfully mint a number of NFTs, you should see the `Tokens minted` amount increment.

Switching accounts in MetaMask will update the wallet address in the top right hand corner. Disconnecting all accounts will prompt you to connect your wallet.

All state is retained on browser refresh.

## Editing The Front-End

To modify the front page of your application, edit `pages/index.js`.

All [TailwindCSS classes](https://tailwindcss.com/docs) are available to you.

To lint your front-end code, use `npm run lint`.

## Testing

To test the smart contract, run `npx hardhat test`.

Basic tests can be found in `test/Minter.test.js`.
