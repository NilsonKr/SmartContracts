// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract CrowdFundingSmartContract {
    address payable projectOwner;
    string public projectName = "Dummie Project";
    string public projectState = "Closed";
    uint public funds;
    uint public fundRaisingGoal;
    
    constructor(string memory _name, string memory state, uint fundsGoal){
        projectOwner = payable(msg.sender);
        projectName = _name;
        projectState = state;
        fundRaisingGoal = fundsGoal;
    }

    event ProjectFunded(address from, uint funds);
    event ProjectStateChanged(string newState, string oldState);

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
        emit ProjectFunded(msg.sender, msg.value);
    }

    function changeProjectState (string memory newState) public onlyOwner {
        string memory oldProjectState = projectState;
        projectState = newState;
        emit ProjectStateChanged(projectState, oldProjectState);
    }
}