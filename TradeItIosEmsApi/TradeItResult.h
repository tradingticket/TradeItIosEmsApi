//
//  TradeItResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface TradeItResult : JSONModel

@property (copy) NSString* status;
@property (copy) NSString<Optional> * token;
@property (copy) NSString<Optional> * shortMessage;
@property (copy) NSArray<Optional> * longMessages;


@end
