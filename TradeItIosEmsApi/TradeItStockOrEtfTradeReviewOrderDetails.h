//
//  TradeItStockOrEtfTradeReviewOrderDetails.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TIEMSJSONModel.h"
/**
 *  Class containing the Order details contained in the TradeItStockOrEtfTradeReviewResult
 */
@interface TradeItStockOrEtfTradeReviewOrderDetails : TIEMSJSONModel<NSCopying>

/**
 *  The symbol passed into the order
 */
@property (copy) NSString* orderSymbol;

/**
 *  The action passed into the order
 */
@property (copy) NSString* orderAction;

/**
 *  The number of shares passed in the order
 */
@property int orderQuantity;

/**
 *  The price at which the order will execute, contains:
 *  "Market" for market orders
 *  <limit price> for limit orders (i.e. 34.56)
 *  <stop price>  for stop market orders (i.e 30.67)
 *  <limit price> (trigger:<stop price>) for stop limit orders (i.e 34.56(trigger:30.67) )
 */
@property (copy) NSString* orderPrice;

/**
 *  The expiration passed into order. Values are either Day or 'Good Till Cancelled'
 */
@property (copy) NSString* orderExpiration;

/**
 *  A user friendly description of the order. i.e "You are about to place a market order to buy AAPL" or "You are about to place a limit order to sell short AAPL"
 */
@property (copy) NSString* orderMessage;

/**
 *  The number of shares held long by the user (pre-trade)
 *  If value is -1 then server was not able to pull value
 */
@property (copy) NSNumber<TIEMSOptional>* longHoldings;

/**
 *  The number of shares held short by the user (pre-trade)
 *  If value is -1 then server was not able to pull value
 */
@property (copy) NSNumber<TIEMSOptional>* shortHoldings;

/**
 *  "Estimated Proceeds" or "Estimated Cost" depending on the order action
 */
@property (copy) NSString * orderValueLabel;

/**
 *  The user buying power (pre-trade)
 *  Note: tradestation and IB return buyingPower for all account types. Other brokers return buyingPower for margin accounts and availableCash for cash accounts
 */
@property (copy) NSNumber<TIEMSOptional>* buyingPower; //if nil ignore field as not available

/**
 *  The user available cash (pre-trade). If nil ignore field as not available
 */
@property (copy) NSNumber<TIEMSOptional>* availableCash;

/**
 *  Estimated value of the order, does not include fees. If nil ignore field as not available
 */
@property (copy) NSNumber<TIEMSOptional>* estimatedOrderValue; //


/**
 *  The estimated cost of fees and commissions for the order. If nil ignore field as not available
 */
@property (copy) NSNumber<TIEMSOptional>* estimatedOrderCommission;


/**
 *  The estimated total cost of the order including fees. If nil ignore field as not available
 */
@property (copy) NSNumber<TIEMSOptional>* estimatedTotalValue;

@end
