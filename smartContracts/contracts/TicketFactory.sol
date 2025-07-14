// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/**
  * @author Gabriel Ungur
  * @notice This file allows users to create tickets.
  */

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Collateral.sol";
import "./Ledger.sol";
import "./Ticket.sol";

contract TicketFactory is Ownable{

    // Fields
    Collateral public collateralContract;
    Ledger public ledger;

    // Events 
    event CollateralContractAddressChanged(address contractAddress);
    event TicketCreated(address payable createdBy, address collateralId, uint256 ticketID, uint256 loanAmount);
    event LedgerAddressChanged(address ledgerAddress);

    constructor (address _contractAddress, address _ledgerAddress)  Ownable(msg.sender) {
        setCollateralContractAddress(_contractAddress); 
        setLedgerAddress(_ledgerAddress);
    }

    /// @dev Only the owner can set the address to the collateral contract
    function setCollateralContractAddress(address _contractAddress) onlyOwner() public {
        emit CollateralContractAddressChanged(_contractAddress);
        collateralContract = Collateral(_contractAddress);
    }

    /// @dev Only the owner can set the address to the ledger
    function setLedgerAddress(address _ledgerAddress) onlyOwner() public {
        emit LedgerAddressChanged(_ledgerAddress);
        ledger = Ledger(_ledgerAddress);
    }

    /// @notice This allows "borrowers" to create a ticket
    function createTicket(address _collateralId, uint256 _loanAmount) external returns (Ticket memory){

        uint256 ticketID = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, _collateralId, _loanAmount)));

        Ticket memory newTicket = Ticket ({
            createdBy: payable(msg.sender),
            collateralId: _collateralId,
            id: ticketID,
            loanAmount: _loanAmount
        });

        // Add contract to ledger
        ledger.appendNewTicket(payable(msg.sender), newTicket);
        
        emit TicketCreated(payable(msg.sender), _collateralId, ticketID, _loanAmount);
        return newTicket;
    }
}