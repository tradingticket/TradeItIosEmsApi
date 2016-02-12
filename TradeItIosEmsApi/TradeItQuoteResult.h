//
//  TradeItQuoteResult.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 2/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItResult.h"

@interface TradeItQuoteResult : TradeItResult

// The street symbol you passed in
@property (copy) NSString<Optional> * symbol;

// The company name
@property (copy) NSString<Optional> * companyName;

// Ask price
@property (copy) NSNumber<Optional> * askPrice;

// Bid price
@property (copy) NSNumber<Optional> * bidPrice;

// Last trade price
@property (copy) NSNumber<Optional> * lastPrice;

// change in the price, previous close to lastPrice
@property (copy) NSNumber<Optional> * change;

// percentage change in price, previous close to lastPrice
@property (copy) NSNumber<Optional> * pctChange;

// The day's lowest traded price
@property (copy) NSNumber<Optional> * low;

// The day's highest traded price
@property (copy) NSNumber<Optional> * high;

// total trading volume for the day
@property (copy) NSNumber<Optional> * volume;

// date time of the last trade
@property (copy) NSString<Optional> * dateTime;

@end
