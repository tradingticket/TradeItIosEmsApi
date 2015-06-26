//
//  TradeItStockOrEtfTradeManager.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TradeItStockOrEtfOrderInfo.h"
#import "TradeItAuthenticationInfo.h"

#import "TradeitResult.h"
#import "TradeItInProgressResult.h"
#import "TradeItInformationNeededResult.h"
#import "TradeItMultipleAccountResult.h"
#import "TradeItSecurityQuestionResult.h"
#import "TradeItStockOrEtfTradeReviewResult.h"
#import "TradeItStockOrEtfTradeSuccessResult.h"

#import "TradeItRequest.h"
#import "TradeItSecurityQuestionRequest.h"
#import "TradeItSelectAccountRequest.h"
#import "TradeItPlaceOrderRequest.h"
#import "TradeItCloseSessionRequest.h"
#import "TradeItStockOrEtfAuthenticateAndTradeRequest.h"

#import "TradeItErrorResult.h"

typedef enum {
    TradeItEmsProductionEnv,
    TradeItEmsTestEnv,
    TradeItEmsLocalEnv
} TradeitEmsEnvironments;

@interface TradeItStockOrEtfTradeManager : NSObject

@property (copy) NSString * publisherApp;
@property TradeitEmsEnvironments environment; //default value is TradeItEmsProductionEnv


- (id) initWithPublisherApp:(NSString *) publisherApp;
- (TradeItResult*) authenticateUser:(TradeItAuthenticationInfo*) authenticationInfo andTrade:(TradeItStockOrEtfOrderInfo*) orderInfo withBroker:(NSString*) broker;
- (TradeItResult*) autheticateAndTradeWithRequest: (TradeItStockOrEtfAuthenticateAndTradeRequest *) request;
- (TradeItResult*) answerSecurityQuestion: (NSString*)answer forBroker:(NSString*) broker andToken:(NSString*) token;
- (TradeItResult*) selectAccount: (NSArray*) accountInfo forBroker:(NSString*) broker andToken:(NSString*) token;
- (TradeItResult*) placeOrderForBroker:(NSString*) broker andToken:(NSString*) token;
- (BOOL) closeSessionForToken:(NSString*) token;



@end
