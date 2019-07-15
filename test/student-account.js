let dataContract = artifacts.require('AccountDataContract');
let appContract = artifacts.require('StudentAccount');
const oneEther = web3.utils.toWei('1', 'ether');

contract('Student Account', accounts => {

    let owner = accounts[0];

    it('Get balance of an address', async () => {
        let dataInstance = await dataContract.deployed();

        let balance = await dataInstance.getBalance({ from: accounts[1] });

        assert.equal(balance, 0, 'Balance should be zeor');
    });

    it('Can deposit 1 ether', async () => {
        let appInstance = await appContract.deployed();

        const oneEther = web3.utils.toWei('1', 'ether');

        await appInstance.depositToAccount({ from: accounts[1], value: oneEther });

        let dataInstance = await dataContract.deployed();

        let balance = await dataInstance.getBalance({ from: accounts[1] });

        assert.equal(balance, oneEther, 'Balance should be equal');
    });

    it('Can withdraw from account', async () => {
        let appInstance = await appContract.deployed();
        let dataInstance = await dataContract.deployed();

        await appInstance.depositToAccount({ from: accounts[1], value: oneEther });

        let currentBalance = await dataInstance.getBalance({ from: accounts[1] });

        await appInstance.withdrawFromAccount(web3.utils.toWei('0.5', 'ether'), { from: accounts[1] });

        let balance = await dataInstance.getBalance({ from: accounts[1] });

        assert.notEqual(currentBalance, balance, 'Balance should decrease');

    });

});