//
//  TradeItStockOrEtfAuthenticateAndTradeRequest.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "JSONModel.h"
#import "TradeItAuthenticationInfo.h"
#import "TradeItStockOrEtfOrderInfo.h"
#import "TradeItRequest.h"


@interface TradeItStockOrEtfAuthenticateAndTradeRequest : TradeItRequest

@property (copy) TradeItAuthenticationInfo * authenticationInfo;
@property (copy) TradeItStockOrEtfOrderInfo * orderInfo;
@property (copy) NSString * publisherDomain;
@property BOOL supportMultiAccounts; //default value is true
@property BOOL skipReview; //default value is false
@property (copy) NSString* broker;
@property (copy) NSString<Optional>* postbackURL;

-(id) initWithPublisherDomain:(NSString*)publisherDomain andBroker:(NSString*)broker andAuthenticationInfo:(TradeItAuthenticationInfo*)authenticationInfo andOrderInfo:(TradeItStockOrEtfOrderInfo*) orderInfo andPostbackUrl:(NSString*) postbackURL;


@end