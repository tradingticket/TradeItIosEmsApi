//
//  TradeItStockOrEtfTradeManager.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeItStockOrEtfTradeManager : NSObject

@property (copy) NSString * publisherApp;

- (id) initWithPublisherApp:(NSString *) publisherApp;

@end
