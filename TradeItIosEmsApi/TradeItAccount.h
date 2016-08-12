//
//  TradeItAccount.h
//  TradeItIosEmsApi
//
//  Created by Guillaume Debavelaere on 8/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeItAccount : NSObject

@property (copy) NSString *accountBaseCurrency;

@property (copy) NSString *accountNumber;

@property (copy) NSString *accountName;

@property (assign, nonatomic) BOOL tradable;

- (id)initWithAccountBaseCurrency:(NSString *)accountBaseCurrency
               accountNumber:(NSString *)accountNumber
               accountName: (NSString *) accountName
               tradable: (BOOL) tradable;

@end
