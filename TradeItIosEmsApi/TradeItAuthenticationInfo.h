//
//  TradeItRequestAuthenticationInfo.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface TradeItAuthenticationInfo : JSONModel<NSCopying>

@property (copy) NSString *id;
@property (copy) NSString *password;

- (id) initWithId:(NSString *)id andPassword:(NSString*) password;

@end
