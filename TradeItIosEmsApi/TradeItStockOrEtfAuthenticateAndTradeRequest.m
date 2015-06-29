//
//  TradeItStockOrEtfRequestAuthenticateAndTrade.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItStockOrEtfAuthenticateAndTradeRequest.h"

@implementation TradeItStockOrEtfAuthenticateAndTradeRequest

-(id) initWithPublisherDomain:(NSString*)publisherDomain andBroker:(NSString*)broker andAuthenticationInfo:(TradeItAuthenticationInfo*)authenticationInfo andOrderInfo:(TradeItStockOrEtfOrderInfo*)orderInfo{
    
    self = [super init];
    if (self) {
        self.publisherDomain = publisherDomain;
        self.broker = broker;
        self.authenticationInfo = authenticationInfo;
        self.orderInfo = orderInfo;
        self.supportMultiAccounts = true; //default value is false
        self.skipReview = false;
    }
    return self;
}



- (id) init{
    return [self initWithPublisherDomain:@"" andBroker:@"" andAuthenticationInfo:nil andOrderInfo:nil ];
}

@end

