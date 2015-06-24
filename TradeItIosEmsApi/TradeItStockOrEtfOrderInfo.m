//
//  TradeItStockOrEtfOrderInfo.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "TradeItStockOrEtfOrderInfo.h"

@implementation TradeItStockOrEtfOrderInfo

+ (NSDictionary *)orderActionStrings
{
    return @{@(TradeItActionBuy) : @"buy",
             @(TradeItActionSell) : @"sell",
             @(TradeItActionSellShort) : @"sellShort",
             @(TradeItActionBuyToCover): @"buyToCover"
             };
}

+ (NSDictionary *)orderExpirationStrings
{
    return @{@(TradeItExpirationDay) : @"day",
             @(TradeItExpirationGtc) : @"gtc"
             };
}


- (NSString*) getActionString{
    
    if(self.action >= TradeItActionUnknown){
        return @"unknownAction";
    }
    else{
        return [[self class] orderActionStrings][@(self.action)];
    }
}

- (NSString*) getExpirationString{
    
    if(self.expiration >= TradeItExpirationUnknown){
        return @"unknownExpiration";
    }
    else{
        return [[self class] orderExpirationStrings][@(self.expiration)];
    }
}

- (id) initWithAction:(TradeItStockOrEtfOrderAction) action andQuantity:(double) quantity andSymbol:(NSString*)symbol andPrice:(TradeitStockOrEtfPrice*) price andExpiration:(TradeItStockOrEtfOrderExpiration) expiration{
    self = [super init];
    if (self) {
        self.action = action;
        self.quantity = quantity;
        self.symbol = [symbol copy];
        self.price = [price copy];
        self.expiration = expiration;
    }
    return self;
}

- (NSString*) description{
    return [NSString stringWithFormat:@"TradeItStockOrEtfOrderInfo: action:%@ quantity:%d symbol:%@ price:%@ expiration:%@", [self getActionString], self.quantity, self.symbol, self.price, [self getExpirationString]];
}

@end
