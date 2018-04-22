pragma solidity ^0.4.18;


/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

contract SanityCoin is ERC20Basic {
  mapping(address => uint256) balances;
  uint256 totalSupply_;
  string public constant name = "SanityCoin";
  string public constant symbol = "SANITYCOIN";

  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  function transfer(address, uint256) public returns (bool) {
    assert(false);
  }

  function balanceOf(address _owner) public view returns (uint256 balance) {
    return balances[_owner];
  }

  function () external payable {
    if (msg.value == 1984) {
      totalSupply_ = totalSupply_ + 1;
      balances[msg.sender] = balances[msg.sender] + 1;
    }
  }
}

// Call SanityCoin.(fallback) with 1984 wei