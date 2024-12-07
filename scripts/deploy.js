async function main() {
    // Get the contract factory
    const ZhenzhuToken = await ethers.getContractFactory("ZhenzhuToken");

    console.log("Deploying ZhenzhuToken...");

    // Deploy the contract with the burn rate parameter
    const burnRate = 2;
    const token = await ZhenzhuToken.deploy(burnRate);

    // Wait until the contract is deployed
    await token.waitForDeployment();

    // Log the deployed contract address
    console.log("ZhenzhuToken deployed to:", token.target);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error("Error during deployment:", error);
        process.exit(1);
    });