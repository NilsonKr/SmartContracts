// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract CrowdFundingSmartContract {
    address payable projectOwner;
    string projectName = "Dummie Project";
    string projectState = "Closed";
    uint funds = 0;
    uint fundRaisingGoal = 0;
    
    constructor(string memory _name, string memory state, uint fundsGoal){
        projectOwner = payable(msg.sender);
        projectName = _name;
        projectState = state;
        fundRaisingGoal = fundsGoal;
    }

    modifier onlyOwner {
        require(msg.sender == projectOwner, "You need to be the project's owner");
        _;
    }

    modifier contributers {
        require(payable(msg.sender) != projectOwner, "You cannot contribute to your own project");
        _;
    }

    function fundProject() public payable contributers {
        projectOwner.transfer(msg.value);
        funds += msg.value;
    }

    function changeProjectState (string memory newState) public onlyOwner returns(string memory newProjectState) {
        projectState = newState;
        newProjectState = projectState;
    }
}