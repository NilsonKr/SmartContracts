// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Transfer {

  function transaction(address payable _to) public payable{
    _to.transfer(msg.value);
  }

}