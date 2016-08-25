//
//  TradeItFxAccountOverview.h
//  TradeItIosEmsApi
//
//  Created by Guillaume Debavelaere on 8/25/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TIEMSJSONModel.h"

@interface TradeItFxAccountOverview : TIEMSJSONModel

@property (copy) NSNumber<Optional> *totalValueBaseCurrency;

@property (copy) NSNumber<Optional> *totalValueUSD;

@property (copy) NSNumber<Optional> *buyingPowerBaseCurrency;

@property (copy) NSNumber<Optional> *unrealizedProfitAndLossBaseCurrency;

@property (copy) NSNumber<Optional> *realizedProfitAndLossBaseCurrency;

@property (copy) NSNumber<Optional> *marginBalanceBaseCurrency;

@end
