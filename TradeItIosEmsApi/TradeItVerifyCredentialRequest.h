//
//  TradeItVerifyCredentialRequest.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 7/14/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItRequest.h"
#import "TradeItAuthenticationInfo.h"

@interface TradeItVerifyCredentialRequest : TradeItRequest

@property (copy) TradeItAuthenticationInfo * authenticationInfo;
@property (copy) NSString * publisherDomain;
@property (copy) NSString* broker;

-(id) initWithPublisherDomain:(NSString*)publisherDomain andBroker:(NSString*)broker andAuthenticationInfo:(TradeItAuthenticationInfo*)authenticationInfo;


@end
