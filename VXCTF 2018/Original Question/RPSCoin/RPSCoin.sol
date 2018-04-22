pragma solidity ^0.4.18;

import "./ERC20Basic.sol";

contract RPSCoin is ERC20Basic {
  uint256 wins = 0;
  address owner;
  
  function RPSCoin() public {
    owner = msg.sender;
  }

  function totalSupply() public view returns (uint256) {
    return wins;
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    uint8 yourMove = uint8(_value % 3);
    uint8 myMove = uint8(random(wins + uint256(_to))) % 3;
    if(wins >= 20){
      myMove = uint8(_value + 1) % 3;
    }
    if(yourMove == myMove){
      return true;
    }else if((yourMove + 1) % 3 == myMove){
      wins = 0;
      return true;
    }else{
      wins += 1;
    }
  }

  function balanceOf(address _owner) public view returns (uint256 balance) {
    if (owner == _owner && wins >= 21) {
      return 1;
    }
    return 0;
  }
  
  function random(uint256 _nonce) public view returns (uint256){
    return uint256(keccak256(_nonce, block.blockhash(block.number-1)));
  }
  
}