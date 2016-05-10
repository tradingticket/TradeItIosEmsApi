//
//  TradeItBrokerCenterBroker.h
//  TradeItIosEmsApi
//
//  Created by Daniel Vaughn on 5/10/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIEMSJSONModel.h"

@protocol TradeItBrokerCenterBroker
@end

@interface TradeItBrokerCenterBroker : TIEMSJSONModel<NSCopying>

@property (copy) NSString<Optional> * broker;

@property (copy) NSNumber<Optional> * active;

@property (copy) NSDictionary<Optional> * offers;

@property (copy) NSDictionary<Optional> * colors;

@property (copy) NSDictionary<Optional> * logo;

@property (copy) NSArray<Optional> * disclaimers;

@end
