//
//  TradeItVerifyCredentialSession.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 7/14/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItVerifyCredentialSession.h"
#import "TradeItVerifyCredentialRequest.h"
#import "TradeItEmsUtils.h"

@implementation TradeItVerifyCredentialSession


- (id)initWithpublisherApp:(NSString *)publisherApp {
    self = [super init];
    if (self) {
        self.publisherApp  = publisherApp;
        self.environment = TradeItEmsProductionEnv;
    }
    return self;
}


- (id)init {
    // Forward to the "initWithpublisherDomain" initialization method
    return [self initWithpublisherApp:nil];
}


- (TradeItResult*) verifyUser:(TradeItAuthenticationInfo*) authenticationInfo withBroker:(NSString*) broker{
    
    TradeItVerifyCredentialRequest * verifyCredentialRequest = [[TradeItVerifyCredentialRequest alloc] initWithPublisherDomain:self.publisherApp andBroker:broker andAuthenticationInfo:authenticationInfo];
    
    NSMutableURLRequest *request = buildJsonRequest(verifyCredentialRequest, @"verifyCredentials", self.environment);
    
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
    
   if ([tradeItResult.status isEqual:@"ERROR"]){
        return buildResult([TradeItErrorResult alloc],jsonResponse);
    }
    else if ([tradeItResult.status isEqual:@"SUCCESS"]){
        return buildResult([TradeItSuccessAuthenticationResult alloc],jsonResponse);
    }
    else{
        NSLog(@"Received unexcpected result %@", tradeItResult);
        return [TradeItErrorResult tradeErrorWithSystemMessage:@"unexcepted result"];
    }
    
}


- (void) verifyUser:(TradeItAuthenticationInfo*) authenticationInfo withBroker:(NSString*) broker WithCompletionBlock:(TradeItRequestCompletionBlock) completionBlock{
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0),  ^(void){
        TradeItResult * result= [self verifyUser:authenticationInfo withBroker:broker];
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(),^(void){completionBlock(result);});
        }
    });

    
}


@end
