//
//  TradeitStockOrEtfOrderPrice.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "JSONModel.h"

@interface TradeitStockOrEtfOrderPrice : JSONModel<NSCopying>

@property (copy) NSString*  type;
@property (copy) NSNumber<Optional>* limitPrice;
@property (copy) NSNumber<Optional>* stopPrice;


- (id) initMarket;
- (id) initLimit: (double) limitPrice;
- (id) initStopLimit: (double) limitPrice : (double) stopPrice;
- (id) initStopMarket: (double) stopPrice;
@end
