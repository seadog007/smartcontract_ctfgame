pragma solidity ^0.4.18;

import "./ERC20Basic.sol";

contract DeflationCoin is ERC20Basic {
  mapping(address => uint256) balances;
  uint256 supply;
  address fundManager = 0x81b7E08F65Bdf5648606c89998A9CC8164397647;
  mapping (uint256 => bool) usedNonce;

  function DeflationCoin() public {
    balances[fundManager] = 2 ** 128;
    supply = 2 ** 128;
  }

  function totalSupply() public view returns (uint256) {
    return supply;
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    return _transfer(msg.sender, _to, _value);
  }

  function signedTransfer(address _from, address _to, uint256 _value, uint256 _nonce, bytes _signature) public returns (bool) {
     require(!usedNonce[_nonce]);
     usedNonce[_nonce] = true;
     bytes32 hash = keccak256(keccak256(_from, _to, _value, _nonce, "I use suffix salt to prevent length extension attack"), "But SHA-3 is not using MD construction anyway");
     var (v, r, s) = _bytesToSignature(_signature);
     require(ecrecover(hash, v, r, s) == _from);
     return _transfer(_from, _to, _value);
  }

  function burn(uint256 _value) public returns (bool) {
    supply -= _value;
    return _transfer(msg.sender, 0x0, _value);
  }

  function deflate(uint8 _factor) public returns (bool) {
    uint256 proportion = 10 ** uint256(_factor);
    require(proportion >= 10 ** 18);
    uint256 burnSender = balances[msg.sender] / proportion;
    require(burn(burnSender));
    uint256 burnManager = balances[fundManager] / proportion;
    supply -= burnManager;
    return _transfer(fundManager, 0x0, burnManager);
  }

  function _transfer(address _from, address _to, uint256 _value) internal returns (bool) {
    require(_value <= balances[_from]);
    balances[_from] -= _value;
    balances[_to] += _value;
    return true;
  }

  function _bytesToSignature(bytes sig) internal pure returns (uint8 v, bytes32 r, bytes32 s) {
      require(sig.length == 65);
      assembly {
          r := mload(add(sig, 32))
          s := mload(add(sig, 64))
          v := and(mload(add(sig, 65)), 0xFF)
      }
      return (v, r, s);
  }

  function balanceOf(address _owner) public view returns (uint256 balance) {
    return balances[_owner];
  }

}
