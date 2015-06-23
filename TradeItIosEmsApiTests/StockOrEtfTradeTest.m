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
    
    NSLog(@"---------------------------Star Test----------------------------");
    NSLog(@"------Hello World %@", tradeManager.publisherApp);
    NSLog(@"------Order action %@", [orderInfo getActionString]);
    NSLog(@"------Order Exiration %@", [orderInfo getExpirationString]);
    NSLog(@"------Price Type %@ - limit %f, stop %f", [orderInfo.price getTypeString], orderInfo.price.limitPrice, orderInfo.price.stopPrice);
    NSLog(@"------symbol %@", orderInfo.symbol);
    NSLog(@"------quantity %d", orderInfo.quantity);
    NSLog(@"------authenticationInfo %@ %@", authenticationInfo.id , authenticationInfo.password);



    NSLog(@"---------------------------End Test-----------------------------");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
