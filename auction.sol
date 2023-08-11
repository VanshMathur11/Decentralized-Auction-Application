// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract Transfer{
    address payable[] public bidderTobid ;
    uint public maxbid ;
    address  public maxaddress ;
    address  public wallet ;
    event Recieved(address,uint);

    uint startTime=block.timestamp;
    uint endTime;

    constructor(uint baseamt){
        maxbid=baseamt;
        wallet =msg.sender;
        maxaddress=msg.sender ; //transfer amt to this wallet 
    }

    function payToThisContract() public payable{
        // require(block.timestamp<=endTime,"Auction Ended");
        require(msg.sender != wallet , "you cannot bid in your own auction");
        require(msg.value>=maxbid);
        if(wallet!=maxaddress)
        {
            payable(maxaddress).transfer(getBalance());
            maxaddress=msg.sender;
            maxbid=msg.value;
            bidderTobid.push(payable(msg.sender));
        }
        else
        {
            maxaddress=msg.sender;
            maxbid=msg.value;
            bidderTobid.push(payable(msg.sender));
        }
    }
   
    function getBalance() public view returns(uint)
    {
            return maxbid;
    }

    function HighestBid() public {
        require(msg.sender == wallet , "caller should be owner");
        payable(msg.sender).transfer(getBalance());
    }

    
}