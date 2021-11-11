// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract  Loop {
    uint[] public numsList;
    
    constructor(){
        for(uint i=0; i <= 10; i++){
            numsList.push(i);
        }
    }

    function getList() public view returns(uint[] memory) {
        return numsList;
    }
}