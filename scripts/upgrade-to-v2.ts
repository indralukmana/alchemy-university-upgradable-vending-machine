import { ethers, upgrades } from "hardhat";

const proxyAddress = "0x58C6b71c75e806ae8844b2155EFc2fb59c3c8c8F";

async function main() {
  const VendingMachineV2 = await ethers.getContractFactory("VendingMachineV2");
  const vendingMachineV2 = await upgrades.upgradeProxy(
    proxyAddress,
    VendingMachineV2
  );

  await vendingMachineV2.waitForDeployment();
  const v2ProxyAddressString = await vendingMachineV2.getAddress();

  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    v2ProxyAddressString
  );
  const implementationAddressString = implementationAddress.toString();

  const owner = await vendingMachineV2.owner();

  console.log("The current contract owner is: " + owner);
  console.log(
    "Implementation contract address: " + implementationAddressString
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
