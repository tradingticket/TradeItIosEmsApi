//
//  TradeItStockOrEtfTradeManager.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "TradeItStockOrEtfTradeManager.h"

@implementation TradeItStockOrEtfTradeManager

- (id)initWithPublisherApp:(NSString *)publisherApp {
    self = [super init];
    if (self) {
        self.publisherApp = publisherApp;
    }
    return self;
}

- (id)init {
    // Forward to the "initWithPublisherApp" initialization method
    return [self initWithPublisherApp:@""];
}
    
@end
