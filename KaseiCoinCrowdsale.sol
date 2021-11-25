pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";
// Have the KaseiCoinCrowdsale contract inherit the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale, CappedCrowdsale { 
    // UPDAeTE THE CONTRACT SIGNATURE TO ADD INHERITANCE
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        // YOUR CODE HERE!
        uint256 rate,
        address payable wallet,
        KaseiCoin token,
        uint open,
        uint close,
        uint goal
    ) public 
        Crowdsale(rate, wallet, token)
        CappedCrowdsale(goal)
        TimedCrowdsale(open, close)
        RefundableCrowdsale(goal) 
    {
        // constructor can stay empty    
    }
}


contract KaseiCoinCrowdsaleDeployer {
    address public kasei_token_address;

    address public kasei_crowdsale_address;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet,
        uint init_supply,
        uint goal
    ) public {
        KaseiCoin token = new KaseiCoin(name, symbol, init_supply);

        kasei_token_address = address(token);

        KaseiCoinCrowdsale kasei_crowdsale = new KaseiCoinCrowdsale(1, wallet, token, goal, now, now + 24 weeks);

        kasei_crowdsale_address = address(kasei_crowdsale);

        token.addMinter(kasei_crowdsale_address);

        token.renounceMinter();

    }
}