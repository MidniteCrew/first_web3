// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @notice This file defines the ticket object,

struct Ticket {
    address payable createdBy;
    address collateralId; // Stores ID for the collateral item
    uint256 id;
    uint256 loanAmount;
}
