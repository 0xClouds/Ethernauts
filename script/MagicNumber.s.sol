//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

/**
 * In this challenge we have to return the magic number 42.
 * However we are restricted to using 10 opcodes.
 *
 * Things I've learned here:
 * Each opcode is 1 byte
 * There is Runtime code and Initlization code.
 * Runtime code is that contains contract logic
 * Init code is akin to the constructor is returns the runtime bytecode.
 * We can use the PUSH opcode to place items onto the stack. PUSH(0) PUSH(1) [1, 0];
 * We can use MSTORE to store values in memory that already exist in the stack. MSTORE expects memory position, and value;
 *
 * Knowing this we know that we can solve this problem by doing the folowing
 *
 * Init code
 * Load runtime code into Memory
 *  CODECOPY(t,f,s) -> t: Location in memory for runtime code, f: position in contract where runtime code begins, we dont know this, s: size of runtime code (10 bytes).
 * Push these items onto the stack in reverse order because our stack is FILO
 * Push size
 *  PUSH(value)
 * Push starting position
 *  PUSH(??)
 * Push location or offset
 *  PUSH(value)
 * Call Codecopy
 *  CODECOPY(t,s,f)
 * We need to tell the EVM where find the runtime code and its size
 * Push size
 *  PUSH(value)
 * Push location
 *  PUSH(value)
 * use the RETURN opcode to hand this information back to the EVM
 *  RETURN
 *
 * Then for runtime code we need to push twice once for the value and once for the position and then store it in Memory
 * Push value
 *  PUSH(value)
 * Push position
 *  PUSH(position)
 * MSTORE
 * MSTORE(p,v)
 *
 *
 */

interface IMagicNum {
    function setSolver(address _solver) external;
}

contract MagicNumber is Script {
    function run() public {
        uint256 privatKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privatKey);

        IMagicNum magicNumContract = IMagicNum(
            0x10E52109e7E2f8419f22e43522b4fef8680ab50d
        );

        bytes
            memory code = "\x60\x0a\x60\x0c\x60\x00\x39\x60\x0a\x60\x00\xf3\x60\x2a\x60\x80\x52\x60\x20\x60\x80\xf3";
        address solver;
        assembly {
            solver := create(0, add(code, 0x20), mload(code))
        }

        magicNumContract.setSolver(solver);
        vm.stopBroadcast();
    }
}
