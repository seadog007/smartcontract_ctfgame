pragma solidity ^0.4.6;

contract Donationbox {

    uint private prev;
    uint private temp;

    constructor() public {
        prev = now;
    }

    function donate() public payable{
        temp = now;
        require(temp - prev > 500 && msg.value <= 5 && msg.value > 0);
        prev = temp;
    }

    function () public payable{
        revert();
    }
}
