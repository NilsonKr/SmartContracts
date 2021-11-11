// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract OwnerContract {
    address owner;
    string ownerSecret;


    constructor(string memory secret) {
      owner = msg.sender;
      ownerSecret = secret; 
    }

    modifier onlyOwner {
      require(msg.sender == owner, "Only owner can use this contract");
      _;
    }

    function getSecret() public view onlyOwner returns (string memory){
      return ownerSecret;
    }

    function setSecret(string memory newSecret) public onlyOwner returns (string memory, string memory) {
      string memory oldSecret = ownerSecret;
      ownerSecret = newSecret;
      return (ownerSecret, oldSecret);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}