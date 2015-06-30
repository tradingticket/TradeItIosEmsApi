//
//  StockOrEtfTradeTest.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TradeItStockOrEtfTradeSession.h"
#import "TradeItStockOrEtfOrderInfo.h"
#import "TradeitStockOrEtfOrderPrice.h"
#import "TradeItAuthenticationInfo.h"

#import "TradeItResult.h"
#import "TradeItStockOrEtfTradeSuccessResult.h"
#import "TradeItStockOrEtfTradeReviewOrderDetails.h"
#import "TradeItStockOrEtfTradeReviewResult.h"
#import "TradeItSecurityQuestionResult.h"
#import "TradeItMultipleAccountResult.h"
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
    NSLog(@"******************TESTING BASIC USE CASE");
    sendTestOrder(@"Dummy", @"dummy", @"dummy", 10);
    
    NSLog(@"******************TESTING SECUIRTY QUESTION  USE CASE");
    sendTestOrder(@"Dummy", @"dummySecurity", @"dummy", 10);
    
    NSLog(@"******************TESTING MULI OPTION SECURITY QUESTION  USE CASE");
    sendTestOrder(@"Dummy", @"dummyOptionLong", @"dummy", 10);
    
    NSLog(@"******************TESTING MULI ACCOUNT USE CASE");
    sendTestOrder(@"Dummy", @"dummyMultiple", @"dummy", 10);
    
    NSLog(@"******************TESTING ERROR USE CASE");
    sendTestOrder(@"Dummy", @"dummy", @"dummy", 150);
    
    NSLog(@"******************TESTING Warning USE CASE");
    sendTestOrder(@"Dummy", @"dummy", @"dummy", 150);




    NSLog(@"---------------------------End Test-----------------------------");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

void sendTestOrder(NSString* broker, NSString * id, NSString* password, int quantity){
    
    // This is an example of a functional test case.
    TradeItStockOrEtfTradeSession * tradeSession = [[TradeItStockOrEtfTradeSession alloc] initWithpublisherApp:@"StockTracker"];
    

    tradeSession.orderInfo = [[TradeItStockOrEtfOrderInfo alloc]
                                              initWithAction:TradeItStockOrEtfOrderActionBuy
                                              andQuantity:quantity andSymbol:@"AAPL"
                                              andPrice:[[TradeitStockOrEtfOrderPrice alloc] initLimit:12.34]
                                              andExpiration:TradeItStockOrEtfOrderExpirationGtc];
    
    
    tradeSession.authenticationInfo = [[TradeItAuthenticationInfo alloc] initWithId:id andPassword:password];
    
    tradeSession.broker = broker;
    
    TradeItResult *result = [tradeSession authenticateAndTrade ];
    return processResult(tradeSession,result);

}

void processResult(TradeItStockOrEtfTradeSession* tradeSession, TradeItResult * result){
    
    if(result == nil){
        NSLog(@"Received nil result returning");
    }
    else if([result isKindOfClass:[TradeItStockOrEtfTradeReviewResult class]]){
        //process review result
        
        NSLog(@"Received review result: %@", result);
        
        NSLog(@"Placing Order...: ");
        result = [tradeSession placeOrder];
        return processResult(tradeSession, result);
        
    }
    else if([result isKindOfClass:[TradeItStockOrEtfTradeSuccessResult class]]){
        //process success result
        NSLog(@"Great!!!!, Received Success result: %@", result);

    }
    else if([result isKindOfClass:[TradeItSecurityQuestionResult class]]){
        //process security question
        TradeItSecurityQuestionResult *securityQuestionResult = (TradeItSecurityQuestionResult *) result; //cast result
       
        NSLog(@"Received security result: %@", securityQuestionResult);
        
        if(securityQuestionResult.securityQuestionOptions != nil && securityQuestionResult.securityQuestionOptions.count > 0 ){
            result = [tradeSession answerSecurityQuestion:@"option 1" ];
            return processResult(tradeSession, result);
        }
        else if(securityQuestionResult.challengeImage !=nil){
            result = [tradeSession answerSecurityQuestion:@"tradingticket"];
            return processResult(tradeSession, result);
        }
        else if(securityQuestionResult.securityQuestion != nil){
            //answer security question
            result = [tradeSession answerSecurityQuestion:@"tradingticket" ];
            return processResult(tradeSession, result);
        }
    }
    else if([result isKindOfClass:[TradeItMultipleAccountResult class]]){
        //process mutli account
        //cast result
        TradeItMultipleAccountResult * multiAccountResult = (TradeItMultipleAccountResult* ) result;
        result = [tradeSession selectAccount:multiAccountResult.accountList[0]];
        return processResult(tradeSession, result);
        
    }
    else if([result isKindOfClass:[TradeItErrorResult class]]){
        //Received an error
        NSLog(@"Bummer!!!!, Received Error result: %@", result);
    }

}


@end
