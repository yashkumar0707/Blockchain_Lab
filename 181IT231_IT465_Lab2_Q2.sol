pragma solidity >=0.5.0 ;

contract CryptoFlightFactory {
    CryptoFlight[] public deployedFlights;

    function createFlight(uint256 minimumBid, string memory departure, string memory destination) public {
        CryptoFlight flight = new CryptoFlight(minimumBid, departure, destination, msg.sender);
        deployedFlights.push(flight);
    }

    function getDeployedFlights() public view returns (CryptoFlight[] memory) {
        return deployedFlights;
    }
}

contract CryptoFlight {
    struct Traveller {
        uint256 bid;
        address payable user;
        bool approved;
    }

    Traveller[] public travellers;
    address payable creator;
    uint256 minBid;
    string departure;
    string destination;
    bool finalized;

    modifier auth() {
        require(msg.sender == creator);
        _;
    }

    constructor(uint256 _minBid, string memory _departure, string memory _destination, address payable _creator) public payable {
        creator = _creator;
        minBid = _minBid;
        departure = _departure;
        destination =  _destination;
        finalized = false;
    }

    function getFlight() public view returns(address, uint256, string memory, string memory, bool) {
        return (creator, minBid, departure, destination, finalized);
    }

    function addTraveller() public payable {
        require(msg.value >= minBid);
        
        address payable user = msg.sender;
        
        Traveller memory newTraveller = Traveller({
           user: user,
           bid: msg.value,
           approved: false
        });

        travellers.push(newTraveller);
    }

    function finalizeFlight(uint64 _seats) public auth payable{
        uint64 seatsFilled = 0;

        while (seatsFilled < _seats && seatsFilled < travellers.length) {
            uint256 currentHighestBid = 0;
            uint64 currentHighestId = 0;

            for (uint16 i = 0; i < travellers.length; i++) {
                if (currentHighestBid < travellers[i].bid && !travellers[i].approved) {
                    currentHighestBid = travellers[i].bid;
                    currentHighestId = i;
                }
            }

            travellers[currentHighestId].approved = true;

            seatsFilled++;
        }

        for (uint16 i = 0; i < travellers.length; i++) {
            if (travellers[i].approved) {
                address payable _creator = creator;
                _creator.transfer(travellers[i].bid);
            } else {
                // Traveller storage traveller = travellers[_seats];
                // address payable user = traveller.user;
                travellers[i].user.transfer(travellers[i].bid);
            }
        }
        finalized = true;
    }
}