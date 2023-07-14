//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../src/CoinFlip.sol";

contract DeployCoinFlip is Script {
    CoinFlip coinFlipContract;

    function run() external {
        uint256 callerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(callerPrivateKey);
        coinFlipContract = CoinFlip(0xA7Bd64c7723b669D6ec63c799Eb97712026A546d);
        vm.stopBroadcast();
    }
}
