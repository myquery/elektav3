// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;


import "./IGroups.sol";
import "./IGroupSchema.sol";
import "./ElektaGroups.sol";
import "./ElektaProjects.sol";

contract ElektaMain is IGroupSchema{
   address public owner;


   uint projectCount = 0;

   uint256 groupCount = 0;

   address[] private projectAddress;

   
   event ProjectCreated(string _projectName);

   event FundProject(address _projectAddress, FundAlert alert, uint256 amount);

   enum FundAlert{Funded, WithDrawned, Suspecded}

   struct ProjectDetail {
       address _projectAddress;
       string _projectName;
       string _projectDesc;
   }

 
   struct ElektaGroup {
      Group _groupByXend;
      ProjectDetail _elektaProjectDetails;
   }


   IGroups private xendAddress;
   // address private xendAddress2 = 0x41E95e88c0dCEaCe4159f4118217B67038aaE6F0;
   // address private xendAddressCooperative = 0x21d635b36F54E70b578eAd19448BFa2bB73F96E2;

    ElektaGroups public _elektaGroup;

   mapping(address => ProjectDetail ) public elektaProjects;

   mapping(address => mapping(address => uint256)) public fundProject;

   mapping(uint256 => ElektaGroup) public elektaGroup;

   //bytes32 public constant INIT_CODE_PAIR_HASH = keccak256(abi.encodePacked(type(UniswapV2Pair).creationCode));
   //git clone https://github.com/Uniswap/uniswap-interface.git

   constructor() public {
       owner = msg.sender;
      //  xendAddress  =  IGroups(0x7B2d6633F56c05F76409aE236A2036F07232BBFA);
       xendAddress  =  IGroups(0x2060Fe1Ae5EF46421E142f14f703b81ea816615b);
       _elektaGroup = new ElektaGroups();
       

   }

   //create new project

   /// @dev Create a new project for the group.
    /// @param projectName Project name.
    /// @param projectDesc Project descriptions.
   function createNewProject(string memory projectName, string memory projectDesc) public {
      ElektaProjects newProject = new ElektaProjects(projectName, projectDesc);
      elektaProjects[address(newProject)] = ProjectDetail(address(newProject), projectName, projectDesc);
      projectAddress.push(address(newProject));  
      emit ProjectCreated(projectName);     
      projectCount += 1;      

   }

      //create new Group

   /// @dev Create a new project for the group.
    /// @param _name Group name.
    /// @param _symbol Group descriptions.

   function createElektaGroup(
      string memory _name, 
      string memory _symbol) 
      public payable returns(uint256) {             
         //bring in instance of the xend group creation interface
         groupCount += 1;
         ElektaGroups _elektaGroup = new ElektaGroups();

         //address getGroupAddress = address(_elektaGroup);

         (uint256 lastId) = xendAddress.createGroup(_name, _symbol, address(_elektaGroup));

        // elektaGroup[groupCount] = ElektaGroup( Group(lastId, _name, _symbol, true, getGroupAddress ), ProjectDetail(address(0x0), "", "") );

         //return(Group(lastId, _name, _symbol, true, payable(getGroupAddress) ));

         return lastId;

   }



   //contribute to a group
   function fundAProject(address payable  _projectAddr, uint256 amount) public {
      uint256 funder = address(msg.sender).balance;
      uint256 receiver = address(_projectAddr).balance;
      if (funder <= amount) revert();
      funder -= amount;
      receiver += amount;  
      emit FundProject(_projectAddr, FundAlert.Funded, amount);

   }

   //join a group

   function joinAGroup(address payable _addr, uint _id) public {
          _elektaGroup.addToGroup(_addr, _id);
   }
}