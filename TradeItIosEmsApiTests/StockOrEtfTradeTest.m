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
#import "TradeitStockOrEtfPrice.h"
#import "TradeItAuthenticationInfo.h"

#import "TradeitStockOrEtfTradeResult.h"
#import "TradeitStockOrEtfTradeSuccessResult.h"
#import "TradeItStockOrEtfReviewOrderDetails.h"
#import "TradeitStockOrEtfTradeReviewResult.h"
#import "TradeitStockOrEtfTradeSecurityQuestionResult.h"
#import "TradeitStockOrEtfTradeMultipleAccountResult.h"
#import "TradeItStockOrEtfTradeInProgressResult.h"

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
                                              initWithAction:TradeItActionBuy
                                              andQuantity:12 andSymbol:@"AAPL"
                                              andPrice:[[TradeitStockOrEtfPrice alloc] initLimit:12.34]
                                              andExpiration:TradeItExpirationGtc];
    
    TradeItAuthenticationInfo *authenticationInfo = [[TradeItAuthenticationInfo alloc] initWithId:@"dummy" andPassword:@"dummyPassword"];
    
    TradeitStockOrEtfTradeResult* tradeResult = [[TradeitStockOrEtfTradeResult alloc] initWithToken:@"token95489048" andShortMessage:@"succesful trade" andLongMessages:@[@"yoy",@"yoyoyo"]];
    
    TradeItStockOrEtfReviewOrderDetails * orderDetails = [TradeItStockOrEtfReviewOrderDetails new];
    TradeitStockOrEtfTradeReviewResult *reviewResult = [[TradeitStockOrEtfTradeReviewResult alloc]
                                                        initWithToken:@"token95489048"
                                                        andShortMessage:@"succesful trade"
                                                        andLongMessages:@[@"yoy",@"yoyoyo"]
                                                        andOrderDetails: orderDetails
                                                        andWarnings:@[@"wanting 1",@"warning2"]
                                                        andAckWarnings:@[@"ack warning1", @"ack warning2"]];
    
    TradeitStockOrEtfTradeSuccessResult* successResult = [[TradeitStockOrEtfTradeSuccessResult alloc] initWithToken:@"token" andShortMessage:@"short message" andLongMessages:@[@"yoy",@"yoyoyo"] andOrderNumber:@"order number" andConfirmationMessage:@"confirmation" andTimestamp:@"12h34 EDT" andBroker:@"dummy"];
    
    TradeitStockOrEtfTradeSecurityQuestionResult *securityQuestionResult = [[TradeitStockOrEtfTradeSecurityQuestionResult alloc] initWithToken:@"token" andShortMessage:@"short message" andLongMessages:@[@"yo", @"yoyo"] andSecurityQuestion:@"What is your first name" andInformationShortMessage:@"info short message" andInformationLongMessage:@"info long message" andErrorFields:nil];
    
    TradeItStockOrEtfTradeMultipleAccountResult * multipleAccountResult = [[TradeItStockOrEtfTradeMultipleAccountResult alloc] initWithToken:@"toke" andShortMessage:@"short message" andLongMessages:@[@"yo"] andAccountList:@[@"acct 1", @"acct 2"]];
    TradeItStockOrEtfTradeInProgressResult *inProgressResult = [[TradeItStockOrEtfTradeInProgressResult alloc] initWithToken:@"token" andShortMessage:@"Connecting with your broker"];
    
    NSLog(@"---------------------------Start Test----------------------------");
    NSLog(@"------Publisher app %@", tradeManager.publisherApp);
    NSLog(@"------%@", orderInfo );
    NSLog(@"------%@ ", authenticationInfo);
    NSLog(@"------tradeResult:%@", tradeResult);
    NSLog(@"%@", reviewResult);
    NSLog(@"%@", successResult);
    NSLog(@"%@", securityQuestionResult);
    NSLog(@"%@", multipleAccountResult);
    NSLog(@"%@", inProgressResult);
    
    NSLog(@"---------------------------End Test-----------------------------");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
