// SPDX-License-Identifier: MIT
pragma solidity > 0.4.23 < 0.9.0;

contract CampaignFactory {
  Campaign[] public deployedCampaigns;

  function createCampaign(uint minimum) public {
    Campaign newCampaign =  new Campaign(minimum, msg.sender);
    deployedCampaigns.push(newCampaign);
  }

  function getDeployedCampaigns() public view returns (Campaign[] memory) {
    return deployedCampaigns;
  }
}


contract Campaign {
  struct Request {
    uint256 id;
    string description;
    uint value;
    address payable recipient;
    bool complete;
    uint approvalCount;
    mapping(address => bool)  approvals;
  }

  //Request[] public requests;
  mapping(uint256 => Request) public requests;
  address public manager;
  uint public minimumContribution;
  mapping(address => bool) public approvers;
  uint public approversCount;
  uint public nextRequest;

  modifier restricted(){
    require (msg.sender == manager);
    _;
  }

  constructor(uint minimum, address creator) {
    manager = creator;
    minimumContribution = minimum;
    nextRequest = 1;
  }

  function contribute() public payable {
    require(msg.value > minimumContribution);

    approvers[msg.sender] = true;
    approversCount++;
  }

  function createRequest(string memory _description, uint  _value, address payable _recipient) 
  public restricted {
        Request storage newRequest = requests[nextRequest];
        newRequest.id = nextRequest;
        newRequest.description = _description;
        newRequest.value = _value;
        newRequest.recipient = _recipient;
        newRequest.complete = false;
        newRequest.approvalCount = 0;

        //requests.push(newRequest);
        nextRequest++;
  }

  function approveRequest(uint index) public {
    Request storage request = requests[index];

    require(approvers[msg.sender]);
    require(!request.approvals[msg.sender]);

    request.approvals[msg.sender] = true;
    request.approvalCount++;
  }

  function finalizeRequest(uint index) public restricted{
    Request storage request = requests[index];

    require(request.approvalCount > (approversCount / 2));
    require(!request.complete);

    request.recipient.transfer(request.value);
    request.complete = true;
  }
  
}

