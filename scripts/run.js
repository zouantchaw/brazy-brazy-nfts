const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory('BrazyNFT');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contact deployed to:", nftContract.address);

  // Call contract function
  let txn = await nftContract.makeABrazyNFT()
  // Wait for it to be mined
  await txn.wait()

  // Mint another NFT
  txn = await nftContract.makeABrazyNFT()
  // Wait for it to be mined
  await txn.wait()
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();