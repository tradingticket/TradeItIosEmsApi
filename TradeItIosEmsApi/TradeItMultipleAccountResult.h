//
//  TradeItMultipleAccountResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItInformationNeededResult.h"

@interface TradeItMultipleAccountResult : TradeItInformationNeededResult

@property (copy) NSArray * accountList;

@end
