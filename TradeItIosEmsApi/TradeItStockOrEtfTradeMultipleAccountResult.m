//
//  TradeItStockOrEtfTradeMultipleAccountResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItStockOrEtfTradeMultipleAccountResult.h"

@implementation TradeItStockOrEtfTradeMultipleAccountResult

- (id)initWithToken:(NSString *)token andShortMessage:(NSString *)shortMessage andLongMessages:(NSArray *)longMessages andAccountList:(NSArray* )accountList{
    
    self = [super initWithToken:token andShortMessage:shortMessage andLongMessages:longMessages];
    
    if(self){
        self.accountList = accountList;
    }
    return self;
}

- (id) init{
    return [self initWithToken:nil andShortMessage:nil andLongMessages:nil andAccountList:nil];
}

- (NSString*) description{
    return [NSString stringWithFormat:@"TradeItStockOrEtfTradeMultipleAccountResult: %@ accountList=%@ ",[super description], self.accountList ];
}


@end
