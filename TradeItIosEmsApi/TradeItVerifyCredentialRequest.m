//
//  TradeItVerifyCredentialRequest.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 7/14/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItVerifyCredentialRequest.h"

@implementation TradeItVerifyCredentialRequest

-(id) initWithPublisherDomain:(NSString*)publisherDomain andBroker:(NSString*)broker andAuthenticationInfo:(TradeItAuthenticationInfo*)authenticationInfo{
    
    self = [super init];
    if (self) {
        self.publisherDomain = publisherDomain;
        self.broker = broker;
        self.authenticationInfo = authenticationInfo;
        self.broker = broker;
    }
    return self;
}



- (id) init{
    return [self initWithPublisherDomain:@"" andBroker:@"" andAuthenticationInfo:nil];
}
@end
