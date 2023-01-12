// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract FaisalEvent {
    address public Organizer;

    constructor() {
        Organizer = msg.sender;
    }

   struct Event {
    uint id;
    address owner;
    string name; // byte
    uint date; // timestap 
    uint ticketPrice;
    uint ticketCount;
    uint ticketRemaining;
    uint Max;
  }
  mapping(uint => Event) public events;
  mapping(address => mapping(uint => uint)) public tickets;
  uint public eventId ;
                         //= 100    
  event EventLog ( address Organizer, uint id);

  // add max here 
                            //memory
  function createEvent( string calldata eventName, uint eventDate, uint price, uint eventCapacity, uint Max) external  {
    require(eventCapacity > 0, 'Minimum capacity (ticket count) should be 1.'); // using interface
    require( msg.sender == Organizer ); // to check organizer address
    events[eventId] = Event(eventId, msg.sender, eventName, eventDate, price, eventCapacity, eventCapacity, Max);
    emit EventLog ( msg.sender, eventId);
    eventId++;
          
  }

                            
  function buyTicket(uint id, uint NumOfTicket) eventExists(id)  payable external {
    require(msg.value >= (events[id].ticketPrice * NumOfTicket), 'Not enough ETH is sent to pay the tickets.');
    require(NumOfTicket <= 2, 'This is Maximum limit'); // for this address check
    require(tickets[msg.sender][id] <= NumOfTicket  , 'Number of ticket is max');//
    require(events[id].ticketRemaining >= NumOfTicket, 'Not enough tickets.');

    events[id].ticketRemaining -= NumOfTicket;
    tickets[msg.sender][id] += NumOfTicket; //++
   
    // Creat it as NFT Tick  
    // OpenZipplen 
  }


  function getAllEvents() external view returns (Event[] memory){
    Event[] memory eventArray = new Event[](eventId);
    for (uint i = 0; i < eventId; i++) {
        eventArray[i] = events[i];
    }
    return eventArray;
  }

  modifier eventExists(uint id) {
    require(events[id].date != 0, 'Event does not exist.');
    _;
  }

}
