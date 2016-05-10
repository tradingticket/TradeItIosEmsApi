//
//  TradeItBrokerCenterBroker.h
//  TradeItIosEmsApi
//
//  Created by Daniel Vaughn on 5/10/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIEMSJSONModel.h"

@interface TradeItBrokerCenterBroker : TIEMSJSONModel<NSCopying>

@property (copy) NSString * broker;

@property (copy) NSNumber * active;

@property (copy) NSDictionary * offers;

@property (copy) NSDictionary * colors;

@property (copy) NSDictionary * logo;

@property (copy) NSArray * disclaimers;

@end
