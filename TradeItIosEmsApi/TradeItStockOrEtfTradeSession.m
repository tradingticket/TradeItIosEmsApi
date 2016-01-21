//
//  TradeItStockOrEtfTradeManager.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "TradeItStockOrEtfTradeSession.h"
#import "TradeItStockOrEtfAuthenticateAndTradeRequest.h"
#import <Foundation/NSURLConnection.h>
#import <Foundation/NSURL.h>

#import "TradeItPlaceOrderRequest.h"
#import "TradeItCloseSessionRequest.h"
#import "TradeItSecurityQuestionRequest.h"
#import "TradeItSelectAccountRequest.h"
#import "TradeItStockOrEtfBrokerListRequest.h"
#import <dispatch/dispatch.h>
#import "TradeItEmsUtils.h"
#import "TradeItBrokerListSuccessResult.h"

@interface TradeItStockOrEtfTradeSession()


- (TradeItResult* ) processRequest:(NSURLRequest*) request;
- (TradeItResult*) autheticateAndTradeWithRequest: (TradeItStockOrEtfAuthenticateAndTradeRequest *) authenticateAndtradeRequest;
- (dispatch_queue_t) getAsyncQueue;

@property (copy) NSString* sessionToken;

@end

@implementation TradeItStockOrEtfTradeSession

+ (id)globalSession {
    static TradeItStockOrEtfTradeSession *globalSessionInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalSessionInstance = [[self alloc] initWithpublisherApp:nil];
    });

    return globalSessionInstance;
}

- (id)init {
    // Forward to the "initWithpublisherDomain" initialization method
    return [self initWithpublisherApp:nil];
}

- (id)initWithpublisherApp:(NSString *)publisherApp {
    self = [super init];
    if (self) {
        self.publisherApp  = publisherApp;
        self.environment = TradeItEmsProductionEnv;
        self.orderInfo = [TradeItStockOrEtfOrderInfo new];
        self.authenticationInfo = [TradeItAuthenticationInfo new];
        self.broker = nil;
        self.sessionToken = nil;
        self.postbackURL = nil;
        self.runAsyncCompletionBlockOnMainThread = true;
    }
    return self;
}

- (void)reset{
    self.orderInfo = [TradeItStockOrEtfOrderInfo new];
    self.authenticationInfo = [TradeItAuthenticationInfo new];
    self.broker = nil;
    self.sessionToken = nil;
}


- (TradeItResult*) authenticateUser:(TradeItAuthenticationInfo*) authenticationInfo andReview:(TradeItStockOrEtfOrderInfo*) orderInfo withBroker:(NSString*) broker{
    
    self.authenticationInfo = authenticationInfo;
    self.orderInfo = orderInfo;
    self.broker = broker;
    return [self authenticateAndReview];
}

- (TradeItResult*) authenticateAndReview{
    
    if (self.authenticationInfo == nil) {
        return [TradeItErrorResult tradeErrorWithSystemMessage:@"authenticationInfo cannot be null please set authenticationInfo before calling this method"];
    }
    else if (self.orderInfo== nil )
    {
        return [TradeItErrorResult tradeErrorWithSystemMessage:@"orderInfo cannot be null please set orderInfo before calling this method"];

    }
    else if ([self.broker  isEqual: @""] || self.broker==nil){
        return [TradeItErrorResult tradeErrorWithSystemMessage:@"broker cannot be null please set broker before calling this method"];

    }
    
    TradeItStockOrEtfAuthenticateAndTradeRequest *authenticateAndtradeRequest = [[TradeItStockOrEtfAuthenticateAndTradeRequest alloc] initWithPublisherDomain:self.publisherApp andBroker:self.broker andAuthenticationInfo:self.authenticationInfo andOrderInfo:self.orderInfo andPostbackUrl:self.postbackURL];
    return [self autheticateAndTradeWithRequest:authenticateAndtradeRequest];

}



- (TradeItResult*) autheticateAndTradeWithRequest: (TradeItStockOrEtfAuthenticateAndTradeRequest *) authenticateAndtradeRequest{
    
    NSMutableURLRequest *request = buildJsonRequest(authenticateAndtradeRequest, @"authenticateAndTradeStocksOrEtfs", self.environment);
    
    return [self processRequest:request];
}

