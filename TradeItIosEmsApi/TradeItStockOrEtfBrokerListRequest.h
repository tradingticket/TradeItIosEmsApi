//
//  TradeItBrokerListRequest.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 8/4/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItRequest.h"

@interface TradeItStockOrEtfBrokerListRequest : TradeItRequest

@property (copy) NSString *publisherDomain;

- (id) initWithPublisherDomain:(NSString *)publisherDomain;


@end
