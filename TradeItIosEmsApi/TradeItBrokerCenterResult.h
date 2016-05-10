//
//  TradeItBrokerCenterResult.h
//  TradeItIosEmsApi
//
//  Created by Daniel Vaughn on 5/10/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeItResult.h"
#import "TradeItBrokerCenterBroker.h"

@interface TradeItBrokerCenterResult : TradeItResult

@property NSArray<TradeItBrokerCenterBroker *> * brokers;

@end
