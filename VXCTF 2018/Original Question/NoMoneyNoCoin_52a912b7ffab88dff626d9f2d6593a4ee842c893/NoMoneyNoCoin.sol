pragma solidity ^0.4.18;

import "./ERC20Basic.sol";

contract NoMoneyNoCoin is ERC20Basic {
  address owner;

  function NoMoneyNoCoin() public {
    owner = msg.sender;
  }

  function totalSupply() public view returns (uint256) {
    return address(this).balance;
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    require(owner == msg.sender);
    require(_value <= address(this).balance);
    return _to.send(_value);
  }

  function balanceOf(address _owner) public view returns (uint256 balance) {
    if (owner == _owner) {
      return address(this).balance;
    }
    return 0;
  }
}