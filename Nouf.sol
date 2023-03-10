pragma solidity >=0.7.0 <0.9.0;
//version of solidity

contract Tickets {
    //Struct to store the event data
    struct EventData {
        //name of event
        string name;
        //name of event
        string description;
        //prive of the ticket of the event
        uint256 price;
        //The number of the total tickets
        uint256 totalTickets;
        //The number of available tickets
        uint256 remainingTickets;
        //The owner of this event
        address owner;
    }

    mapping(uint256 => EventData) public events;

    //function to retrive the data of a certain event
    function getEventData(uint256 event_id)
        external
        view
        returns (EventData memory)
    {
        return events[event_id];
    }
}
