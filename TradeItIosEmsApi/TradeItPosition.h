//
//  TradeItPosition.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 2/3/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIEMSJSONModel.h"

@protocol TradeItPosition
@end

@interface TradeItPosition : TIEMSJSONModel<NSCopying>

// The exchange symbol, or cusip for bonds
@property (copy) NSString<Optional> *symbol;

// The type of security: EQUITY_OR_ETF, MUTUAL_FUND, OPTION, FIXED_INCOME, CASH, UNKOWN
@property (copy) NSString<Optional> *symbolClass;

// "LONG" or "SHORT"
@property (copy) NSString<Optional> *holdingType;

// The total base cost of the security
@property (copy) NSNumber<Optional> *costbasis;

// The last traded price of the security
@property (copy) NSNumber<Optional> *lastPrice;

// The total quantity held. It's a double to support cash and Mutual Funds
@property (copy) NSNumber<Optional> *quantity;

// The total gain/loss in dollars for the day for the position
@property (copy) NSNumber<Optional> *todayGainLossDollar;

// The percentage gain/loss for the day for the position
@property (copy) NSNumber<Optional> *todayGainLossPercentage;

// The total gain/loss in dollars for the position
@property (copy) NSNumber<Optional> *totalGainLossDollar;

// The total percentage of gain/loss for the position
@property (copy) NSNumber<Optional> *totalGainLossPercentage;

@end
