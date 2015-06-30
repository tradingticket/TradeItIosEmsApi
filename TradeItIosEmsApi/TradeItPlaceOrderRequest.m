//
//  TradeItPlaceOrderRequest.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/26/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItPlaceOrderRequest.h"

@implementation TradeItPlaceOrderRequest

-(id) initWithToken: (NSString*)token{
    self = [super init];
    if(self){
        self.token = token;
    }
    return self;
}


-(NSString*) description {
    return [NSString stringWithFormat:@"TradeItPlaceOrderRequest: %@ token:%@ ", [super description], self.token];
}

@end
