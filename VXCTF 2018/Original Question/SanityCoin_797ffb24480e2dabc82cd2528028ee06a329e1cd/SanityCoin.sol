pragma solidity ^0.4.18;

import "./ERC20Basic.sol";

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