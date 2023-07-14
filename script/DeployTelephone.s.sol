//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../src/TelephoneCaller.sol";

contract DeployTelephone is Script {
    function run() external {
        uint256 privKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privKey);
        TelephoneCaller telephoneContract = new TelephoneCaller();
        telephoneContract.getOwner();
        vm.stopBroadcast();
    }
}
