//const Hello = artifacts.require("HelloWorld");

//module.exports = function (deployer) {
//    deployer.deploy(Hello,"hello world");
//}

const ChooseADoor = artifacts.require("ChooseADoor");

module.exports = function (deployer) {
  deployer.deploy(ChooseADoor);
};





