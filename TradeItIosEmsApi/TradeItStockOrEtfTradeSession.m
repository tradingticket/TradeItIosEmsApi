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
#import <dispatch/dispatch.h>

@interface TradeItStockOrEtfTradeSession()

- (NSURL*) getEmsBaseUrl;
- (NSMutableURLRequest *) buildJsonRequestwithData:(JSONModel*) requestObject forMethod:(NSString*)emsMethod;
- (TradeItResult*) buildResult:(TradeItResult*) tradeItResult fromJson:(NSString*)jsonString ;
- (TradeItResult* ) processRequest:(NSURLRequest*) request;
- (TradeItResult*) autheticateAndTradeWithRequest: (TradeItStockOrEtfAuthenticateAndTradeRequest *) authenticateAndtradeRequest;

@property (copy) NSString* sessionToken;

@end

@implementation TradeItStockOrEtfTradeSession

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
    }
    return self;
}

- (void)reset{
    self.orderInfo = [TradeItStockOrEtfOrderInfo new];
    self.authenticationInfo = [TradeItAuthenticationInfo new];
    self.broker = nil;
    self.sessionToken = nil;
}

- (id)init {
    // Forward to the "initWithpublisherDomain" initialization method
    return [self initWithpublisherApp:nil];
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
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:authenticateAndtradeRequest forMethod:@"authenticateAndTradeStocksOrEtfs"];
    
    return [self processRequest:request];
}

- (TradeItResult*) placeOrder{
    
    TradeItPlaceOrderRequest * placeOrderRequest = [[TradeItPlaceOrderRequest alloc] initWithToken:self.sessionToken];
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:placeOrderRequest forMethod:@"placeTrade"];
    
    return [self processRequest:request];
}

- (TradeItResult*) answerSecurityQuestion: (NSString*)answer{
    TradeItSecurityQuestionRequest* securityRequest = [[TradeItSecurityQuestionRequest alloc] initWithToken:self.sessionToken andAnswer:answer];
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:securityRequest forMethod:@"answerSecurityQuestion"];
    
    return [self processRequest:request];

    
}

- (TradeItResult*) selectAccount: (NSDictionary*) accountInfo {
    
    TradeItSelectAccountRequest* selectAccountRequest = [[TradeItSelectAccountRequest alloc]initWithToken:self.sessionToken andAccountInfo:accountInfo];
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:selectAccountRequest forMethod:@"selectAccount"];
    
    return [self processRequest:request];
}


- (BOOL) closeSession{
    
    TradeItCloseSessionRequest * closeSessionRequest = [[TradeItCloseSessionRequest alloc]initWithToken:self.sessionToken];
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:closeSessionRequest forMethod:@"close"];
    
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

- (void) asyncAuthenticateAndReviewWithCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self authenticateAndReview];
        if (completionBlock) {
            completionBlock(result);
        }
    });
}

//asynch methodes

- (void) asyncAuthenticateUser:(TradeItAuthenticationInfo*) authenticationInfo andReview:(TradeItStockOrEtfOrderInfo*) orderInfo withBroker:(NSString*) broker andCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self authenticateUser:authenticationInfo andReview:orderInfo withBroker:broker];
        
        if (completionBlock) {
            completionBlock(result);
        }
    });

}

- (void) asyncAnswerSecurityQuestion: (NSString*)answer andCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self answerSecurityQuestion:answer];
        
        if (completionBlock) {
            completionBlock(result);
        }
    });

}
- (void) asyncSelectAccount: (NSDictionary*) accountInfo andCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self selectAccount:accountInfo];
        
        if (completionBlock) {
            completionBlock(result);
        }
    });
}

- (void) asyncPlaceOrderWithCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self placeOrder];
        
        if (completionBlock) {
            completionBlock(result);
        }
    });

}

- (void) asyncCloseSessionWithCompletionBlock:(void (^)(BOOL)) completionBlock{
    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
         BOOL sessionClosed = [self closeSession];
        
        if (completionBlock) {
            completionBlock(sessionClosed);
        }
    });
    
}


