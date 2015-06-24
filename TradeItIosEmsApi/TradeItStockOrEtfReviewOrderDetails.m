//
//  TradeItStockOrEtfReviewOrderDetails.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItStockOrEtfReviewOrderDetails.h"

@implementation TradeItStockOrEtfReviewOrderDetails

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
      andWithOrderMessage: (NSString*)orderMessage{
    
    self = [super init];
    
    if (self) {
        self.orderSymbol = orderSymbol;
        self.orderAction = orderAction;
        self.orderPrice = orderPrice;
        self.orderExpiration = orderExpiration;
        self.longHoldings = longHoldings;
        self.shortHoldings = shortHoldings;
        self.orderQuantity = orderQuantity;
        self.buyingPower = buyingPower;
        self.availableCash = availableCash;
        self.estimatedOrderValue = estimatedOrderValue;
        self.estimatedOrderCommission = estimatedOrderCommission;
        self.estimatedTotalValue = estimatedTotalValue;
        self.limitPrice = limitPrice;
        self.triggerPrice = triggerPrice;
        self.orderMessage = orderMessage;
    }
    return self;
    
}

- (id)init {
    // Forward to the "initWithToken" initialization method
    return [self initWithOrderSymbol: nil
                 andWithOrderAction: nil
                  andWithOrderPrice: nil
             andWithOrderExpiration: nil
                andWithLongHoldings: 0
               andWithShortHoldings: 0
               andWithOrderQuantity: 0.0
                 andWithBuyingPower: -1
               andWithAvailableCash: -1
         andWithEstimatedOrderValue: -1
    andWithEstimatedOrderCommission: -1
          andWithEstimatedTotalValue: -1
                  andWithLimitPrice: -1
                andWithTriggerPrice: -1
                andWithOrderMessage: @""];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"TradeItStockOrEtfReviewOrderDetails: orderSymbol=%@ orderAction=%@ orderPrice=%@ orderExpiration=%@ longHoldings=%f shortHoldings=%f orderQuantity=%f buyingPower=%f availableCash=%f estimatedOrderValue=%f estimatedOrderCommission=%f estimatedTotalValue=%f limitPrice=%f triggerPrice=%f orderMessage=%@", self.orderSymbol,self.orderAction,self.orderPrice,self.orderExpiration,self.longHoldings,self.shortHoldings,self.orderQuantity,self.buyingPower,self.availableCash,self.estimatedOrderValue,self.estimatedOrderCommission,self.estimatedTotalValue,self.limitPrice,self.triggerPrice,self.orderMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] initWithOrderSymbol:self.orderSymbol andWithOrderAction:self.orderAction andWithOrderPrice:self.orderPrice andWithOrderExpiration:self.orderExpiration andWithLongHoldings:self.longHoldings andWithShortHoldings:self.shortHoldings andWithOrderQuantity:self.orderQuantity andWithBuyingPower:self.buyingPower andWithAvailableCash:self.availableCash andWithEstimatedOrderValue:self.estimatedOrderValue andWithEstimatedOrderCommission:self.estimatedOrderCommission andWithEstimatedTotalValue:self.estimatedTotalValue andWithLimitPrice:self.limitPrice andWithTriggerPrice:self.triggerPrice andWithOrderMessage:self.orderMessage];
    return copy;
}


@end
