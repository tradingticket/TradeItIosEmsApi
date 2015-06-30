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
#import "TradeItMultipleAccountResult.h"
#import "TradeItSecurityQuestionResult.h"
#import "TradeItStockOrEtfTradeReviewResult.h"
#import "TradeItStockOrEtfTradeSuccessResult.h"
#import "TradeItErrorResult.h"

typedef enum {
    TradeItEmsProductionEnv,
    TradeItEmsTestEnv,
    TradeItEmsLocalEnv
} TradeitEmsEnvironments;

@interface TradeItStockOrEtfTradeSession : NSObject

@property (copy) NSString * publisherApp;
@property TradeitEmsEnvironments environment; //default value is TradeItEmsProductionEnv
@property (copy) NSString* sessionToken;
@property (copy) TradeItStockOrEtfOrderInfo * orderInfo;
@property (copy) TradeItAuthenticationInfo * authenticationInfo;
@property (copy) NSString * broker;

- (id) initWithpublisherApp:(NSString *) publisherApp;


- (TradeItResult*) authenticateUser:(TradeItAuthenticationInfo*) authenticationInfo andTrade:(TradeItStockOrEtfOrderInfo*) orderInfo withBroker:(NSString*) broker;
- (TradeItResult*) authenticateAndTrade; //can be called only if orderInfo,authenticationInfo and broker have been previously set
- (TradeItResult*) answerSecurityQuestion: (NSString*)answer;
- (TradeItResult*) selectAccount: (NSArray*) accountInfo;
- (TradeItResult*) placeOrder;
- (BOOL) closeSession; //close session calls a reset

- (void) reset; //resets orderInfo, authenticationInfo, broker and token;


@end
