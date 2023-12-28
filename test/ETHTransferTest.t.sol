// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {PuppyRaffle} from "../src/PuppyRaffle.sol";

contract ETHTransferTest is Test {
    PuppyRaffle puppyRaffle;
    uint256 entranceFee = 1e18;
    address playerOne = address(1);
    address playerTwo = address(2);
    address playerThree = address(3);
    address playerFour = address(4);
    address feeAddress = address(99);
    uint256 duration = 1 days;

    function setUp() public {
        puppyRaffle = new PuppyRaffle(entranceFee, feeAddress, duration);
    }

    function testCanSendMoneyToRaffle() public {
        address senderAddr = makeAddr("sender");
        vm.deal(senderAddr, 1 ether);
        assertEq(address(senderAddr).balance, 1 ether);

        // No fallback, No receive()
        vm.expectRevert();
        vm.prank(senderAddr);
        (bool success, ) = payable(address(puppyRaffle)).call{value: 1 ether}(
            ""
        );
        require(success);
    }
}
