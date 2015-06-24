//
//  TradeitStockOrEtfTradeResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeitStockOrEtfTradeResult.h"

@implementation TradeitStockOrEtfTradeResult

-(id) initWithToken:(NSString*) token andShortMessage:(NSString*) shortMessage andLongMessages:(NSMutableArray*)longMessages{
    self = [super init];
    if (self) {
        self.token = token;
        self.shortMessage = shortMessage;
        self.longMessages = longMessages;
    }
    return self;
}

- (id)init {
    // Forward to the "initWithToken" initialization method
    return [self initWithToken:nil andShortMessage:nil andLongMessages:nil];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"token=%@ shortMessage=%@ longMessages%@",self.token, self.shortMessage, self.longMessages];
}
@end
