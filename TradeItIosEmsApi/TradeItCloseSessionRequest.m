//
//  TradeItCloseSessionRequest.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/26/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItCloseSessionRequest.h"

@implementation TradeItCloseSessionRequest

-(id) initWithToken: (NSString*)token {
    self = [super init];
    if(self){
        self.token = token;
    }
    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"TradeItCloseSessionRequest: token:%@ ", self.token];
}

@end
