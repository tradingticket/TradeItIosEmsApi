//
//  TradeItStockOrEtfTradeReviewResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItStockOrEtfTradeReviewResult.h"


@implementation TradeItStockOrEtfTradeReviewResult


- (id) init{
    
    self = [super init];
    
    if(self){
        self.orderDetails = nil;
        self.warningsList = nil;
        self.ackWarningsList = nil;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"TradeItStockOrEtfTradeReviewResult: %@ orderDetails=%@ warningsList=%@ ackWarningsList=%@",[super description],
            self.orderDetails, self.warningsList, self.ackWarningsList];
}

@end