- (TradeItResult*) placeOrder{
    
    TradeItPlaceOrderRequest * placeOrderRequest = [[TradeItPlaceOrderRequest alloc] initWithToken:self.sessionToken];
    
    NSMutableURLRequest *request = buildJsonRequest(placeOrderRequest, @"placeTrade", self.environment);
    
    return [self processRequest:request];
}

- (TradeItResult*) answerSecurityQuestion: (NSString*)answer{
    TradeItSecurityQuestionRequest* securityRequest = [[TradeItSecurityQuestionRequest alloc] initWithToken:self.sessionToken andAnswer:answer];
    
    NSMutableURLRequest *request = buildJsonRequest(securityRequest, @"answerSecurityQuestion", self.environment);
    
    return [self processRequest:request];

    
}

- (TradeItResult*) selectAccount: (NSDictionary*) accountInfo {
    
    TradeItSelectAccountRequest* selectAccountRequest = [[TradeItSelectAccountRequest alloc]initWithToken:self.sessionToken andAccountInfo:accountInfo];
    
    NSMutableURLRequest *request = buildJsonRequest(selectAccountRequest, @"selectAccount", self.environment);
    
    return [self processRequest:request];
}


- (BOOL) closeSession{
    
    TradeItCloseSessionRequest * closeSessionRequest = [[TradeItCloseSessionRequest alloc]initWithToken:self.sessionToken];
    
    NSMutableURLRequest *request = buildJsonRequest(closeSessionRequest, @"close", self.environment);
    
    TradeItResult * result = [self processRequest:request];

    [self reset]; //reset data
    
    if([result.status isEqualToString:@"success"])
    {
        return true;
    }
    else{
        NSLog(@"failed closing session");
        return false;
    }
}



- (NSArray *) getBrokerList{
    /*
    TradeItStockOrEtfBrokerListRequest * brokerListRequest = [[TradeItStockOrEtfBrokerListRequest alloc]initWithPublisherDomain:self.publisherApp];
    
    NSMutableURLRequest *request = buildJsonRequest(brokerListRequest, @"getStocksOrEtfsBrokerList", self.environment);
    
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *responseJsonData = [NSURLConnection sendSynchronousRequest:request
                                                     returningResponse:&response
                                                                 error:&error];
    
    if ((responseJsonData==nil) || ([response statusCode]!=200)) {
        //error occured
        NSLog(@"Could not send authenticateAndTradeRequest to ems server response=%@ error=%@", response, error);
        return nil;
    }
    
    NSMutableString *jsonResponse = [[NSMutableString alloc] initWithData:responseJsonData encoding:NSUTF8StringEncoding];

    //first convert to a generic result to check the type
    TradeItResult * tradeItResult = buildResult([TradeItResult alloc],jsonResponse);
    //NSLog(@"Generic Result:%@", tradeItResult);
    
    
    if([tradeItResult isKindOfClass: [TradeItErrorResult class]]){//if there was an erro parsing return
        NSLog(@"Could not fetch broker list, got error result%@ ", tradeItResult);
        return nil;
    }
    
    if ([tradeItResult.status isEqual:@"SUCCESS"]){
        TradeItBrokerListSuccessResult* successResult = (TradeItBrokerListSuccessResult*) buildResult([TradeItBrokerListSuccessResult alloc],jsonResponse);
        return successResult.brokerList;
    }
    else if ([tradeItResult.status isEqual:@"ERROR"]){
        NSLog(@"Could not fetch broker list, got error result%@ ", tradeItResult);
        return nil;
    }
*/
    return nil;

}

//asynch methodes

- (void) asyncAuthenticateAndReviewWithCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self authenticateAndReview];
        if (completionBlock) {
            dispatch_async([self getAsyncQueue],^(void){completionBlock(result);});
        }
    });
}

- (void) asyncAuthenticateUser:(TradeItAuthenticationInfo*) authenticationInfo andReview:(TradeItStockOrEtfOrderInfo*) orderInfo withBroker:(NSString*) broker andCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self authenticateUser:authenticationInfo andReview:orderInfo withBroker:broker];
        
        if (completionBlock) {
            dispatch_async([self getAsyncQueue],^(void){completionBlock(result);});
        }
    });

}

