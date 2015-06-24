//
//  TradeItStockOrEtfReviewOrderDetails.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeItStockOrEtfReviewOrderDetails : NSObject<NSCopying> 

@property (copy) NSString* orderSymbol;
@property (copy) NSString* orderAction;
@property (copy) NSString* orderPrice;
@property (copy) NSString* orderExpiration;
@property double longHoldings; //if -1 server was not able to pull value
@property double shortHoldings; //if -1 server was not able to pull value
@property double orderQuantity;
//tradestation and IB return buyingPower for all account types. Other brokers retrun buyingPower for margin accounts and availableCash for cash accounts
@property double buyingPower; //if -1 ignore field as not available
@property double availableCash; //if -1 ignore field as not available
@property double estimatedOrderValue; //if -1 ignore field as not available
@property double estimatedOrderCommission;  //if -1 then the broker does not provide the comission
@property double estimatedTotalValue; //if -1 ignore field as not available
@property double limitPrice; //if -1 then Not Applicable
@property double triggerPrice; //if -1 then Not Applicable
@property (copy) NSString* orderMessage;

-(id) initWithOrderSymbol:(NSString*) orderSymbol
       andWithOrderAction: (NSString*)orderAction
        andWithOrderPrice: (NSString*)orderPrice
   andWithOrderExpiration: (NSString*)orderExpiration
      andWithLongHoldings: (double)longHoldings
     andWithShortHoldings: (double)shortHoldings
     andWithOrderQuantity: (double)orderQuantity
       andWithBuyingPower: (double)buyingPower
     andWithAvailableCash: (double)availableCash
andWithEstimatedOrderValue: (double)estimatedOrderValue
andWithEstimatedOrderCommission: (double)estimatedOrderCommission
andWithEstimatedTotalValue: (double)estimatedTotalValue
        andWithLimitPrice: (double)limitPrice
      andWithTriggerPrice: (double)triggerPrice
      andWithOrderMessage: (NSString*)orderMessage;
@end
