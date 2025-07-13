// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @notice This file stores all the data related to creating a ticket.

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Collateral.sol";

contract Ticket is Ownable{

    // Fields
    address createdBy;
    
    address collateralContract;
    address tokenId; // Stores ID for the collateral item

    uint256 unique_Id;
    uint256 loanAmount;

    // Events 
    event ChangedCollateralContractAddress(address contractAddress);


    constructor () {
        setCollateralContractAddress(12345); // TODO: ADD VALUE
    }

    /// @dev Only the owner can set the address to the collateral contract
    function setCollateralContractAddress(address _contractAddress) onlyOwner() public {
        emit ChangedCollateralContractAddress(_contractAddress);
        collateralContract = _contractAddress;
    }


    
    




}