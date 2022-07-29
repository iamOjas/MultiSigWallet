// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./MultiSigWallet.sol";

contract AdminRegistry {
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this");
        _;
    }

    address immutable admin;
    MultiSigWallet public multiSigWallet;

    constructor() {
        admin = msg.sender;
    }

    function addContractAddress(address payable _multiSigWallet)
        external
        onlyAdmin
    {
        multiSigWallet = MultiSigWallet(_multiSigWallet);
    }

    function changeOwnerStatus(
        address[] memory _owners,
        bool[] memory _status,
        uint256 _numConfirmationsRequired
    ) public {
        multiSigWallet.getOwners(_owners, _status, _numConfirmationsRequired);
    }
}
