var ElektaMain = artifacts.require("./ElektaMain.sol");
var ElektaGroups = artifacts.require("./ElektaGroups.sol");

module.exports = function(deployer) {
  deployer.deploy(ElektaMain);
};

module.exports = function(deployer) {
  deployer.deploy(ElektaGroups);
};
