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

contract MultipleCoin is ERC20Basic {
  mapping(address => uint256) balances;

  function totalSupply() public view returns (uint256) {
    return 0;
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_value <= balances[msg.sender]);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function transfers(address[] _to, uint256[] _value) public returns (bool) {
    require(_to.length > 0);
    require(_to.length == _value.length);
    uint256 sum = 0;
    for(uint256 i = 0; i < _to.length; i++){   
      sum += _value[i];
      balances[_to[i]] += _value[i];
    }
    require(sum <= balances[msg.sender]);
    balances[msg.sender] -= sum;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint256 balance) {
    return balances[_owner];
  }

}

// Call MultipleCoin.transfers(["Your_address","Another_address"],["115792089237316195423570985008687907853269984665640564039457584007913129639935",1])
