//
//  TradeItStockOrEtfTradeManager.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "TradeItStockOrEtfTradeManager.h"
#import "TradeItStockOrEtfAuthenticateAndTradeRequest.h"
#import <Foundation/NSURLConnection.h>
#import <Foundation/NSURL.h>

@interface TradeItStockOrEtfAuthenticateAndTradeRequest()

- (NSURL*) getEmsBaseUrl;
- (NSMutableURLRequest *) buildJsonRequestwithData:(JSONModel*) requestObject forMethod:(NSString*)emsMethod;
- (TradeItResult*) buildResult:(TradeItResult*) tradeItResult fromJson:(NSString*)jsonString ;
- (TradeItResult* ) processRequest:(NSURLRequest*) request;

@end

@implementation TradeItStockOrEtfTradeManager

- (id)initWithPublisherApp:(NSString *)publisherApp {
    self = [super init];
    if (self) {
        self.publisherApp = publisherApp;
        self.environment = TradeItEmsLocalEnv;
    }
    return self;
}



- (id)init {
    // Forward to the "initWithPublisherApp" initialization method
    return [self initWithPublisherApp:@""];
}

- (TradeItResult*) authenticateUser:(TradeItAuthenticationInfo*) authenticationInfo andTrade:(TradeItStockOrEtfOrderInfo*) orderInfo withBroker:(NSString*) broker{
    
    
    TradeItStockOrEtfAuthenticateAndTradeRequest *authenticateAndtradeRequest = [[TradeItStockOrEtfAuthenticateAndTradeRequest alloc] initWithPublisherDomain:self.publisherApp andBroker:broker andAuthenticationInfo:authenticationInfo andOrderInfo:orderInfo];
    return [self autheticateAndTradeWithRequest:authenticateAndtradeRequest];
}

- (TradeItResult*) autheticateAndTradeWithRequest: (TradeItStockOrEtfAuthenticateAndTradeRequest *) authenticateAndtradeRequest{
    
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:authenticateAndtradeRequest forMethod:@"authenticateAndTradeStocksOrEtfs"];
    
    return [self processRequest:request];
}

- (TradeItResult*) placeOrderForBroker:(NSString*) broker andToken:(NSString*) token{
    
    TradeItPlaceOrderRequest * placeOrderRequest = [TradeItPlaceOrderRequest new];
    placeOrderRequest.token = token;
    placeOrderRequest.broker = broker;
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:placeOrderRequest forMethod:@"placeTrade"];
    
    return [self processRequest:request];
}

- (TradeItResult*) answerSecurityQuestion: (NSString*)answer forBroker:(NSString*) broker andToken:(NSString*) token{
    TradeItSecurityQuestionRequest* securityRequest = [TradeItSecurityQuestionRequest new];
    securityRequest.token = token,
    securityRequest.broker = broker;
    securityRequest.securityAnswer = answer;
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:securityRequest forMethod:@"answerSecurityQuestion"];
    
    return [self processRequest:request];

    
}

- (TradeItResult*) selectAccount: (NSArray*) accountInfo forBroker:(NSString*) broker andToken:(NSString*) token{
    
    TradeItSelectAccountRequest* selectAccountRequest = [TradeItSelectAccountRequest new];
    selectAccountRequest.broker = broker;
    selectAccountRequest.token = token;
    selectAccountRequest.accountInfo = accountInfo;
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:selectAccountRequest forMethod:@"selectAccount"];
    
    return [self processRequest:request];
}


- (BOOL) closeSessionForToken:(NSString*) token{
    
    TradeItCloseSessionRequest * closeSessionRequest = [TradeItCloseSessionRequest new];
    closeSessionRequest.token = token;
    
    NSMutableURLRequest *request = [self buildJsonRequestwithData:closeSessionRequest forMethod:@"close"];
    
    TradeItResult * result = [self processRequest:request];

    if([result.status isEqualToString:@"success"])
    {
        return true;
    }
    else{
        NSLog(@"failed closing session");
        return false;
    }
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
        return [self buildResult: [TradeItStockOrEtfTradeReviewResult alloc] fromJson:jsonResponse];
    }
    else if ([tradeItResult.status isEqual:@"SUCCESS"]){
        return [self buildResult: [TradeItStockOrEtfTradeSuccessResult alloc] fromJson:jsonResponse];
    }
    else if ([tradeItResult.status isEqual:@"ERROR"]){
        return [self buildResult: [TradeItErrorResult alloc] fromJson:jsonResponse];
    }
    else if ([tradeItResult.status isEqual:@"IN_PROGRESS"]){
        return [self buildResult: [TradeItInProgressResult alloc] fromJson:jsonResponse];
        
    }
    else if ([tradeItResult.status isEqual:@"INFORMATION_NEEDED"]){
        TradeItResult *informationResult =  [self buildResult: [TradeItInformationNeededResult alloc] fromJson:jsonResponse];
        
        if([informationResult isKindOfClass: [TradeItErrorResult class]]){//if there was an erro parsing return
            return informationResult; //return error
        }
        
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
