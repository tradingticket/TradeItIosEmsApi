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

#import "TradeItIosEmsApiLib.h"


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
    //asyncBasicTest();
    asyncSecurityAnswerTest();
    NSLog(@"Done");

    
//
//    NSLog(@"******************TESTING BASIC USE CASE");
//    sendTestOrder(@"Dummy", @"dummy", @"dummy", 10);
//    
//    NSLog(@"******************TESTING SECUIRTY QUESTION  USE CASE");
//    sendTestOrder(@"Dummy", @"dummySecurity", @"dummy", 10);
//    
//    NSLog(@"******************TESTING MULI OPTION SECURITY QUESTION  USE CASE");
//    sendTestOrder(@"Dummy", @"dummyOptionLong", @"dummy", 10);
//    
//    NSLog(@"******************TESTING MULI ACCOUNT USE CASE");
//    sendTestOrder(@"Dummy", @"dummyMultiple", @"dummy", 10);
//    
//    NSLog(@"******************TESTING ERROR USE CASE");
//    sendTestOrder(@"Dummy", @"dummy", @"dummy", 150);
//    
//    NSLog(@"******************TESTING Warning USE CASE");
//    sendTestOrder(@"Dummy", @"dummy", @"dummy", 150);
//    
//    NSLog(@"******************TESTING closing session USE CASE");
//    sendTestOrder(@"Dummy", @"dummy", @"dummy", 150);
//
//    testClose();




   
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

void testClose(){

    //send Request
    // This is an example of a functional test case.
    TradeItStockOrEtfTradeSession * tradeSession = [[TradeItStockOrEtfTradeSession alloc] initWithpublisherApp:@"StockTracker"];
    
    
    tradeSession.orderInfo = [[TradeItStockOrEtfOrderInfo alloc]
                              initWithAction:TradeItStockOrEtfOrderActionBuy
                              andQuantity:12 andSymbol:@"AAPL"
                              andPrice:[[TradeitStockOrEtfOrderPrice alloc] initLimit:12.34]
                              andExpiration:TradeItStockOrEtfOrderExpirationGtc];
    
    
    tradeSession.authenticationInfo = [[TradeItAuthenticationInfo alloc] initWithId:@"dummy" andPassword:@"dummy"];
    
    tradeSession.broker = @"Dummy";
    
    TradeItResult *result = [tradeSession authenticateAndReview ];
    
    NSLog(@"Received result: %@", result);
    
    //Do not place order but istead close session
    if(![result isKindOfClass:[TradeItErrorResult class]]){ //if error result is sent back the server automatically closes the session
    NSLog(@"Session Closed %d", [tradeSession closeSession]);
        
    }
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
    
    TradeItResult *result = [tradeSession authenticateAndReview ];
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
        NSLog(@"Received TradeItMultipleAccountResult result: %@", result);
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

// This is an example of a functional test case.

TradeItResult* sendAsyncAuthenticateAndReviewRequest(NSString* broker, NSString * id, NSString* password, int quantity, TradeItStockOrEtfTradeSession * tradeSession){
    

    tradeSession.orderInfo = [[TradeItStockOrEtfOrderInfo alloc]
                              initWithAction:TradeItStockOrEtfOrderActionBuy
                              andQuantity:quantity andSymbol:@"AAPL"
                              andPrice:[[TradeitStockOrEtfOrderPrice alloc] initLimit:12.34]
                              andExpiration:TradeItStockOrEtfOrderExpirationGtc];
    
    
    tradeSession.authenticationInfo = [[TradeItAuthenticationInfo alloc] initWithId:id andPassword:password];
    
    tradeSession.broker = broker;
    __block TradeItResult * authenticateAndReviewResult = nil;
   [tradeSession asyncAuthenticateAndReviewWithCompletionBlock:^(TradeItResult* result){
       NSLog(@"Received Result in completion block%@", result);
       authenticateAndReviewResult = result;
    }];
   
     while (!authenticateAndReviewResult) {}
    return authenticateAndReviewResult;
}

TradeItResult* sendAsyncPlaceOrder( TradeItStockOrEtfTradeSession * tradeSession){
    
    __block TradeItResult * placeOrderResult = nil;
    [tradeSession asyncPlaceOrderWithCompletionBlock:^(TradeItResult* result){
        NSLog(@"Received Result in completion block%@", result);
        placeOrderResult = result;
    }];
    
    while (!placeOrderResult) {}
    return placeOrderResult;
}

TradeItResult* sendAsyncSecurityAnswer( TradeItStockOrEtfTradeSession * tradeSession){
    __block TradeItResult * securityAnswerResult = nil;
    [tradeSession asyncAnswerSecurityQuestion:@"tradingticket" andCompletionBlock:^(TradeItResult* result){
        NSLog(@"Received Result in completion block%@", result);
        securityAnswerResult = result;
    }];
    
    while (!securityAnswerResult) {}
    return securityAnswerResult;
}


void asyncBasicTest(){
    TradeItStockOrEtfTradeSession * tradeSession = [[TradeItStockOrEtfTradeSession alloc] initWithpublisherApp:@"StockTracker"];
    TradeItResult* result = sendAsyncAuthenticateAndReviewRequest(@"Dummy", @"dummy", @"dummy", 10, tradeSession);
    if([result isKindOfClass:[TradeItStockOrEtfTradeReviewResult class]]){
        NSLog(@"Received review result %@", result);
        NSLog(@"placing order");
        result = sendAsyncPlaceOrder(tradeSession);
        NSLog(@"After placing order Received result%@", result);
    }
    else{
        NSLog(@"Received result %@", result);

    }
}



void asyncSecurityAnswerTest(){
    TradeItStockOrEtfTradeSession * tradeSession = [[TradeItStockOrEtfTradeSession alloc] initWithpublisherApp:@"StockTracker"];
    TradeItResult* result = sendAsyncAuthenticateAndReviewRequest(@"Dummy", @"dummySecurity", @"dummy", 10, tradeSession);
    if([result isKindOfClass:[TradeItSecurityQuestionResult class]]){
        NSLog(@"Received security question result %@", result);
        NSLog(@"Answering security question");
        result = sendAsyncSecurityAnswer(tradeSession);
        NSLog(@"Received result %@", result);
        NSLog(@"placing order");
        result = sendAsyncPlaceOrder(tradeSession);
        NSLog(@"After placing order Received result%@", result);
    }
    else{
        NSLog(@"Received result %@", result);
        
    }
}



@end
