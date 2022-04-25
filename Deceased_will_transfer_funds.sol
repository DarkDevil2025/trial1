//PRAGMA statement
pragma solidity ^0.5.7;

//We will be creating a contract that will pay out certain wallets a specified amount of money when the caller of this contract is deceased

//creating the contract

contract Will {
    bool deceased;
    uint fortune;
    address owner;

//adding a constructor

    constructor() payable public {
        deceased = false;
        fortune = msg.value;
        owner = msg.sender;
    }

//adding modifiers to check if conditions are met

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }


    modifier MustBeDeceased {
        require (deceased == true);
        _;
    }


//creating family wallets array to assign wallets that need to be transferred funds
    address payable [] familyWallets;


//mapping the amount that is to be transferred to each account

    mapping (address => uint) inheritance;


//adding a function to add a family wallet in the array and map the amount that is to be transferred
    function setInheritance(address payable wallet,uint amount) public onlyOwner {
        familyWallets.push(wallet) ;
        inheritance[wallet] = amount ;
    }

//creating a function that verifies if the owner of the contract is deceased and the funds are to be transferred
    function payout() private MustBeDeceased {
        for(uint i=0;i<familyWallets.length;i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

//a function that sets the deceased variable to true and executes payout

    function hasDeceased() public onlyOwner{
        deceased = true;
        payout();
    }
}