- (void) asyncAnswerSecurityQuestion: (NSString*)answer andCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self answerSecurityQuestion:answer];
        
        if (completionBlock) {
            dispatch_async([self getAsyncQueue],^(void){completionBlock(result);});        }
    });

}
- (void) asyncSelectAccount: (NSDictionary*) accountInfo andCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self selectAccount:accountInfo];
        
        if (completionBlock) {
            dispatch_async([self getAsyncQueue],^(void){completionBlock(result);});
        }
    });
}

- (void) asyncPlaceOrderWithCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self placeOrder];
        if (completionBlock) {
            dispatch_async([self getAsyncQueue],^(void){completionBlock(result);});
        }
    });

}

- (void) asyncCloseSessionWithCompletionBlock:(void (^)(BOOL)) completionBlock{
    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
         BOOL sessionClosed = [self closeSession];
        
        if (completionBlock) {
            dispatch_async([self getAsyncQueue],^(void){completionBlock(sessionClosed);});
        }
    });
    
}

- (void) asyncGetBrokerListWithCompletionBlock:(void (^)(NSArray* )) completionBlock{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        NSArray* brokerList  = [self getBrokerList];
        
        if (completionBlock) {
            dispatch_async([self getAsyncQueue],^(void){completionBlock(brokerList);});
        }
    });
}


//private methods

- (dispatch_queue_t) getAsyncQueue{
    if (self.runAsyncCompletionBlockOnMainThread)
        return dispatch_get_main_queue();
    else
        return dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0);
}

- (TradeItResult* ) processRequest:(NSURLRequest* ) request{
    
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *responseJsonData = [NSURLConnection sendSynchronousRequest:request
                                                     returningResponse:&response
                                                                 error:&error];
    
    if ((responseJsonData==nil) || ([response statusCode]!=200)) {
        //error occured
        NSLog(@"Could not send authenticateAndTradeRequest to ems server response=%@ error=%@", response, error);
        return [TradeItErrorResult tradeErrorWithSystemMessage:@"error sending request to ems server"];
    }

    NSMutableString *jsonResponse = [[NSMutableString alloc] initWithData:responseJsonData encoding:NSUTF8StringEncoding];
    // NSLog(@"Json response:%@", stringData);
    
    //first convert to a generic result to check the type
    TradeItResult * tradeItResult = buildResult([TradeItResult alloc],jsonResponse);
    //NSLog(@"Generic Result:%@", tradeItResult);
    
    
    if([tradeItResult isKindOfClass: [TradeItErrorResult class]]){//if there was an erro parsing return
        return tradeItResult; //return error
    }
    
    if([tradeItResult.status  isEqual: @"REVIEW_ORDER"])
    {
        TradeItStockOrEtfTradeReviewResult* reviewResult =  (TradeItStockOrEtfTradeReviewResult*)buildResult([TradeItStockOrEtfTradeReviewResult alloc],jsonResponse);
        
        self.sessionToken =  reviewResult.token; //save token locally
        return reviewResult;
    }
    else if ([tradeItResult.status isEqual:@"SUCCESS"]){
        self.sessionToken = nil; //reset token
        return buildResult([TradeItStockOrEtfTradeSuccessResult alloc],jsonResponse);
    }
    else if ([tradeItResult.status isEqual:@"ERROR"]){
        self.sessionToken = nil; //reset token
        return buildResult([TradeItErrorResult alloc],jsonResponse);
    }
    else if ([tradeItResult.status isEqual:@"INFORMATION_NEEDED"]){
        TradeItResult *informationResult = buildResult([TradeItInformationNeededResult alloc],jsonResponse);
        
        if([informationResult isKindOfClass: [TradeItErrorResult class]]){//if there was an error parsing return
            return informationResult; //return error
        }
        
        self.sessionToken = informationResult.token;
        
        //parse to either a security question or a multi account
        NSString *informationType =[informationResult valueForKey: @"informationType"];
        if([informationType isEqual:@"SECURITY_QUESTION"]){
            return  buildResult([TradeItSecurityQuestionResult alloc],jsonResponse);
        }
        else if ([informationType isEqual:@"SELECT_ACCOUNT"]){
            return buildResult([TradeItMultipleAccountResult alloc],jsonResponse);
        }
        else{
            NSLog(@"Unsupported information type %@, upgrade apis", informationType);
            return [TradeItErrorResult tradeErrorWithSystemMessage:[NSString stringWithFormat:@"Unsupported information type %@, upgrade apis", informationType]];
        }
        
    }
    
    return tradeItResult;
}

@end
