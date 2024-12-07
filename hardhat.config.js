require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // Load environment variables

module.exports = {
  solidity: "0.8.28",
  networks: {
    linea_mainnet: {
      url: `https://linea-mainnet.infura.io/v3/${process.env.INFURA_API_KEY}`, // Infura RPC URL for Linea mainnet
      accounts: [`0x${process.env.PRIVATE_KEY}`], // Your private key
    },
  },
};