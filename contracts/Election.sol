pragma solidity ^0.4.2;

contract Election {

	// Model a Candidate
	struct Candidate{
		uint id;
		string name;
		uint votecount;
	}

	// Store a Candidate
	// Fetch a Candidate
	mapping(uint => Candidate) public candidates;

	// Store Candidates count
	uint public candidatesCount;

	mapping(address => bool) public voters;

	event votedEvent (
        uint indexed _candidateId
    );

	function Election () public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function addCandidate (string _name) private {
		candidatesCount++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

	function vote(uint _candidateId) public {
		require(!voters[msg.sender]);

		require(_candidateId > 0 && _candidateId <= candidatesCount);

		voters[msg.sender] = true;

		candidates[_candidateId].votecount++;

		// trigger voted event
        votedEvent(_candidateId);
	}
}