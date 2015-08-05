//
//  TradeItBrokerListRequest.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 8/4/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItStockOrEtfBrokerListRequest.h"

@implementation TradeItStockOrEtfBrokerListRequest

-(id) initWithPublisherDomain:(NSString*)publisherDomain{
    
    self = [super init];
    if (self) {
        self.publisherDomain = publisherDomain;
    }
    return self;
}



- (id) init{
    return [self initWithPublisherDomain:@""];
}

@end
