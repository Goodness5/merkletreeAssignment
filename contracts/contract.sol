// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Airdrop {
    
    // State variables
    struct Claimer {
        uint amount;
        bool claimed;
    }
    mapping (address => Claimer) public claimers;
    bytes32 public merkleRoot;
    
    // Constructor to set the merkle root
    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }
    
    // Function to claim the airdrop
    function claimAirdrop(bytes32[] memory _proof) public {
        require(!claimers[msg.sender].claimed, "Airdrop already claimed");
        require(_verifyProof(_proof, msg.sender), "Invalid proof");
        claimers[msg.sender].claimed = true;
        claimers[msg.sender].amount = 1000; // Set the amount of the airdrop for the claimer
        // ...transfer tokens to the claimer's address
    }
    
    // Function to verify the merkle proof
    function _verifyProof(bytes32[] memory _proof, address _claimer) internal view returns (bool) {
        bytes32 leaf = keccak256(abi.encodePacked(_claimer));
        bytes32 currentHash = leaf;
    
        for (uint256 i = 0; i < _proof.length; i++) {
            bytes32 proofElement = _proof[i];
    
            if (currentHash < proofElement) {
                currentHash = keccak256(abi.encodePacked(currentHash, proofElement));
            } else {
                currentHash = keccak256(abi.encodePacked(proofElement, currentHash));
            }
        }
    
        return currentHash == merkleRoot;
    }
}
