//
//  TradeItQuote.h
//  TradeItIosEmsApi
//
//  Created by Daniel Vaughn on 2/17/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIEMSJSONModel.h"

@protocol TradeItQuote
@end

@interface TradeItQuote : TIEMSJSONModel<NSCopying>


// The street symbol you passed in
@property (copy) NSString * symbol;

// The company name
@property (copy) NSString<Optional> * companyName;

// Ask price
@property (copy) NSNumber * askPrice;

// Bid price
@property (copy) NSNumber * bidPrice;

// Last trade price
@property (copy) NSNumber<Optional> * lastPrice;

// change in the price, previous close to lastPrice
@property (copy) NSNumber<Optional> * change;

// percentage change in price, previous close to lastPrice
@property (copy) NSNumber<Optional> * pctChange;

// The day's lowest traded price
@property (copy) NSNumber * low;

// The day's highest traded price
@property (copy) NSNumber * high;

// total trading volume for the day
@property (copy) NSNumber<Optional> * volume;

// date time of the last trade
@property (copy) NSString<Optional> * dateTime;

// Initialize with dictionary containing property data
-(id) initWithQuoteData:(NSDictionary *)quoteData;

@end
