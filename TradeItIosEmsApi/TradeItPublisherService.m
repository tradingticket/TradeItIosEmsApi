//
//  TradeItPublisherService.m
//  TradeItIosEmsApi
//
//  Created by Daniel Vaughn on 4/27/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItPublisherService.h"
#import "TradeItEmsUtils.h"

@implementation TradeItPublisherService

-(id) initWithSession:(TradeItSession *) session {
    self = [super init];
    if(self) {
        self.session = session;
    }
    return self;
}

-(void) getAds:(TradeItAdsRequest *)request withCompletionBlock:(void (^)(TradeItResult *)) completionBlock {
    NSString * endpoint = @"publisher/getAdPlacements";
    request.apiKey = self.session.connector.apiKey;

    NSMutableURLRequest * adRequest = buildJsonRequest(request, endpoint, self.session.connector.environment);

    [self.session.connector sendEMSRequest:adRequest withCompletionBlock:^(TradeItResult * result, NSMutableString * jsonResponse) {
        TradeItResult * resultToReturn = result;

        if ([result.status isEqual:@"SUCCESS"]){
            resultToReturn = buildResult([TradeItAdsResult alloc], jsonResponse);
        }

        completionBlock(resultToReturn);
    }];
}

@end
