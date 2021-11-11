// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Asset {
  string public assetName;

  event NameChanged(string newName, string oldName, address by);

  function changeName(string memory newName) public  {
    string memory oldName = assetName;
    assetName = newName;
    emit NameChanged(newName, oldName, msg.sender);
  } 
} 