//
//  TradeItConnector.m
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 1/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItConnector.h"
#import "TradeItStockOrEtfBrokerListRequest.h"
#import "TradeItEmsUtils.h"
#import "TradeItErrorResult.h"
#import "TradeItBrokerListSuccessResult.h"

@implementation TradeItConnector {
    BOOL runAsyncCompletionBlockOnMainThread;
}

- (id)initWithApiKey:(NSString *) apiKey {
    self = [super init];
    if (self) {
        self.apiKey = apiKey;
        self.environment = TradeItEmsProductionEnv;
        runAsyncCompletionBlockOnMainThread = true;
    }
    return self;
}

- (void) getAvailableBrokersWithCompletionBlock:(void (^)(NSArray *)) completionBlock {
    TradeItStockOrEtfBrokerListRequest * brokerListRequest = [[TradeItStockOrEtfBrokerListRequest alloc] initWithApiKey:self.apiKey];
    NSMutableURLRequest *request = buildJsonRequest(brokerListRequest, @"preference/getStocksOrEtfsBrokerList", self.environment);
    
    [self sendEMSRequest:request withCompletionBlock:^(TradeItResult * tradeItResult, NSMutableString * jsonResponse) {
         
         if([tradeItResult isKindOfClass: [TradeItErrorResult class]]){
             NSLog(@"Could not fetch broker list, got error result%@ ", tradeItResult);
         }
         else if ([tradeItResult.status isEqual:@"SUCCESS"]){
             TradeItBrokerListSuccessResult* successResult = (TradeItBrokerListSuccessResult*) buildResult([TradeItBrokerListSuccessResult alloc],jsonResponse);
            
             completionBlock(successResult.brokerList);
             
             return;
         }
         else if ([tradeItResult.status isEqual:@"ERROR"]){
             NSLog(@"Could not fetch broker list, got error result%@ ", tradeItResult);
         }
         
         completionBlock(nil);
    }];
}

-(void) linkBrokerWithAuthenticationInfo: (TradeItAuthenticationInfo *) authInfo andCompletionBlack:(void (^)(TradeItResult *)) completionBlock {
    TradeItAuthLinkRequest * authLinkRequest = [[TradeItAuthLinkRequest alloc] initWithAuthInfo:authInfo andAPIKey:self.apiKey];
    
    NSMutableURLRequest * request = buildJsonRequest(authLinkRequest, @"user/oAuthLink", self.environment);
    
    [self sendEMSRequest:request withCompletionBlock:^(TradeItResult * tradeItResult, NSMutableString * jsonResponse) {
        
        if([tradeItResult isKindOfClass: [TradeItErrorResult class]]){//if there was an erro parsing return
            NSLog(@"Could not link broker, got error result%@ ", tradeItResult);
        }
        else if ([tradeItResult.status isEqual:@"SUCCESS"]){
            TradeItAuthLinkResult* successResult = (TradeItAuthLinkResult*) buildResult([TradeItAuthLinkResult alloc],jsonResponse);
            
            completionBlock(successResult);
            
            return;
        }
        else if ([tradeItResult.status isEqual:@"ERROR"]){
            NSLog(@"Could not fetch broker list, got error result%@ ", tradeItResult);
        }
    }];
    
}

-(void) sendEMSRequest:(NSMutableURLRequest *) request withCompletionBlock:(void (^)(TradeItResult *, NSMutableString *)) completionBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void){
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *responseJsonData = [NSURLConnection sendSynchronousRequest:request
                                                         returningResponse:&response
                                                                     error:&error];
        
        if ((responseJsonData==nil) || ([response statusCode]!=200)) {
            //error occured
            NSLog(@"ERROR from EMS server response=%@ error=%@", response, error);
            dispatch_async(dispatch_get_main_queue(),^(void){completionBlock(nil,nil);});
            return;
        }
        
        NSMutableString *jsonResponse = [[NSMutableString alloc] initWithData:responseJsonData encoding:NSUTF8StringEncoding];
        
        //first convert to a generic result to check the type
        TradeItResult * tradeItResult = buildResult([TradeItResult alloc],jsonResponse);
        
        dispatch_async(dispatch_get_main_queue(),^(void){completionBlock(tradeItResult, jsonResponse);});
    });

}

@end
