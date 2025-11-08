// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Decentralized File Storage (IPFS)
 * @dev A simple contract to store and retrieve IPFS file hashes on Ethereum.
 */
contract Project {
    struct File {
        string ipfsHash;
        string fileName;
        uint256 timestamp;
    }

    mapping(address => File[]) private userFiles;

    event FileUploaded(address indexed user, string fileName, string ipfsHash, uint256 time);

    /**
     * @notice Uploads a new file to the contract.
     * @param _fileName Name of the uploaded file.
     * @param _ipfsHash The IPFS hash returned from IPFS network.
     */
    function uploadFile(string memory _fileName, string memory _ipfsHash) public {
        require(bytes(_ipfsHash).length > 0, "Invalid IPFS hash");
        require(bytes(_fileName).length > 0, "Invalid file name");

        userFiles[msg.sender].push(File(_ipfsHash, _fileName, block.timestamp));
        emit FileUploaded(msg.sender, _fileName, _ipfsHash, block.timestamp);
    }

    /**
     * @notice Returns all files uploaded by the user.
     */
    function getMyFiles() public view returns (File[] memory) {
        return userFiles[msg.sender];
    }

    /**
     * @notice Returns the total number of files uploaded by the user.
     */
    function getMyFileCount() public view returns (uint256) {
        return userFiles[msg.sender].length;
    }
}
