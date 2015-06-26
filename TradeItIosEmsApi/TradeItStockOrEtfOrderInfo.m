//
//  TradeItStockOrEtfOrderInfo.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "TradeItStockOrEtfOrderInfo.h"

@implementation TradeItStockOrEtfOrderInfo


- (id) initWithAction:(TradeItStockOrEtfOrderAction) action andQuantity:(double) quantity andSymbol:(NSString*)symbol andPrice:(TradeitStockOrEtfOrderPrice*) price andExpiration:(TradeItStockOrEtfOrderExpiration) expiration{
    self = [super init];
    if (self) {
        self.action = [[self class ] getActionString:action];
        self.quantity = quantity;
        self.symbol = [symbol copy];
        self.price = [price copy];
        self.expiration = [[self class] getExpirationString:expiration];
    }
    return self;
}

- (id) init{
    return [self initWithAction:TradeItStockOrEtfOrderActionBuy andQuantity:0.0 andSymbol:@"" andPrice:[[TradeitStockOrEtfOrderPrice alloc] initMarket] andExpiration:TradeItStockOrEtfOrderExpirationDay];
}
- (NSString*) description{
    return [NSString stringWithFormat:@"TradeItStockOrEtfOrderInfo: action:%@ quantity:%d symbol:%@ price:%@ expiration:%@", self.action, self.quantity, self.symbol, self.price, self.expiration];
}

- (id)copyWithZone:(NSZone *)zone
{
    TradeItStockOrEtfOrderInfo *copy = [super copyWithZone:zone];
    if(copy){
        copy.action = [self.action copyWithZone:zone];
        copy.quantity = self.quantity;
        copy.symbol = [self.symbol copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.expiration = [self.expiration copyWithZone:zone];
    }
    return copy;
}


//private
+ (NSDictionary *)orderActionStrings
{
    return @{@(TradeItStockOrEtfOrderActionBuy) : @"buy",
             @(TradeItStockOrEtfOrderActionSell) : @"sell",
             @(TradeItStockOrEtfOrderActionSellShort) : @"sellShort",
             @(TradeItStockOrEtfOrderActionBuyToCover): @"buyToCover"
             };
}


+ (NSString*) getActionString: (TradeItStockOrEtfOrderAction) action{
    
    if(action >= TradeItStockOrEtfOrderActionUnknown){
        return @"unknownAction";
    }
    else{
        return [[self class] orderActionStrings][@(action)];
    }
}

+ (NSDictionary *)orderExpirationStrings
{
    return @{@(TradeItStockOrEtfOrderExpirationDay) : @"day",
             @(TradeItStockOrEtfOrderExpirationGtc) : @"gtc"
             };
}

+ (NSString*) getExpirationString:(TradeItStockOrEtfOrderExpiration) expiration{
    
    if(expiration >= TradeItStockOrEtfOrderExpirationUnknown){
        return @"unknownExpiration";
    }
    else{
        return [[self class] orderExpirationStrings][@(expiration)];
    }
}


@end
