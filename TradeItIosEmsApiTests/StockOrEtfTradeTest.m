//
//  StockOrEtfTradeTest.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TradeItStockOrEtfTradeManager.h"
#import "TradeItStockOrEtfOrderInfo.h"
#import "TradeitStockOrEtfOrderPrice.h"
#import "TradeItAuthenticationInfo.h"

#import "TradeItResult.h"
#import "TradeItStockOrEtfTradeSuccessResult.h"
#import "TradeItStockOrEtfTradeReviewOrderDetails.h"
#import "TradeItStockOrEtfTradeReviewResult.h"
#import "TradeItSecurityQuestionResult.h"
#import "TradeItMultipleAccountResult.h"
#import "TradeItInProgressResult.h"
#import "TradeItStockOrEtfAuthenticateAndTradeRequest.h"
#import "JSONHTTPClient.h"
#import <Foundation/NSURLConnection.h>
//#import <Foundation/NSMutableURLRequest.h>
#import <Foundation/NSURL.h>

@interface StockOrEtfTradeTest : XCTestCase

@end

@implementation StockOrEtfTradeTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    TradeItStockOrEtfTradeManager * tradeManager = [[TradeItStockOrEtfTradeManager alloc] initWithPublisherApp:@"StockTracker"];
    
    TradeItStockOrEtfOrderInfo * orderInfo = [[TradeItStockOrEtfOrderInfo alloc]
                                              initWithAction:TradeItStockOrEtfOrderActionBuy
                                              andQuantity:10 andSymbol:@"AAPL"
                                              andPrice:[[TradeitStockOrEtfOrderPrice alloc] initLimit:12.34]
                                              andExpiration:TradeItStockOrEtfOrderExpirationGtc];

    
    TradeItAuthenticationInfo *authenticationInfo = [[TradeItAuthenticationInfo alloc] initWithId:@"dummy" andPassword:@"dummyPassword"];
    
    
    NSLog(@"------------------------Review Revew Start------------------------------");
    TradeItResult * result = [tradeManager authenticateUser:authenticationInfo andTrade:orderInfo withBroker:@"Dummy"];
    NSLog(@"Review Test: %@", result);
    
    NSLog(@"Placing Order Test: ");
    result = [tradeManager placeOrderForBroker:@"Dummy" andToken:result.token];
    NSLog(@"Place Order Result: %@", result);
    
    
    NSLog(@"------------------------Security Test Start------------------------------");
    authenticationInfo.id = @"dummySecurity";
    result = [tradeManager authenticateUser:authenticationInfo andTrade:orderInfo withBroker:@"Dummy"];
    NSLog(@"Security Test: %@", result);
    
    NSLog(@"Answering Security..... ");
    result = [tradeManager answerSecurityQuestion:@"tradingticket" forBroker:@"Dummy" andToken:result.token];
    NSLog(@"Answer Security Result: %@", result);
    
    NSLog(@"Send Close.... ");
    NSLog(@"Session closed: %d", [tradeManager closeSessionForToken:result.token]);


    
    NSLog(@"------------------------Security Options Test Start------------------------------");
    authenticationInfo.id = @"dummyOptionLong";
    result = [tradeManager authenticateUser:authenticationInfo andTrade:orderInfo withBroker:@"Dummy"];
    NSLog(@"multiple account Test: %@", result);
    
    NSLog(@"Answering Security: ");
    result = [tradeManager answerSecurityQuestion:@"option 1" forBroker:@"Dummy" andToken:result.token];
    NSLog(@"Answer Security Result: %@", result);
    
    NSLog(@"Send Close.... ");
    NSLog(@"Session closed: %d", [tradeManager closeSessionForToken:result.token]);

    

    NSLog(@"------------------------Security Multiple Accounts Test Start------------------------------");
    authenticationInfo.id = @"dummyMultiple";
    result = [tradeManager authenticateUser:authenticationInfo andTrade:orderInfo withBroker:@"Dummy"];
    NSLog(@"multiple account Test: %@", result);
    
    NSLog(@"SelectingAccount: ");
    TradeItMultipleAccountResult* multipleAccountResult = (TradeItMultipleAccountResult*)result;
    result = [tradeManager selectAccount: multipleAccountResult.accountList[0] forBroker:@"Dummy" andToken:multipleAccountResult.token];
    NSLog(@"Answer Security Result: %@", result);
    
    
    NSLog(@"Send Close.... ");
    NSLog(@"Session closed: %d", [tradeManager closeSessionForToken:result.token]);

    
    NSLog(@"------------------------Success Test------------------------------");
    authenticationInfo.id = @"dummy";
    TradeItStockOrEtfAuthenticateAndTradeRequest *tradeRequest = [[TradeItStockOrEtfAuthenticateAndTradeRequest alloc] initWithPublisherDomain:@"StockTracker" andBroker:@"Dummy" andAuthenticationInfo:authenticationInfo andOrderInfo:orderInfo];
    tradeRequest.skipReview = true;
    result = [tradeManager autheticateAndTradeWithRequest:tradeRequest];
    NSLog(@"Success Test: %@", result);


    
//    if ((nil != data) && (200 == [response statusCode])) {
//        // Process data
//    }
    
    
//    TradeitStockOrEtfTradeReviewResult *reviewResult = [[TradeitStockOrEtfTradeReviewResult alloc]
//                                                        initWithToken:@"token95489048"
//                                                        andShortMessage:@"succesful trade"
//                                                        andLongMessages:@[@"yoy",@"yoyoyo"]
//                                                        andOrderDetails: orderDetails
//                                                        andWarnings:@[@"wanting 1",@"warning2"]
//                                                        andAckWarnings:@[@"ack warning1", @"ack warning2"]];
//    
//    
//    
//    TradeItStockOrEtfTradeReviewOrderDetails * orderDetails = [TradeItStockOrEtfTradeReviewOrderDetails new];
//    TradeitStockOrEtfTradeSuccessResult* successResult = [[TradeitStockOrEtfTradeSuccessResult alloc] initWithToken:@"token" andShortMessage:@"short message" andLongMessages:@[@"yoy",@"yoyoyo"] andOrderNumber:@"order number" andConfirmationMessage:@"confirmation" andTimestamp:@"12h34 EDT" andBroker:@"dummy"];
//    
//    TradeitStockOrEtfTradeSecurityQuestionResult *securityQuestionResult = [[TradeitStockOrEtfTradeSecurityQuestionResult alloc] initWithToken:@"token" andShortMessage:@"short message" andLongMessages:@[@"yo", @"yoyo"] andSecurityQuestion:@"What is your first name" andInformationShortMessage:@"info short message" andInformationLongMessage:@"info long message" andErrorFields:nil];
//    
//    TradeItStockOrEtfTradeMultipleAccountResult * multipleAccountResult = [[TradeItStockOrEtfTradeMultipleAccountResult alloc] initWithToken:@"toke" andShortMessage:@"short message" andLongMessages:@[@"yo"] andAccountList:@[@"acct 1", @"acct 2"]];
//    TradeItStockOrEtfTradeInProgressResult *inProgressResult = [[TradeItStockOrEtfTradeInProgressResult alloc] initWithToken:@"token" andShortMessage:@"Connecting with your broker"];
   
    
//    NSLog(@"%@", reviewResult);
//    NSLog(@"%@", successResult);
//    NSLog(@"%@", securityQuestionResult);
//    NSLog(@"%@", multipleAccountResult);
//    NSLog(@"%@", inProgressResult);
    
    NSLog(@"---------------------------End Test-----------------------------");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
