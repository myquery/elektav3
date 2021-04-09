// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;



import "./ElektaMain.sol";

contract ElektaGroups {

    uint public groupCount = 0;

    // struct GroupDetails {
    //     uint public _groupId;
    //     address 
    // }

    mapping(uint => address) private elektagroups;

    constructor() public {

     
    }

    function addToGroup(address payable _addr, uint256 _groupId) public returns (uint256) {
        require(_addr == address(0), "Only valid account can become members");
        elektagroups[_groupId] = _addr;
        groupCount += 1;
    }
   

}