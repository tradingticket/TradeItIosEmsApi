//
//  StockOrEtfTradeTest.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TradeItConnector.h"
#import "TradeItSession.h"
#import "TradeItAuthenticationInfo.h"
#import "TradeItAuthLinkResult.h"
#import "TradeItLinkedLogin.h"
#import "TradeItSecurityQuestionResult.h"
#import "TradeItAuthenticationResult.h"

#import "TradeItResult.h"
#import "TradeItErrorResult.h"

#import "TradeItTradeService.h"
#import "TradeItPreviewTradeRequest.h"
#import "TradeItPreviewTradeResult.h"
#import "TradeItPlaceTradeRequest.h"
#import "TradeItPlaceTradeResult.h"

#import "TradeItBalanceService.h"
#import "TradeItAccountOverviewRequest.h"
#import "TradeItAccountOverviewResult.h"

#import "TradeItPositionService.h"
#import "TradeItGetPositionsRequest.h"
#import "TradeItGetPositionsResult.h"

#import "TradeItMarketDataService.h"
#import "TradeItQuotesRequest.h"
#import "TradeItQuotesResult.h"
#import "TradeItSymbolLookupRequest.h"
#import "TradeItSymbolLookupResult.h"


@interface StockOrEtfTradeTest : XCTestCase

@property (strong, nonatomic) TradeItConnector *connector;

@end

@implementation StockOrEtfTradeTest

- (void)setUp {
    [super setUp];

    self.connector = [[TradeItConnector alloc] initWithApiKey:@"tradeit-test-api-key"];
    self.connector.environment = TradeItEmsTestEnv;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSLog(@"******************Testing Fetch Broker List");
    [self testFetchBrokerList:self.connector];
    
    NSLog(@"******************Testing oAuth Link to Dummy broker");
    TradeItAuthLinkResult *authLink = [self testAuthLink:self.connector];
    
    if (![authLink.status isEqualToString:@"SUCCESS"]) {
        NSLog(@"Something failed during auth link, unable to proceed");
        return;
    }
    
    NSLog(@"*******************Testing saving/removing token into keychain");
    TradeItLinkedLogin *linkedLogin = [self testLinkingAccount:self.connector
                                                      withLink:authLink];

    NSLog(@"*******************Testing authentication");
    TradeItSession *session = [self testAuthentication:self.connector
                                       withLinkedLogin:linkedLogin];
    NSLog(@"Session Established:  %@", session);
    
    NSLog(@"*******************Testing answering sec question");
    NSString *account = [self testAnswerSecQuestion:session];
 
    NSLog(@"*******************Testing preview order");
    NSString *orderId = [self testPreviewTrade:session
                                    andAccount:account];

    NSLog(@"*******************Testing place order");
    [self testPlaceOrder:session
             withOrderId:orderId];
    
    NSLog(@"*******************Testing balance service");
    [self testAccountOverview:session
                  withAccount:account];
    
    NSLog(@"*******************Testing position service");
    [self testAccountPositions:session
                   withAccount:account];
    
    NSLog(@"*******************Testing quote request");
    [self testQuoteRequest:session
                withSymbol:@"AAPL"];
    
    NSLog(@"*******************Testing symbol lookup request");
    [self testSymbolLookupRequest:session
                        withQuery:@"AA"];
    
}

