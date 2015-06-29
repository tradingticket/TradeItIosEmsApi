//
//  TradeIRequest.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/26/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItRequest.h"

@implementation TradeItRequest


-(id) initWithBroker:(NSString*)broker{
    
    self = [super init];
    if (self) {
        self.broker = broker;

    }
    return self;
}

- (id) init{
    return [self initWithBroker:@""];
}

- (NSString*) description{
    return [NSString stringWithFormat:@" broker=%@",self.broker];
}

@end
