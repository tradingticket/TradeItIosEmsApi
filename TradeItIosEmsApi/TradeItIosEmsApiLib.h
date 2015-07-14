//
//  TradeItIosEmsApiLib.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 7/8/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#ifndef TradeItIosEmsApi_TradeItIosEmsApiLib_h
#define TradeItIosEmsApi_TradeItIosEmsApiLib_h

//class that manages sending orders to the TradeIt Execution Management System (EMS)
#import "TradeItStockOrEtfTradeSession.h"
#import "TradeItVerifyCredentialSession.h"

//Authentication and Order Information classes
#import "TradeItStockOrEtfOrderPrice.h"
#import "TradeItStockOrEtfOrderInfo.h"
#import "TradeItAuthenticationInfo.h"

//Result classes from the requests sent the to EMS server
#import "TradeItResult.h"
#import "TradeItStockOrEtfTradeSuccessResult.h"
#import "TradeItStockOrEtfTradeReviewResult.h"
#import "TradeItStockOrEtfTradeReviewOrderDetails.h"
#import "TradeItSecurityQuestionResult.h"
#import "TradeItMultipleAccountResult.h"
#import "TradeItErrorResult.h"
#import "TradeItInformationNeededResult.h"
#import "TradeItTypeDefs.h"

#endif
