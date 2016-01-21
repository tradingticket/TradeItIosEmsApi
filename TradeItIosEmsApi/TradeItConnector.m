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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void){
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *responseJsonData = [NSURLConnection sendSynchronousRequest:request
                                                         returningResponse:&response
                                                                     error:&error];
        
        if ((responseJsonData==nil) || ([response statusCode]!=200)) {
            //error occured
            NSLog(@"Could not retrieve brokers from ems server response=%@ error=%@", response, error);
            dispatch_async(dispatch_get_main_queue(),^(void){completionBlock(nil);});
            return;
        }
        
        NSMutableString *jsonResponse = [[NSMutableString alloc] initWithData:responseJsonData encoding:NSUTF8StringEncoding];
        
        //first convert to a generic result to check the type
        TradeItResult * tradeItResult = buildResult([TradeItResult alloc],jsonResponse);
        
        if([tradeItResult isKindOfClass: [TradeItErrorResult class]]){//if there was an erro parsing return
            NSLog(@"Could not fetch broker list, got error result%@ ", tradeItResult);
        }
        else if ([tradeItResult.status isEqual:@"SUCCESS"]){
            TradeItBrokerListSuccessResult* successResult = (TradeItBrokerListSuccessResult*) buildResult([TradeItBrokerListSuccessResult alloc],jsonResponse);
            dispatch_async(dispatch_get_main_queue(),^(void){completionBlock(successResult.brokerList);});
            return;
        }
        else if ([tradeItResult.status isEqual:@"ERROR"]){
            NSLog(@"Could not fetch broker list, got error result%@ ", tradeItResult);
        }
        
        dispatch_async(dispatch_get_main_queue(),^(void){completionBlock(nil);});
    });
}

@end
