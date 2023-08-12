//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/CoinFlip.sol";

contract DeployCoinFlip is Script {
    CoinFlip coinFlipContract;

    function run() external {
        uint256 callerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(callerPrivateKey);
        coinFlipContract = new CoinFlip();
        coinFlipContract.attack();
        vm.stopBroadcast();
    }
}
