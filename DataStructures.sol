// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DataStructures { 
    enum State { Alive,  Dead}
    
    struct SchrodingerCat {
        string name;
        State catState;    
    }
    
    mapping (address => SchrodingerCat) public cats; 
    
    
    function createCat(string calldata name, State initialState) public returns(SchrodingerCat memory newCat){
        newCat = SchrodingerCat(name, initialState);
        cats[msg.sender] = newCat;
    }
    
    function changeCatState(State newState) public returns(SchrodingerCat memory){
        SchrodingerCat storage foundCat = cats[msg.sender];
        foundCat.catState = newState;
        return foundCat;
    }
    
    function getCat() public view returns(SchrodingerCat memory){
        SchrodingerCat memory foundCat = cats[msg.sender];
        return foundCat;
    }
    
}