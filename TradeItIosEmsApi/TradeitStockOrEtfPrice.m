//
//  TradeitStockOrEtfPrice.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "TradeitStockOrEtfPrice.h"



@implementation TradeitStockOrEtfPrice

+ (NSDictionary *)priceTypeStrings
{
    return @{@(TradeItPriceMarket) : @"market",
             @(TradeItPriceLimit) : @"limit",
             @(TradeItPriceStopLimit) : @"stopLimit",
             @(TradeItPriceStopMarket) : @"stopMarket"
             };
}


- (NSString*) getTypeString{
    
    if(self.type >= TradeItPriceTypeUnknown){
        return @"unknownPriceType";
    }
    else{
        return [[self class] priceTypeStrings][@(self.type)];
    }
}

- (id) initMarket{
    return [self initWithType:TradeItPriceMarket andLimit:0.0 andStop:0.0];
}

- (id) initLimit: (double) limitPrice{
    return [self initWithType:TradeItPriceLimit andLimit:limitPrice andStop:0.0];
}

- (id) initStopLimit: (double) limitPrice : (double) stopPrice{
    return [self initWithType:TradeItPriceStopLimit andLimit:limitPrice andStop:stopPrice];
}

- (id) initStopMarket: (double) stopPrice{
    return [self initWithType:TradeItPriceStopMarket andLimit:0.0 andStop:stopPrice];
}

- (id) init{
    return [self initWithType:TradeItPriceMarket andLimit:0.0 andStop:0.0];
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] initWithType:self.type andLimit:self.limitPrice andStop:self.stopPrice];
    return copy;
}

//private method
- (id) initWithType:(TradeItStockOrEtfPriceType) type andLimit:(double)limitPrice andStop:(double)stopPrice{
    self = [super init];
    if (self) {
        self.type = type;
        self.limitPrice = limitPrice;
        self.stopPrice = stopPrice;
    }
    return self;
}




@end
