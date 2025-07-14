// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Collateral.sol";

/// @author Gabriel Ungur
/// @notice This contract defines the loaning logic. The user can loan a given amount.
contract Lender{

    // TODO: After Ledger.sol -> Borrower.sol, must add field logic

    // Events
    event ContractDeployed(address deployer);
    event LoanSent(address payable sentFrom, address payable sentTo, uint256 amount, uint256 collateral_Id);

    /// @dev This function is only called once, when the contract is deployed.
    constructor() {
        emit ContractDeployed(msg.sender);
    }

    /// @notice Function to send loan to a borrower
    function sendToBorrower(address payable _from, address payable _to, uint256 _amount, uint256 _collateral_Id) external payable {
        // Step 1: Ensure that the sender has enough ETH
        require (msg.value >= _amount, "Insufficient funds! Add more ETH");
        
        // Step 2: Send funds
        _to.transfer(_amount);

        emit LoanSent(_from, _to, _amount, _collateral_Id); // Log transaction
    }




}