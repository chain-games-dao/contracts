const hre = require("hardhat");

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unchainLabsTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;



  const ChainLabsDao = await hre.ethers.getContractFactory("CampaignFactory");
  const chainLabsDao = await ChainLabsDao.deploy(1, address(0));

  await chainLabsDao.deployed();

  console.log(
    `ChainLabsDao with 1 ETH and unchainLabs timestamp ${unchainLabsTime} deployed to ${chainLabsDao.address}`
  );

 
};


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
