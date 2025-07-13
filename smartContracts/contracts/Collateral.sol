// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/// @notice This code allows the user to create fake NFT's to represent collateral. This collateral
///         can be "house, car etc..".

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Collateral is ERC721 {

    constructor() ERC721("Collateral NFT", "CLT") {}


}

