// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Airdrop {
    bytes32 public merkleRoot;
    bytes32[] private proof;

    constructor(bytes32 root, bytes32[] memory _proof) {
        // Read the Merkle root from the JSON file
        // string memory rootJson = type(Name).creationCode;
        // bytes memory rootData = abi.encodePacked(bytes(rootJson)[108:140]);

        // assembly {
        //     merkleRoot := mload(add(rootData, 32))
        // }
    merkleRoot = root;
    proof = _proof;
    }

    // State variables
    
    struct Claimer {
        uint256 amount;
        bool claimed;
    }
    mapping(address => Claimer) public claimers;

    function claimAirdrop(address _claimer, uint256 _amount) external returns (bool _claimed) {
    require(!claimers[_claimer].claimed, "Already claimed");

    // Generate proof for the claimer
    bytes32 leaf = keccak256(abi.encodePacked(_claimer, _amount));
    // bytes32[] memory proof = tree.getProof(leaf);

    // require(checkClaim(_claimer, _amount, proof), "Invalid proof");

    // Update claimer's state
    claimers[_claimer].amount = _amount;
    claimers[_claimer].claimed = true;

    return true;
}

function checkClaim(address _claimer, uint256 _amount, bytes32[] memory _proof) public view returns (bool) {
    bytes32 leaf = keccak256(abi.encodePacked(_claimer, _amount));
    bytes32 currentHash = leaf;

    for (uint256 i = 0; i < _proof.length; i++) {
        bytes32 proofElement = _proof[i];

        if (currentHash < proofElement) {
            currentHash = keccak256(abi.encodePacked(currentHash, proofElement));
        } else {
            currentHash = keccak256(abi.encodePacked(proofElement, currentHash));
        }
    }

    // Compare the calculated root hash with the stored root hash
    return currentHash == merkleRoot;
}

}
