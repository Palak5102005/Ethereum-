const Dex = artifacts.require("Dex");

module.exports = async function (deployer, network, accounts) {
  const feeAccount = accounts[0]; // first account as fee collector
  const feePercent = 1; // 1% fee

  // Deploy only to development/Goerli
  if (network === "development" || network === "goerli") {
    await deployer.deploy(Dex, feeAccount, feePercent);
  }
};

