//
//  TradeItAccount.m
//  TradeItIosEmsApi
//
//  Created by Guillaume Debavelaere on 8/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItAccount.h"

@implementation TradeItAccount

- (id)initWithAccountBaseCurrency:(NSString *)accountBaseCurrency
                    accountNumber:(NSString *)accountNumber
                    accountName:(NSString *)accountName
                    tradable:(BOOL)tradable {
    if( self = [super init] )
    {
        self.accountBaseCurrency = accountBaseCurrency;
        self.accountNumber = accountNumber;
        self.accountName = accountName;
        self.tradable = tradable;
    }
    
    return self;
}

- (NSString*) description{
    return [NSString stringWithFormat:@"accountBaseCurrency=%@ accountNumber=%@ accountName=%@ tradable=%d",self.accountBaseCurrency, self.accountNumber, self.accountName, self.tradable];
}

@end