//
//  TradeItMultipleAccountResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItInformationNeededResult.h"

/**
 *  Returned if the user has multiple account wioth a given broker and needs to select the account to interact with
 */
@interface TradeItMultipleAccountResult : TradeItInformationNeededResult

/**
 *  An array of objects, where each object has a "name" and "value" property corresponding to the account.
 *  The name should be displayed to the user. The whole object for the account should be sent back to the server when calling
 *  the selectAccount method of the TradeItStockOrEtfTradeSession
 */
@property (copy) NSArray * accountList;

@end
