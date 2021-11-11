// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract StateVariables {
  string public name;
  bool public isWorking; 
  uint public age;
  address public owner;

  constructor(string memory _name, bool _isWorking, uint _age, address _owner)  {
    name = _name;
    isWorking = _isWorking;
    age = _age;
    owner = _owner;
  }
}