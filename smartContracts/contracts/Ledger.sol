// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @notice This file stores all the data related to tickets (i.e. owners, lenders)

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Collateral.sol";

contract Ledger is Ownable{

    // Fields
    mapping (address => uint256[]) borrowerToTickets; // Mapping from person who published loan -> loan ticket(s)
    mapping (uint256 => address) ticketToLender; // Mapping from a loan ticket -> Lender (Person who sent money to the owner of that ticket)

    // Events
    event LedgerPublished(address founder, string message);

    constructor() {
        emit LedgerPublished(owner(), "Ledger has been published by Gabriel.");
    }
}