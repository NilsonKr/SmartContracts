// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdFundingSmartContract {
    struct Project {
        address payable projectOwner;
        string  projectName;
        string  projectState;
        uint  funds;
        uint  fundRaisingGoal;
    }

    struct Contribution {
        address contributor;
        uint ammount;
        uint timestamp;
    }

    Project[] public projectList;

    mapping (string => Contribution[]) public fundsHistory;

    
    function createProject(string memory _projectName, uint _fundRaisingGoal) public payable returns(Project memory){
        Project memory project = Project({ 
            projectOwner: payable(msg.sender), 
            projectName: _projectName, 
            projectState: "Funding", 
            funds: 0, 
            fundRaisingGoal: _fundRaisingGoal 
        });
        projectList.push(project);
        return project;
    }

    event ProjectFunded(string projectName, Contribution contribution);
    event ProjectStateChanged(string newState, string oldState);

    modifier onlyOwner(uint index) {
        require(msg.sender == projectList[index].projectOwner, "You need to be the project's owner");
        _;
    }

    modifier contributers(uint index) {
        require(payable(msg.sender) != projectList[index].projectOwner, "You cannot contribute to your own project");
        _;
    }

    function fundProject(uint projIndex) public payable contributers(projIndex) {
        Project memory targetProject = projectList[projIndex];
        require(keccak256(abi.encodePacked(targetProject.projectState)) != keccak256(abi.encodePacked("Closed")), "The project is closed");
        require(msg.value > 0, "Cannot contribute with 0");

        Contribution memory newContribution = Contribution({
            contributor: msg.sender,
            ammount: msg.value,
            timestamp: block.timestamp
        }); 

        targetProject.projectOwner.transfer(msg.value);
        targetProject.funds += msg.value;
        
        projectList[projIndex] = targetProject;
        fundsHistory[targetProject.projectName].push(newContribution);

        emit ProjectFunded(targetProject.projectName, newContribution);
    }

    function changeProjectState (uint projIndex, string calldata newState) public onlyOwner(projIndex) {
        Project memory targetProject = projectList[projIndex];
        require(keccak256(abi.encodePacked(targetProject.projectState)) != keccak256(abi.encodePacked(newState)), "This is already the project state");
        
        string memory oldState = targetProject.projectState;
        targetProject.projectState = newState;

        projectList[projIndex] = targetProject;
        emit ProjectStateChanged(targetProject.projectState, oldState);
    }


    function getContributions(string memory projectName) public view returns(Contribution[] memory){
        return fundsHistory[projectName];
    }
}