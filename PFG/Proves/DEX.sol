//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DEX {

        IERC20 tokenERC;

        uint256 public total_liquidity;
        mapping (address => uint256) public liquidity;

        event Initialize (uint256 _value);
        event TokensSwapped (uint256 _value);
        event ETHSwapped (uint256 _value);
        event Deposit (uint256 _value);
        event Withdraw (uint256 _valueETH, uint256 _valueToken);

        function initialize(address token_address, uint256 token_amount) external payable {
                require(total_liquidity == 0);

                tokenERC = IERC20(token_address);

                total_liquidity = address(this).balance;
                liquidity[msg.sender] = total_liquidity;

                require(tokenERC.transferFrom(msg.sender, address(this), token_amount));

                emit Initialize(total_liquidity);
        }

        function calculatePrice(uint256 input_value, uint256 input_pool, uint256 output_pool) internal pure returns (uint256) {
                return (input_value * output_pool) / (input_pool + input_value);
        }

        function ethToErc() external payable {
                uint256 tokens_swapped = calculatePrice(msg.value, (address(this).balance - msg.value), tokenERC.balanceOf(address(this)));

                require(tokenERC.transfer(msg.sender, tokens_swapped));

                emit TokensSwapped(tokens_swapped);
        }

        function ercToEth(uint256 token_amount) external {
                uint256 eth_swapped = calculatePrice(token_amount, tokenERC.balanceOf(address(this)), address(this).balance);

                (bool success, ) = msg.sender.call{value: eth_swapped}("");
                require(success, "Transfer failed.");    

                require(tokenERC.transferFrom(msg.sender, address(this), token_amount));

                emit ETHSwapped(eth_swapped);
        }

        function deposit() external payable {
                uint256 token_amount = ((msg.value * tokenERC.balanceOf(address(this))) / (address(this).balance - msg.value)) + 1;
                uint256 liquidity_added = (msg.value * total_liquidity) / (address(this).balance - msg.value);

                liquidity[msg.sender] += liquidity_added;
                total_liquidity += liquidity_added;

                require(tokenERC.transferFrom(msg.sender, address(this), token_amount));

                emit Deposit(liquidity_added);
        }

        function withdraw(uint256 value) external {
                uint256 eth_value = (value * address(this).balance) / total_liquidity;
                uint256 token_value = (value * tokenERC.balanceOf(address(this))) / total_liquidity;

                liquidity[msg.sender] -= eth_value;
                total_liquidity -= eth_value;

                (bool success, ) = msg.sender.call{value: eth_value}("");
                require(success, "Transfer failed.");    

                require(tokenERC.transfer(msg.sender, token_value));

                emit Withdraw(eth_value, token_value);
        }

        function getTokenBalance() external view returns (uint256) {
                return tokenERC.balanceOf(address(this));
        }

        function getBalance() external view returns (uint256) {
                return address(this).balance;
        }
}