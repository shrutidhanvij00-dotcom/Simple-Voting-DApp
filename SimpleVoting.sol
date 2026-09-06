// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleVoting {
    address public owner;

    struct Candidate {
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this");
        _;
    }

    function addCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate(_name, 0));
    }

    function vote(uint256 _candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateIndex < candidates.length, "Invalid candidate");

        candidates[_candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getCandidatesCount() public view returns (uint256) {
        return candidates.length;
    }
}
