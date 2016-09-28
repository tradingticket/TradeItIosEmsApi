//
//  TradeItGetPositionsResults.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 2/3/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeItResult.h"
#import "TradeItPosition.h"
#import "TradeItFxPosition.h"

@interface TradeItGetPositionsResult : TradeItResult

// The total account value
@property (copy) NSNumber<Optional> *currentPage;

// Cash available to withdraw
@property (copy) NSNumber<Optional> *totalPages;

// All non-FX positions in the account
@property NSArray<TradeItPosition, Optional> *positions;

// All FX positions in the account
@property NSArray<TradeItFxPosition, Optional> *fxPositions;

// The base currency used for the positions
@property (copy) NSString<Optional> *accountBaseCurrency;

@end
