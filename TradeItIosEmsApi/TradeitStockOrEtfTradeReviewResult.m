//
//  TradeitStockOrEtfTradeReviewResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeitStockOrEtfTradeReviewResult.h"


@implementation TradeitStockOrEtfTradeReviewResult

- (id) initWithToken:(NSString *)token
     andShortMessage:(NSString *)shortMessage
     andLongMessages:(NSArray *)longMessages
     andOrderDetails:(TradeItStockOrEtfReviewOrderDetails*) orderDetails
         andWarnings:(NSArray*) warnings
      andAckWarnings:(NSArray*) ackWarnings{

    self = [super initWithToken:token andShortMessage:shortMessage andLongMessages:longMessages];

    if(self){
        self.orderDetails = orderDetails;
        self.warnings = warnings;
        self.ackWarnings = ackWarnings;
    }
    return self;
}

- (id) init{
    //redirect to initWithOrderDetails
    return [self initWithToken:nil andShortMessage:nil andLongMessages:nil andOrderDetails:[TradeItStockOrEtfReviewOrderDetails new] andWarnings:nil andAckWarnings:nil];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"TradeitStockOrEtfTradeReviewResult: %@ orderDetails=%@ warnings=%@ ackWarnings=%@",[super description],
            self.orderDetails, self.warnings, self.ackWarnings];
}

@end
