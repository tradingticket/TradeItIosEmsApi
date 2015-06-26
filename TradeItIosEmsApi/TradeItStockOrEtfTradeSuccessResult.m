//
//  TradeItStockOrEtfTradeSuccessResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItStockOrEtfTradeSuccessResult.h"

@implementation TradeItStockOrEtfTradeSuccessResult


- (id)init {
    self = [super init];
    if (self) {
        self.orderNumber = nil;
        self.confirmationMessage = nil;
        self.timestamp = nil;
        self.broker = nil;
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"TradeItStockOrEtfTradeSuccessResult: %@ orderNumber=%@ confirmationMessage=%@ timestamp=%@ broker=%@",[super description], self.orderNumber, self.confirmationMessage,self.timestamp, self.broker];
}
@end
