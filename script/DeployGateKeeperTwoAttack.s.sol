//SPDX-License-Identifier
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/GateKeeperTwoAttack.sol";

contract DeployGateKeeperTwoAttack is Script {
    GateKeeperTwoAttack gatekeeperContract;

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        gatekeeperContract = new GateKeeperTwoAttack();
        vm.stopBroadcast();
    }
}
