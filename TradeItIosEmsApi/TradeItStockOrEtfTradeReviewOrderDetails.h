//
//  TradeItStockOrEtfTradeReviewOrderDetails.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "JSONModel.h"

@interface TradeItStockOrEtfTradeReviewOrderDetails : JSONModel<NSCopying>

@property (copy) NSString* orderSymbol;
@property (copy) NSString* orderAction;
@property int orderQuantity;
@property (copy) NSString* orderPrice;
@property (copy) NSString* orderExpiration;
@property (copy) NSString* orderMessage;

@property (copy) NSNumber<Optional>* longHoldings; //if -1 server was not able to pull value
@property (copy) NSNumber<Optional>* shortHoldings; //if -1 server was not able to pull value

//tradestation and IB return buyingPower for all account types. Other brokers retrun buyingPower for margin accounts and availableCash for cash accounts
@property (copy) NSNumber<Optional>* buyingPower; //if nil ignore field as not available
@property (copy) NSNumber<Optional>* availableCash; //if nil ignore field as not available
@property (copy) NSNumber<Optional>* estimatedOrderValue; //if nil ignore field as not available
@property (copy) NSNumber<Optional>* estimatedOrderCommission;  //if nil then the broker does not provide the comission
@property (copy) NSNumber<Optional>* estimatedTotalValue; //if nil ignore field as not available

@end
