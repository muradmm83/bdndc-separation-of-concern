const AccountDataContract = artifacts.require('AccountDataContract');
const StudentAccount = artifacts.require('StudentAccount');

module.exports = deployer => {
    deployer.deploy(AccountDataContract)
        .then(() => deployer.deploy(StudentAccount, AccountDataContract.address));
};