- (void)testFetchBrokerList:(TradeItConnector *)connector {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request to get broker list should succeed"];
    
    [connector getAvailableBrokersWithCompletionBlock:^(NSArray *brokers) {
        NSLog(@"Brokers: %@", brokers);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (TradeItLinkedLogin *)testLinkingAccount:(TradeItConnector *)connector
                                  withLink:(TradeItAuthLinkResult *)link {

    TradeItLinkedLogin *linkedLogin = [connector saveLinkToKeychain:link
                                                         withBroker:@"Dummy"
                                                           andLabel:@"Dummy Test Save"];
    
    NSArray *accounts = [connector getLinkedLogins];
    NSLog(@"%@", accounts);
    BOOL found = NO;
    for (TradeItLinkedLogin *account in accounts) {
        if ([account.label isEqualToString: @"Dummy Test Save"]) {
            found = YES;
        }
    }
    
    if (!found) {
        XCTFail(@"Failed finding stored linked account");
    }
    
    [connector unlinkBroker:@"Dummy"];
    
    NSArray *accounts2 = [connector getLinkedLogins];
    NSLog(@"%@", accounts2);

    found = NO;

    for (TradeItLinkedLogin *account in accounts2) {
        if ([account.label isEqualToString: @"Dummy Test Save"]) {
            found = YES;
        }
    }
    
    if (found) {
        XCTFail(@"Failed removing stored linked account");
    }
    
    return linkedLogin;
}

- (TradeItAuthLinkResult *)testAuthLink: (TradeItConnector *) connector {
    NSLog(@"********Testing oAuth Invalid Case");
    [self testAuthLinkInvalid:connector];

    NSLog(@"********Testing oAuth Valid Case");
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request to link broker should succeed"];
    __block TradeItAuthLinkResult * resultToReturn;
    
    TradeItAuthenticationInfo * authInfo = [[TradeItAuthenticationInfo alloc] initWithId:@"dummySecurity"
                                                                             andPassword:@"dummy"
                                                                               andBroker:@"Dummy"];
    
    [connector linkBrokerWithAuthenticationInfo: authInfo andCompletionBlock:^(TradeItResult * result) {
        NSLog(@"Auth link repsonse: %@", result);
        resultToReturn = (TradeItAuthLinkResult *)result;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];

    return resultToReturn;
}

- (void)testAuthLinkInvalid:(TradeItConnector *) connector {
    XCTestExpectation * expectation = [self expectationWithDescription:@"Request to link broker should fail"];
    
    TradeItAuthenticationInfo * authInfo = [[TradeItAuthenticationInfo alloc] initWithId:@"fail" andPassword:@"dummy" andBroker:@"Dummy"];
    
    [connector linkBrokerWithAuthenticationInfo: authInfo andCompletionBlock:^(TradeItResult * result) {
        NSLog(@"Auth link repsonse: %@", result);
        
        if ([result isKindOfClass: [TradeItErrorResult class]] &&
           [[(TradeItErrorResult *)result code] intValue]  == 300) {
            
            [expectation fulfill];
        } else {
            XCTFail(@"Invalid credentials did not return expected response: %@", result);
        }
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (TradeItSession *)testAuthentication:(TradeItConnector *)connector
                       withLinkedLogin:(TradeItLinkedLogin *)linkedLogin {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Failed creating a session"];
    
    TradeItSession *session = [[TradeItSession alloc] initWithConnector:connector];
    
    [session authenticate:linkedLogin
      withCompletionBlock:^(TradeItResult *result) {
        NSLog(@"Auth Response: %@", result);
        
        if (![result isKindOfClass:[TradeItSecurityQuestionResult class]]) {
            XCTFail(@"Failed establishing a valid session");
        }
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
    return session;
}

- (NSString *)testAnswerSecQuestion:(TradeItSession *)session {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Failed answering security question"];
    __block NSString *accountNumber;
    
    [session answerSecurityQuestion:@"tradingticket"
                withCompletionBlock:^(TradeItResult *result) {
        NSLog(@"Ans. Sec. Response: %@", result);
        
        if (![result isKindOfClass:[TradeItAuthenticationResult class]]) {
            XCTFail(@"Failed to successfully answer security question");
        } else {
            accountNumber = [(TradeItAuthenticationResult *)result accounts][0][@"accountNumber"];
        }
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
    return accountNumber;
}

- (NSString *)testPreviewTrade:(TradeItSession *)session
                    andAccount:(NSString *)accountNumber {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Failed submitting preview order request"];
    __block NSString *orderId;
    
    TradeItTradeService *tradeService = [[TradeItTradeService alloc] initWithSession:session];
    
    TradeItPreviewTradeRequest *previewTradeRequest = [[TradeItPreviewTradeRequest alloc] init];
    previewTradeRequest.accountNumber = accountNumber;
    previewTradeRequest.orderSymbol = @"GE";
    previewTradeRequest.orderPriceType = @"limit";
    previewTradeRequest.orderAction = @"buy";
    previewTradeRequest.orderQuantity = [NSNumber numberWithInt:1];
    previewTradeRequest.orderExpiration = @"day";
    previewTradeRequest.orderLimitPrice = [NSNumber numberWithInt:20];
    
    [tradeService previewTrade:previewTradeRequest
           withCompletionBlock:^(TradeItResult *result) {
        NSLog(@"Preview Trade Result: %@", result);
        
        if (![result isKindOfClass:[TradeItPreviewTradeResult class]]) {
            XCTFail(@"Failed to successfully submit preview order");
        } else {
            orderId = [(TradeItPreviewTradeResult *)result orderId];
        }
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
    return orderId;
}

- (void)testPlaceOrder:(TradeItSession *)session
           withOrderId:(NSString *)orderId {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Failed submitting place order request"];
    
    TradeItPlaceTradeRequest *request = [[TradeItPlaceTradeRequest alloc] initWithOrderId:orderId];
    
    TradeItTradeService *tradeService = [[TradeItTradeService alloc] initWithSession:session];
    [tradeService placeTrade:request
         withCompletionBlock:^(TradeItResult *result) {
        NSLog(@"Place Trade Result: %@", result);
        
        if (![result isKindOfClass:[TradeItPlaceTradeResult class]]) {
            XCTFail(@"Failed to successfully place order");
        }
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testAccountOverview:(TradeItSession *)session
                withAccount:(NSString *)account {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Failed getting account overview"];
    
    TradeItBalanceService *balances = [[TradeItBalanceService alloc] initWithSession:session];
    TradeItAccountOverviewRequest *overviewRequest = [[TradeItAccountOverviewRequest alloc] initWithAccountNumber:account];
    
    [balances getAccountOverview:overviewRequest
             withCompletionBlock:^(TradeItResult *result) {
        NSLog(@"Account Overview Result: %@", result);
        
        if (![result isKindOfClass:[TradeItAccountOverviewResult class]]) {
            XCTFail(@"Failed to successfully get account overview");
        }
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testAccountPositions:(TradeItSession *)session
                withAccount:(NSString *)account {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Failed getting account positions"];
    
    TradeItPositionService *positions = [[TradeItPositionService alloc] initWithSession:session];
    TradeItGetPositionsRequest *positionsRequest = [[TradeItGetPositionsRequest alloc] initWithAccountNumber:account];
    
    [positions getAccountPositions:positionsRequest
               withCompletionBlock:^(TradeItResult *result) {
        NSLog(@"Account Positions Result: %@", result);
        
        if (![result isKindOfClass:[TradeItGetPositionsResult class]]) {
            XCTFail(@"Failed to successfully place order");
            NSLog(@"Account Overview Result: %@", (TradeItGetPositionsResult *) result);
        }
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testQuoteRequest:session withSymbol:(NSString *)symbol {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Failed getting quote"];
    
    TradeItMarketDataService *mds = [[TradeItMarketDataService alloc] initWithSession:session];
    TradeItQuotesRequest *quoteRequest = [[TradeItQuotesRequest alloc] initWithSymbol:symbol];
    
    [mds getQuoteData:quoteRequest withCompletionBlock:^(TradeItResult *result) {
        NSLog(@"Quote Result: %@", result);
        
        if (![result isKindOfClass:[TradeItQuotesResult class]]) {
            XCTFail(@"Failed to successfully get quote");
            NSLog(@"Quote Result: %@", (TradeItQuotesResult *) result);
        }
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testSymbolLookupRequest:session
                      withQuery:(NSString *)query {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Failed getting symbol lookup"];
    
    TradeItMarketDataService *mds = [[TradeItMarketDataService alloc] initWithSession:session];
    TradeItSymbolLookupRequest *symbolLookupRequest = [[TradeItSymbolLookupRequest alloc] initWithQuery:query];
    
    [mds symbolLookup:symbolLookupRequest withCompletionBlock:^(TradeItResult *result) {
        NSLog(@"Symbollookup Result: %@", result);
        
        if (![result isKindOfClass:[TradeItSymbolLookupResult class]]) {
            XCTFail(@"Failed to successfully get symbollookup");
            NSLog(@"Quote Result: %@", (TradeItSymbolLookupResult *)result);
        }
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end
