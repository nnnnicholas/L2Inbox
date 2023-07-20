// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

///@author nnnnicholas
contract Inbox {

    // Event emitted when a message is sent
    event MessageSent(
        address indexed sender,
        address indexed recipient,
        bytes32 indexed encryptedMessageHash,
        bytes32 plaintextHash,
        bytes encryptedMessage,
        uint256 amount
    );

    // Event emitted when a message is revealed
    event MessageRevealed(
        address indexed revealer,
        string plaintext
    );

    // Function to send a message
    function sendMessage(address recipient, bytes32 encryptedMessageHash, bytes calldata encryptedMessage, bytes32 plaintextHash) external payable {
        // Forward any ether sent with the transaction to the recipient
        (bool success, ) = payable(recipient).call{value: msg.value}("");
        require(success, "Payment failed");

        // Emit the event
        emit MessageSent(msg.sender, recipient, encryptedMessageHash, plaintextHash, encryptedMessage, msg.value);
    }

    // Function to reveal a message
    function revealMessage(string calldata plaintext) external {
        // Emit the event
        emit MessageRevealed(msg.sender, plaintext);
    }
}
