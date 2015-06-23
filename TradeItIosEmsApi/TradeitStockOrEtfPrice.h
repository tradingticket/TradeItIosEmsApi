//
//  TradeitStockOrEtfPrice.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, TradeItStockOrEtfPriceType){
    TradeItPriceMarket = 0,
    TradeItPriceLimit,
    TradeItPriceStopLimit ,
    TradeItPriceStopMarket,
    TradeItPriceTypeUnknown
};

@interface TradeitStockOrEtfPrice : NSObject<NSCopying> 

@property TradeItStockOrEtfPriceType type;
@property double limitPrice;
@property double stopPrice;

- (NSString*) getTypeString;
- (id) initMarket;
- (id) initLimit: (double) limitPrice;
- (id) initStopLimit: (double) limitPrice : (double) stopPrice;
- (id) initStopMarket: (double) stopPrice;
@end
