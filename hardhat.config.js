//require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");
const dotenv = require("dotenv");

dotenv.config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.7",
  networks: {
    //hardhat:{ chainId: 1337},
    mumbai:{
      //url: `https://polygon-mumbai.infura.io/v3/${projectId}`,
      // url: "https://rpc-mumbai.maticvigil.com",
      // url: "https://rpc-mumbai.maticvigil.com",
      url: process.env.POLYGON_URL_POLYGON,
       accounts: [process.env.PRIVATE_KEY_POLYGON]
     },
    bsctestnet:{
      url: process.env.BSCTESTNET_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
    
  },
  etherscan: {
    apiKey: process.env.API_KEY
  }
};
