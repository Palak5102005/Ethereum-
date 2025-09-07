
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title Ethereum DEX (Improved Version)
/// @notice Decentralized Exchange with Goerli support
/// @dev Updated from original repo: upgraded Solidity, added events, cleaner logic
contract Exchange {
    address public feeAccount; // account that receives exchange fees
    uint256 public feePercent; // fee percentage

    // token => user => balance
    mapping(address => mapping(address => uint256)) public tokens;

    event Deposit(address indexed token, address indexed user, uint256 amount, uint256 balance);
    event Withdraw(address indexed token, address indexed user, uint256 amount, uint256 balance);

    constructor(address _feeAccount, uint256 _feePercent) {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }

    /// @notice Deposit ERC20 tokens into the DEX
    function depositToken(address _token, uint256 _amount) external {
        require(_token != address(0), "Invalid token");
        require(_amount > 0, "Amount must be > 0");

        bool success = IERC20(_token).transferFrom(msg.sender, address(this), _amount);
        require(success, "Token transfer failed");

        tokens[_token][msg.sender] += _amount;
        emit Deposit(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }

    /// @notice Withdraw ERC20 tokens from the DEX
    function withdrawToken(address _token, uint256 _amount) external {
        require(tokens[_token][msg.sender] >= _amount, "Insufficient balance");
        require(_amount > 0, "Amount must be > 0");

        tokens[_token][msg.sender] -= _amount;

        bool success = IERC20(_token).transfer(msg.sender, _amount);
        require(success, "Token transfer failed");

        emit Withdraw(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }

    /// @notice Get balance of a user for a token
    function balanceOf(address _token, address _user) external view returns (uint256) {
        return tokens[_token][_user];
    }
}
