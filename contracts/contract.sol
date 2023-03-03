// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

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

    bytes32 leaf = keccak256(abi.encodePacked(_claimer, _amount));

    // Verify the proof
    require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid proof");

    // Update claimer's state
    claimers[_claimer].amount = _amount;
    claimers[_claimer].claimed = true;

    return true;
}




}
