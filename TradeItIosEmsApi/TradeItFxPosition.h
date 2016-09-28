//
//  TradeItFxPosition.h
//  TradeItIosEmsApi
//
//  Created by Alexander Kramer on 8/23/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TIEMSJSONModel.h"

@protocol TradeItFxPosition
@end

@interface TradeItFxPosition : TIEMSJSONModel<NSCopying>

// The currency pair XXX/XXX
@property (copy) NSString<Optional> *symbol;

// The type of security: FX
@property (copy) NSString<Optional> *symbolClass;

// Holding type "LONG"
@property (copy) NSString<Optional> *holdingType;

// The contract/lot size
@property (copy) NSNumber<Optional> *quantity;

// Unrealized PnL denominated in the base currency of the account
@property (copy) NSNumber<Optional> *totalUnrealizedProfitAndLossBaseCurrency;

// Total value of the position denominated in the base currency of the account
@property (copy) NSNumber<Optional> *totalValueBaseCurrency;

// Total value of the position denominated in USD
@property (copy) NSNumber<Optional> *totalValueUSD;

// Average rate of the position
@property (copy) NSNumber<Optional> *averagePrice;

// Limit price of the position
@property (copy) NSNumber<Optional> *limitPrice;

// Stop price of the position
@property (copy) NSNumber<Optional> *stopPrice;

@end