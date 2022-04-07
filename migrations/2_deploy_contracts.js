const MyNFT = artifacts.require("MyNFT");

module.exports = async function(deployer, network, accounts) {
    // deploy our NFT contract
    await deployer.deploy(MyNFT);
    // get contract instance
    const instance = await MyNFT.deployed();

    // set base token URL
    await instance.setBaseTokenURI('https://bafybeicc6yg3ramjkhwvyfouyfi4apb4fejepv76dn75dzm4jxetus23cq.ipfs.nftstorage.link/metadata/');

    // mint 3 tokens to our address
    for (let i = 0; i < 3; i++) {
        await instance.mintTo(accounts[0]);
    }
};