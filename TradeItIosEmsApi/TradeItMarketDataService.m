//
//  TradeItMarketDataService.m
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 2/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItMarketDataService.h"
#import "TradeItEmsUtils.h"
#import "TradeItQuoteResult.h"
#import "TradeItSymbolLookupResult.h"

@implementation TradeItMarketDataService

-(id) initWithSession:(TradeItSession *) session {
    self = [super init];
    if(self) {
        self.session = session;
    }
    return self;
}

- (void) getQuote:(TradeItQuoteRequest *) request withCompletionBlock:(void (^)(TradeItResult *)) completionBlock {
    request.token = self.session.token;
    
    NSMutableURLRequest * quoteRequest = buildJsonRequest(request, @"marketdata/getQuote", self.session.connector.environment);
    
    [self.session.connector sendEMSRequest:quoteRequest withCompletionBlock:^(TradeItResult * result, NSMutableString * jsonResponse) {
        TradeItResult * resultToReturn = result;
        
        if ([result.status isEqual:@"SUCCESS"]){
            resultToReturn = buildResult([TradeItQuoteResult alloc], jsonResponse);
        }
        
        completionBlock(resultToReturn);
    }];
}

-(void) symbolLookup:(TradeItSymbolLookupRequest *)request withCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    request.token = self.session.token;
    
    NSMutableURLRequest * symbolLookupRequest = buildJsonRequest(request, @"marketdata/symbolLookup", self.session.connector.environment);
    
    [self.session.connector sendEMSRequest:symbolLookupRequest withCompletionBlock:^(TradeItResult * result, NSMutableString * jsonResponse) {
        TradeItResult * resultToReturn = result;
        
        if ([result.status isEqual:@"SUCCESS"]){
            resultToReturn = buildResult([TradeItSymbolLookupResult alloc], jsonResponse);
        }
        
        completionBlock(resultToReturn);
    }];
}

@end
