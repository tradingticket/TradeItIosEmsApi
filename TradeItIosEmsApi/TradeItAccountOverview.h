//
//  TradeItAccountOverview.h
//  TradeItIosEmsApi
//
//  Created by Guillaume Debavelaere on 8/25/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TIEMSJSONModel.h"

@interface TradeItAccountOverview : TIEMSJSONModel

// The total account value
@property (copy) NSNumber<Optional> *totalValue;

// Cash available to withdraw
@property (copy) NSNumber<Optional> *availableCash;

// The buying power of the account
@property (copy) NSNumber<Optional> *buyingPower;

// The daily return of the account
@property (copy) NSNumber<Optional> *dayAbsoluteReturn;

// The daily return percentage
@property (copy) NSNumber<Optional> *dayPercentReturn;

// The total absolute return on the account
@property (copy) NSNumber<Optional> *totalAbsoluteReturn;

// The total percentage return on the account
@property (copy) NSNumber<Optional> *totalPercentReturn;

// The base currency used in the account
@property (copy) NSString<Optional> *accountBaseCurrency;

@end
