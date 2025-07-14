// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @notice This file stores all the data related to tickets (i.e. owners, lenders)

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Ticket.sol";

contract Ledger is Ownable {

    // Fields
    address public ticketFactory; // Store address of "TicketFactory.sol"
    mapping (address => Ticket[]) ownerToTickets; // Mapping from person who wants loan -> loan ticket(s)
    mapping (uint256 => address) ticketToLender; // Mapping from a loan ticket -> Lender

    // Events
    event LedgerPublished(address founder, string message);
    event NewTicketStored(address payable owner, Ticket ticket);
    event TicketFactoryAddressChanged(address ticketFactory);

    constructor(address _ticketFactoryAddress) Ownable(msg.sender) {
        emit LedgerPublished(owner(), "Ledger has been initialized by Gabriel.");
        setTicketFactoryAddress(_ticketFactoryAddress);
    }

    /// @dev Only the owner can set the address to the ticket factory contract
    function setTicketFactoryAddress(address _address) onlyOwner() public {
        emit TicketFactoryAddressChanged(_address);
        ticketFactory = _address;
    }

    /// @dev Adds new ticket to "ownerToTicket"
    function appendNewTicket(address payable _owner, Ticket memory _ticket) public {
        // This function can only be called from "TicketFactory.sol" after we create a ticket.
        require(msg.sender == address(ticketFactory), "Unauthorized. You cannot append to the ledger manually.");

        ownerToTickets[_owner].push(_ticket);
        emit NewTicketStored(payable(_owner), _ticket);
    }
}