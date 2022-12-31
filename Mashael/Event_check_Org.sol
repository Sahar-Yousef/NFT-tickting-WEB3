// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Event{

        address public Organizer;
        
         constructor () {
                Organizer = msg.sender;
            }
            modifier onlyOrganizer(){
                require(msg.sender == Organizer, "not Organizer");
                _;
            }

            function setOrganizer(address _newOrganizer) external onlyOrganizer{
                require (_newOrganizer != address(0) , "Invalid address");
                Organizer = _newOrganizer;
            }

        
        struct EventData{
        // string name of the event
        string  EventName;      
        // Event Description
        string  EventDescription;
        // total number of tickets offered
        uint NumTickets;
        // Event date
        uint256 EventDate;
        // // number of tickets remaining
        // uint256 RemainingTickets;
    }


    // All events
     EventData[] public events;

    // Called each time an event is created 
    event EventCreated(uint256 indexed EventId);
    

    function Create_Event (string calldata _EventName, string calldata _EventDescription, uint  _NumTickets, uint256 _EventDate )  external onlyOrganizer returns(uint256) {
        // check for exist event 
        // check number of ticket ( not = 0 )

        uint256 EventId = events.push(EventData(_EventName, _EventDescription, _NumTickets, _EventDate));
        emit EventCreated (EventId);
        return EventId;
    }
}
