//Unit ICO
//Version of compiler
pragma solidity ^0.4.11;
contract unit_ico {
    //Introducing the maximum number of Units available for sealed
    uint public max_units = 1000000;
    //Introducing the USD to Unit conversion relocatable
    uint public usd_to_units = 1000;
    //Introducing the total number of Units that have been bought by investors
    uint public total_units_bought = 0;
    //Mapping from the investor address to its equity in Units and usd_to_units
    mapping(address => uint) equity_units;
    mapping(address => uint) equity_usd;
    //Checking if an investor can buy Units
    modifier can_buy_units(uint usd_invested){
        require(usd_invested * usd_to_units + total_units_bought <= max_units);
        _;
    }
    //Getting the equity in Units of an investor
    function equity_in_units(address investor) external constant returns (uint){
        return equity_units[investor];
    }
    //Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }
    //Buying Units
    function buy_units(address investor, uint usd_invested) external 
    can_buy_units(usd_invested){
        uint units_bought = usd_invested * usd_to_units;
        equity_units[investor] += units_bought;
        equity_usd[investor] = equity_units[investor]/usd_to_units;
        total_units_bought += units_bought;
    }
    //Selling Units 
    function sell_units(address investor, uint units_sold) external {
        equity_units[investor] -= units_sold;
        equity_usd[investor] = equity_units[investor]/usd_to_units;
        total_units_bought -= units_sold;
    }
}