//private methods
- (NSURL*) getEmsBaseUrl{
    switch (self.environment) {
        case TradeItEmsProductionEnv:
            return [NSURL URLWithString:@"https://ems.tradingticket.com/universalTradingTicket/"];
        case TradeItEmsTestEnv:
            return [NSURL URLWithString:@"https://ems.qa.tradingticket.com/universalTradingTicket/"];
        case TradeItEmsLocalEnv:
            return [NSURL URLWithString:@"http://localhost:8080/ems/universalTradingTicket/"];
        default:
            NSLog(@"Invalid environment %d - directing to production by default", self.environment);
            return [NSURL URLWithString:@"https://ems.tradingticket.com/universalTradingTicket/"];
    }
}


- (NSMutableURLRequest *) buildJsonRequestwithData:(JSONModel*)requestObject forMethod:(NSString*)emsMethod
{
    NSData *requestData = [[requestObject toJSONString] dataUsingEncoding:NSUTF8StringEncoding];
    
    //NSLog(@"requestdata is %@", requestData);
    NSURL * url = [NSURL URLWithString:emsMethod relativeToURL:[self getEmsBaseUrl]];
    
    //NSLog(@"ems url is %@",url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    return request;

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
    TradeItResult * tradeItResult = [self buildResult:[TradeItResult alloc] fromJson:jsonResponse];
    //NSLog(@"Generic Result:%@", tradeItResult);
    
    
    if([tradeItResult isKindOfClass: [TradeItErrorResult class]]){//if there was an erro parsing return
        return tradeItResult; //return error
    }
    
    if([tradeItResult.status  isEqual: @"REVIEW_ORDER"])
    {
        TradeItStockOrEtfTradeReviewResult* reviewResult =  (TradeItStockOrEtfTradeReviewResult*)[self buildResult: [TradeItStockOrEtfTradeReviewResult alloc] fromJson:jsonResponse];
        self.sessionToken =  reviewResult.token; //save token locally
        return reviewResult;
    }
    else if ([tradeItResult.status isEqual:@"SUCCESS"]){
        self.sessionToken = nil; //reset token
        return [self buildResult: [TradeItStockOrEtfTradeSuccessResult alloc] fromJson:jsonResponse];
    }
    else if ([tradeItResult.status isEqual:@"ERROR"]){
        self.sessionToken = nil; //reset token
        return [self buildResult: [TradeItErrorResult alloc] fromJson:jsonResponse];
    }
    else if ([tradeItResult.status isEqual:@"INFORMATION_NEEDED"]){
        TradeItResult *informationResult =  [self buildResult: [TradeItInformationNeededResult alloc] fromJson:jsonResponse];
        
        if([informationResult isKindOfClass: [TradeItErrorResult class]]){//if there was an error parsing return
            return informationResult; //return error
        }
        
        self.sessionToken = informationResult.token;
        
        //parse to either a security question or a multi account
        NSString *informationType =[informationResult valueForKey: @"informationType"];
        if([informationType isEqual:@"SECURITY_QUESTION"]){
            return [self buildResult: [TradeItSecurityQuestionResult alloc] fromJson:jsonResponse];
        }
        else if ([informationType isEqual:@"SELECT_ACCOUNT"]){
            return [self buildResult: [TradeItMultipleAccountResult alloc] fromJson:jsonResponse];
        }
        else{
            NSLog(@"Unsupported information type %@, upgrade apis", informationType);
            return [TradeItErrorResult tradeErrorWithSystemMessage:[NSString stringWithFormat:@"Unsupported information type %@, upgrade apis", informationType]];
        }
        
    }
    
    return tradeItResult;
}

- (TradeItResult*) buildResult:(TradeItResult*) tradeItResult fromJson:(NSString*)jsonString {
    
    JSONModelError* jsonModelError = nil;
    TradeItResult * resultFromJson = [tradeItResult initWithString:jsonString error:&jsonModelError];
    
    if(jsonModelError!=nil)
    {
        NSLog(@"Received invalid json from ems server error=%@ response=%@", jsonModelError, jsonString);
        return [TradeItErrorResult tradeErrorWithSystemMessage:@"error parsing json response"];
    }
    
    return resultFromJson;
}
@end
