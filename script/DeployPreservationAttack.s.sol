//SPDX-License-Identifer: MIT
pragma solidity >=0.6.0;

import "forge-std/Script.sol";
import "../src/PreservationAttack.sol";

contract DeployPreservationAtatck is Script {
    PreservationAttack preversationAttackContract;

    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        preversationAttackContract = new PreservationAttack();
        preversationAttackContract.exploit();
        vm.stopBroadcast();
    }
}
