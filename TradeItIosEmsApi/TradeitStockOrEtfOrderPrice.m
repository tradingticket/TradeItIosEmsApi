//
//  TradeitStockOrEtfOrderPrice.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "TradeitStockOrEtfOrderPrice.h"



@implementation TradeitStockOrEtfOrderPrice

- (id) initMarket{
    return [self initWithType:@"market" andLimit:nil andStop:nil];
}

- (id) initLimit: (double) limitPrice{
    return [self initWithType:@"limit" andLimit:[NSNumber numberWithDouble:limitPrice] andStop:nil];
}

- (id) initStopLimit: (double) limitPrice : (double) stopPrice{
    return [self initWithType:@"stopLimit" andLimit:[NSNumber numberWithDouble:limitPrice] andStop:[NSNumber numberWithDouble:stopPrice]];
}

- (id) initStopMarket: (double) stopPrice{
    return [self initWithType:@"stopMarket" andLimit:nil andStop:[NSNumber numberWithDouble:stopPrice] ];
}

- (id) init{
    return [self initMarket];
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] initWithType:self.type andLimit:self.limitPrice andStop:self.stopPrice];
    return copy;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"TradeitStockOrEtfPrice : type:%@ limitPrice:%@ stopPrice:%@", self.type, self.limitPrice, self.stopPrice];
}


//private methods
- (id) initWithType:(NSString*) type andLimit:(NSNumber*) limitPrice andStop:(NSNumber*)stopPrice{
    self = [super init];
    if (self) {
        self.type = type;
        self.limitPrice = limitPrice;
        self.stopPrice = stopPrice ;
    }
    return self;
}


@end
