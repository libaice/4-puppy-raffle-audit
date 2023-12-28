// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";

contract WeakRandomAttackTest is Test {
    function test_persdo_randomness() public {
        uint256 rnd = getRandomNumber();
        console.log("Random number is %s", rnd);
    }

    function getRandomNumber() public view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        msg.sender,
                        block.timestamp,
                        block.difficulty
                    )
                )
            );
      } 



}
