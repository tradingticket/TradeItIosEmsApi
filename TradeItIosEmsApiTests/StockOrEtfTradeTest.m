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
#import "TradeItAuthLinkResult.h"

#import "TradeItConnector.h"

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
    TradeItConnector * connector = [[TradeItConnector alloc] initWithApiKey:@"tradeit-test-api-key"];
    connector.environment = TradeItEmsTestEnv;
    
    //NSLog(@"******************Testing Fetch Broker List");
    //[self testFetchBrokerList: connector];
    
    NSLog(@"******************Testing oAuth Link to Dummy broker");
    TradeItAuthLinkResult * authLink = [self testAuthLink: connector];
    
    /*
    if(![authLink.status isEqualToString:@"SUCCESS"]) {
        NSLog(@"Something failed during auth link, unable to proceed");
        return;
    }
    
    NSLog(@"*******************Testing saving/removing token into keychain");
    [self testLinkingAccount: connector withLink:authLink];
    */
    
    
//    NSLog(@"******************TESTING BASIC USE CASE");
//        asyncBasicTest();
//        asyncSecurityAnswerTest();
//        asyncMultiAccountTest();
//        asyncCloseSessionTest();
//    NSLog(@"Done");
//
//    
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
//
   
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void) testFetchBrokerList: (TradeItConnector *) connector{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request to get broker list should succeed"];
    
    [connector getAvailableBrokersWithCompletionBlock:^(NSArray * brokers) {
        NSLog(@"Brokers: %@", brokers);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

-(void) testLinkingAccount:(TradeItConnector *) connector withLink:(TradeItAuthLinkResult *) link {
    [connector saveLinkToKeychain:link withBroker:@"Dummy" andDescription:@"Dummy Test Save"];
    
    NSArray * accounts = [connector getLinkedLogins];
    BOOL found = NO;
    for (NSDictionary * account in accounts) {
        if ([account[@"description"] isEqualToString: @"Dummy Test Save"]) {
            found = YES;
        }
    }
    
    if(!found) {
        XCTFail(@"Failed finding stored linked account");
    }
    
    [connector unlinkBroker:@"Dummy"];
    
    NSArray * accounts2 = [connector getLinkedLogins];
    found = NO;
    for (NSDictionary * account in accounts2) {
        if ([account[@"description"] isEqualToString: @"Dummy Test Save"]) {
            found = YES;
        }
    }
    
    if(found) {
        XCTFail(@"Failed removing stored linked account");
    }
}

-(TradeItAuthLinkResult *) testAuthLink: (TradeItConnector *) connector {
    NSLog(@"********Testing oAuth Invalid Case");
    [self testAuthLinkInvalid: connector];

    NSLog(@"********Testing oAuth Valid Case");
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request to link broker should succeed"];
    __block TradeItAuthLinkResult * resultToReturn;
    
    TradeItAuthenticationInfo * authInfo = [[TradeItAuthenticationInfo alloc] initWithId:@"dummy" andPassword:@"dummy" andBroker:@"Dummy"];
    
    [connector linkBrokerWithAuthenticationInfo: authInfo andCompletionBlock:^(TradeItResult * result) {
        NSLog(@"Auth link repsonse: %@", result);
        resultToReturn = (TradeItAuthLinkResult *) result;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];

    return resultToReturn;
}

-(void) testAuthLinkInvalid:(TradeItConnector *) connector {
    XCTestExpectation * expectation = [self expectationWithDescription:@"Request to link broker should fail"];
    
    TradeItAuthenticationInfo * authInfo = [[TradeItAuthenticationInfo alloc] initWithId:@"fail" andPassword:@"dummy" andBroker:@"Dummy"];
    
    [connector linkBrokerWithAuthenticationInfo: authInfo andCompletionBlock:^(TradeItResult * result) {
        NSLog(@"Auth link repsonse: %@", result);
        
        if([result isKindOfClass: [TradeItErrorResult class]] &&
           [[(TradeItErrorResult *)result code] intValue]  == 300) {
            
            [expectation fulfill];
        } else {
            XCTFail(@"Invalid credentials did not return expected response: %@", result);
        }
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

void testClose(){

    //send Request
    // This is an example of a functional test case.
    /*
    TradeItStockOrEtfTradeSession * tradeSession = [[TradeItStockOrEtfTradeSession alloc] initWithpublisherApp:@"StockTracker"];

    tradeSession.environment = TradeItEmsTestEnv;
    
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
     */
}

void sendTestOrder(NSString* broker, NSString * id, NSString* password, int quantity){
    
    // This is an example of a functional test case.
    /*
    TradeItStockOrEtfTradeSession * tradeSession = [[TradeItStockOrEtfTradeSession alloc] initWithpublisherApp:@"StockTracker"];
    

    tradeSession.orderInfo = [[TradeItStockOrEtfOrderInfo alloc]
                                              initWithAction:TradeItStockOrEtfOrderActionBuy
                                              andQuantity:quantity andSymbol:@"AAPL"
                                              andPrice:[[TradeitStockOrEtfOrderPrice alloc] initLimit:12.34]
                                              andExpiration:TradeItStockOrEtfOrderExpirationGtc];
    
    tradeSession.environment = TradeItEmsTestEnv;
    
    tradeSession.authenticationInfo = [[TradeItAuthenticationInfo alloc] initWithId:id andPassword:password];
    
    tradeSession.broker = broker;
    
    TradeItResult *result = [tradeSession authenticateAndReview ];
    return processResult(tradeSession,result);
     */
}

void processResult(TradeItStockOrEtfTradeSession* tradeSession, TradeItResult * result){
    
    if(result == nil){
        NSLog(@"Received nil result returning");
    }
    else if([result isKindOfClass:[TradeItStockOrEtfTradeReviewResult class]]){
        //process review result
        
        NSLog(@"Received review result: %@", result);
        TradeItStockOrEtfTradeReviewResult * reviewResult = (TradeItStockOrEtfTradeReviewResult* ) result;
        NSLog(@" Order Message %@", reviewResult.orderDetails.orderMessage);

        NSLog(@"Placing Order...: ");
        result = [tradeSession placeOrder];
        return processResult(tradeSession, result);
        
    }
    else if([result isKindOfClass:[TradeItStockOrEtfTradeSuccessResult class]]){        //process success result
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
    
    
    tradeSession.runAsyncCompletionBlockOnMainThread = false;
    
    ///tradeSession.authenticationInfo = [[TradeItAuthenticationInfo alloc] initWithId:id andPassword:password];
    
    tradeSession.broker = broker;
    __block TradeItResult * authenticateAndReviewResult = nil;
   [tradeSession asyncAuthenticateAndReviewWithCompletionBlock:^(TradeItResult* result){
       NSLog(@"Received Result in completion block%@", result);
       authenticateAndReviewResult = result;
    }];
   
     while (!authenticateAndReviewResult) {
         //NSLog(@"Aurthenticating & Reviewing ..Asynch.");
     }
    return authenticateAndReviewResult;
}

TradeItResult* sendAsyncPlaceOrder( TradeItStockOrEtfTradeSession * tradeSession){
    
    __block TradeItResult * placeOrderResult = nil;
    [tradeSession asyncPlaceOrderWithCompletionBlock:^(TradeItResult* result){
        NSLog(@"Received Result in completion block%@", result);
        placeOrderResult = result;
    }];
    
    while (!placeOrderResult) {
        //NSLog(@"Placing Order ..Asynch.");
    }
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


TradeItResult* sendAsyncSelectAccount( TradeItStockOrEtfTradeSession * tradeSession, NSDictionary* accountInfo){
    __block TradeItResult * selectAccountResult = nil;
    [tradeSession asyncSelectAccount:accountInfo andCompletionBlock:^(TradeItResult* result){
        NSLog(@"Received Result in completion block%@", result);
        selectAccountResult = result;
    }];
    
    while (!selectAccountResult) {}
    return selectAccountResult;
}


void sendAsyncCloseSession( TradeItStockOrEtfTradeSession * tradeSession){
    __block BOOL done = NO;
    [tradeSession asyncCloseSessionWithCompletionBlock:^(BOOL sessionClosed){
        NSLog(@"Session CLosed %d", sessionClosed);
        done = YES;
    }];
    
    while (!done) {}
}



void asyncBasicTest(){
    
    TradeItStockOrEtfTradeSession * tradeSession = [[TradeItStockOrEtfTradeSession alloc] initWithpublisherApp:@"StockTracker"];
    tradeSession.environment = TradeItEmsTestEnv;
    tradeSession.runAsyncCompletionBlockOnMainThread = false;
    
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


void asyncMultiAccountTest(){
    
    TradeItStockOrEtfTradeSession * tradeSession = [[TradeItStockOrEtfTradeSession alloc] initWithpublisherApp:@"StockTracker"];
    tradeSession.environment = TradeItEmsTestEnv;
    tradeSession.runAsyncCompletionBlockOnMainThread = false;
    
    TradeItResult* result = sendAsyncAuthenticateAndReviewRequest(@"Dummy", @"dummyMultiple", @"dummy", 10, tradeSession);
    if([result isKindOfClass:[TradeItMultipleAccountResult class]]){
        TradeItMultipleAccountResult* multiAcctResult = (TradeItMultipleAccountResult*) result;
        NSLog(@"Received Multi Account result %@", multiAcctResult);
        NSLog(@"Selecting Account");
        result = sendAsyncSelectAccount(tradeSession, multiAcctResult.accountList[0]);
        NSLog(@"Received result %@", result);
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
    tradeSession.environment = TradeItEmsTestEnv;
    tradeSession.runAsyncCompletionBlockOnMainThread = false;
    
    TradeItResult* result = sendAsyncAuthenticateAndReviewRequest(@"Dummy", @"dummyMultiple", @"dummy", 10, tradeSession);
    if([result isKindOfClass:[TradeItSecurityQuestionResult class]]){
        NSLog(@"Received Security Question Result result %@", result);
        NSLog(@"Answering question");
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

void asyncCloseSessionTest(){
    
    TradeItStockOrEtfTradeSession * tradeSession = [[TradeItStockOrEtfTradeSession alloc] initWithpublisherApp:@"StockTracker"];
    tradeSession.environment = TradeItEmsTestEnv;
    tradeSession.runAsyncCompletionBlockOnMainThread = false;
    
    TradeItResult* result = sendAsyncAuthenticateAndReviewRequest(@"Dummy", @"dummy", @"dummy", 10, tradeSession);
    if([result isKindOfClass:[TradeItStockOrEtfTradeReviewResult class]]){
        NSLog(@"Received review result %@", result);
        NSLog(@"Close Sessiom session");
        sendAsyncCloseSession(tradeSession);
    }
    else{
        NSLog(@"Received result %@", result);
        
    }
}





@end
