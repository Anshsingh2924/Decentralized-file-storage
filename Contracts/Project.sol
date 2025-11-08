// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FileStorage {
    struct File {
        string ipfsHash;
        string fileName;
        uint256 timestamp;
    }

    mapping(address => File[]) public userFiles;

    event FileUploaded(address indexed user, string ipfsHash, string fileName, uint256 timestamp);

    function uploadFile(string memory _ipfsHash, string memory _fileName) public {
        userFiles[msg.sender].push(File(_ipfsHash, _fileName, block.timestamp));
        emit FileUploaded(msg.sender, _ipfsHash, _fileName, block.timestamp);
    }

    function getMyFiles() public view returns (File[] memory) {
        return userFiles[msg.sender];
    }
}
