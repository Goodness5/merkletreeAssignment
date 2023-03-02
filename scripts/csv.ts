import * as fs from "fs";
import { MerkleTree } from "merkletreejs";
import { keccak256 } from "crypto-js";

interface AirdropData {
  address: string;
  amount: number;
}

// Read the CSV file and parse its contents into an array of AirdropData objects
const csvData: string = fs.readFileSync("airdrop_data.csv", "utf-8");
const airdropData: AirdropData[] = csvData
  .trim()
  .split("\n")
  .slice(1) // Skip header row
  .map((row) => {
    const [address, amount] = row.split(",");
    return { address, amount: parseInt(amount) };
  });

// Create a Merkle tree from the airdrop data
const leaves = airdropData.map((data) => {
  const hash = keccak256(
    `${data.address.toLowerCase()}${data.amount.toString()}`
  ).toString("hex");
  return Buffer.from(hash, "hex");
});
const tree = new MerkleTree(leaves, keccak256);

// Write the Merkle tree to a JSON file
const treeData = JSON.stringify(tree.toJSON(), null, 2);
fs.writeFileSync("merkle_tree.json", treeData, "utf-8");

// Write the airdrop data to a JSON file
const airdropDataJson = JSON.stringify(airdropData, null, 2);
fs.writeFileSync("airdrop_data.json", airdropDataJson, "utf-8");

// Deploy the root hash to the smart contract
const rootHash = tree.getRoot().toString("hex");
// ...deploy rootHash to the smart contract
