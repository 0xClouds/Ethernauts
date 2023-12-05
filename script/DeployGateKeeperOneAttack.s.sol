//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/GatekeeperOneAttack.sol";

contract DeployGateKeeperOneAttack is Script {
    GatekeeperOneAttack gatekeeperAttackContract;

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        gatekeeperAttackContract = new GatekeeperOneAttack();
        gatekeeperAttackContract.exploit();
        vm.stopBroadcast();
    }
}
