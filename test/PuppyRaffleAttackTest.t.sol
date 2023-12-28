// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {PuppyRaffle} from "../src/PuppyRaffle.sol";

contract PuppyRaffleAttackTest is Test {
    PuppyRaffle puppyRaffle;
    uint256 entranceFee = 1e18;
    
}