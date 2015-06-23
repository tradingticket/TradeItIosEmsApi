//
//  TradeItAuthenticationInfo.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeItAuthenticationInfo : NSObject

@property (copy) NSString *id;
@property (copy) NSString *password;

- (id) initWithId:(NSString *)id andPassword:(NSString*) password;

@end
