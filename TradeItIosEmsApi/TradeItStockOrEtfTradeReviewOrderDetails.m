//
//  TradeItStockOrEtfTradeReviewOrderDetails.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItStockOrEtfTradeReviewOrderDetails.h"

@implementation TradeItStockOrEtfTradeReviewOrderDetails

- (id)init {
    self = [super init];
    
    if (self) {
        self.orderSymbol = @"";
        self.orderAction = @"";
        self.orderPrice = @"";
        self.orderExpiration = @"";
        self.orderQuantity = 0;
        self.orderMessage =  @"";
        
        self.longHoldings = [NSNumber numberWithDouble:0.0];
        self.shortHoldings = [NSNumber numberWithDouble:0.0];
 
        self.buyingPower = nil;
        self.availableCash = nil;
        self.estimatedOrderValue = nil;
        self.estimatedOrderCommission = nil;
        self.estimatedTotalValue = nil;
        self.orderValueLabel = @"";
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"TradeItStockOrEtfReviewOrderDetails: orderSymbol=%@ orderAction=%@ orderPrice=%@ orderExpiration=%@ longHoldings=%@ shortHoldings=%@ orderQuantity=%d buyingPower=%@ availableCash=%@ estimatedOrderValue=%@ estimatedOrderCommission=%@ estimatedTotalValue=%@ orderMessage=%@ orderValueLabel=%@", self.orderSymbol,self.orderAction,self.orderPrice,self.orderExpiration,self.longHoldings,self.shortHoldings,self.orderQuantity,self.buyingPower,self.availableCash,self.estimatedOrderValue,self.estimatedOrderCommission,self.estimatedTotalValue,self.orderMessage, self.orderValueLabel];
}

- (id)copyWithZone:(NSZone *)zone
{
    TradeItStockOrEtfTradeReviewOrderDetails *copy = [super copyWithZone:zone];
    
    if(copy){
        copy.orderSymbol=[self.orderSymbol copyWithZone:zone];
        copy.orderAction=[self.orderAction copyWithZone:zone];
        copy.orderPrice=[self.orderPrice copyWithZone:zone];
        copy.orderExpiration=[self.orderExpiration copyWithZone:zone];
        copy.orderQuantity= self.orderQuantity;
        copy.orderMessage=[self.orderMessage copyWithZone:zone];
        
        copy.longHoldings=[self.longHoldings copyWithZone:zone];
        copy.shortHoldings=[self.shortHoldings copyWithZone:zone];
        
        copy.buyingPower=[self.buyingPower copyWithZone:zone];
        copy.availableCash=[self.availableCash copyWithZone:zone];
        copy.estimatedOrderValue=[self.estimatedOrderValue copyWithZone:zone];
        copy.estimatedOrderCommission=[self.estimatedOrderCommission copyWithZone:zone];
        copy.estimatedTotalValue=[self.estimatedTotalValue copyWithZone:zone];
    }
    return copy;
}


@end
