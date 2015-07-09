//
//  TradeItSelectAccountRequest.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/26/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItSelectAccountRequest.h"

@implementation TradeItSelectAccountRequest

-(id) initWithToken: (NSString*)token andAccountInfo:(NSDictionary*) accountInfo{
    self = [super init];
    if(self){
        self.token = token;
        self.accountInfo = accountInfo;
    }
    return self;
}


-(NSString*) description {
    return [NSString stringWithFormat:@"TradeItSelectAccountRequest: %@ token:%@ accountInfo:%@", [super description], self.token, self.accountInfo];
}
@end
