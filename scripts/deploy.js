const hre = require("hardhat");

async function main() {

  const Product = await hre.ethers.getContractFactory("product");//fetching bytecode and abi
  const product = await Product.deploy();//creating instance ofsmart contract

  await product.deployed();//deploying the smart contract

  console.log("Deployed contract address", `${product.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// 0x359fF99F02eeA9d5ea1b58e79d8E046E8B0c718f