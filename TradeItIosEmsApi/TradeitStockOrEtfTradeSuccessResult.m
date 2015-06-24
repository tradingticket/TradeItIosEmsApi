//
//  TradeitStockOrEtfTradeSuccessResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeitStockOrEtfTradeSuccessResult.h"

@implementation TradeitStockOrEtfTradeSuccessResult

-(id) initWithToken:(NSString *)token
    andShortMessage:(NSString *)shortMessage
    andLongMessages:(NSArray *)longMessages
    andOrderNumber: (NSString*) orderNumber
    andConfirmationMessage:(NSString*) confirmationMessage
    andTimestamp: (NSString* )timestamp
    andBroker:(NSString*) broker{
    
    self = [super initWithToken:token andShortMessage:shortMessage andLongMessages:longMessages];
    if (self) {
        self.orderNumber = orderNumber;
        self.confirmationMessage = confirmationMessage;
        self.timestamp = timestamp;
        self.broker = broker;
    }
    return self;
    
}

- (id)init {
    // Forward to the "initWithToken" initialization method
    return [self initWithToken:nil andShortMessage:nil andLongMessages:nil andOrderNumber:nil andConfirmationMessage:nil andTimestamp:nil andBroker:nil];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"TradeitStockOrEtfTradeSuccessResult: %@ orderNumber=%@ confirmationMessage=%@ timestamp=%@ broker=%@",[super description], self.orderNumber, self.confirmationMessage,self.timestamp, self.broker];
}
@end
