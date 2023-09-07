//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/SelfdestructContract.sol";

contract Transfer is Script {
    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        Selfdestruct selfdestructContract = new Selfdestruct();
        (bool success, ) = address(selfdestructContract).call{
            value: 0.01 ether
        }("");
        require(success, "failed");

        vm.stopBroadcast();
    }
}
