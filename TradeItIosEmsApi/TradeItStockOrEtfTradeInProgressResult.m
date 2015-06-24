//
//  TradeItStockOrEtfTradeInProgressResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItStockOrEtfTradeInProgressResult.h"

@implementation TradeItStockOrEtfTradeInProgressResult

-(id) initWithToken:(NSString*) token andShortMessage:(NSString*) shortMessage {
    return [super initWithToken:token andShortMessage:shortMessage andLongMessages:nil];
}

- (id)init {
    // Forward to the "initWithToken" initialization method
    return [self initWithToken:nil andShortMessage:nil];
}

- (NSString*) description{
    return [NSString stringWithFormat:@"TradeItStockOrEtfTradeInProgressResult: %@ ",[super description]];
}

@end
