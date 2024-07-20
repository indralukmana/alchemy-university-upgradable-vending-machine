import { ethers, upgrades } from "hardhat";

async function main() {
  const vendingMachineV1 = await ethers.getContractFactory("VendingMachineV1");
  const proxy = await upgrades.deployProxy(vendingMachineV1, [100]);

  await proxy.waitForDeployment();
  const proxyAddressString = await proxy.getAddress();

  console.log("VendingMachineV1 deployed to:", proxyAddressString);

  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    proxyAddressString
  );
  const implementationAddressString = implementationAddress.toString();
  console.log("Implementation address:", implementationAddressString);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
