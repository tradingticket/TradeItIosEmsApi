//
//  TradeItConnector.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 1/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TradeItTypeDefs.h"
#import "TradeItAuthenticationInfo.h"
#import "TradeItResult.h"
#import "TradeItAuthLinkResult.h"
#import "TradeItUpdateLinkResult.h"
#import "TradeItLinkedLogin.h"
#import "TradeItBroker.h"

/**
   Main class to manage the connection settings to the Trade It Execution Management System (EMS). And the account linking and storing of the userToken used for establishing the session
 */
@interface TradeItConnector : NSObject

/**
 *  The apiKey is generated by TradeIt and unique to your application and is required for all API requests
 */
@property NSString * _Nullable apiKey;

/**
 *  Environment to send the request to. Default value is TradeItEmsProductionEnv
 *  Tokens are specific to environment
 */
@property TradeitEmsEnvironments environment;

/**
 *  Connectors will always need an API key
 */
- (id _Nullable)initWithApiKey:(NSString * _Nullable) apiKey;

/**
 *  Return an array with all the brokers that support stockOrEtfTrading and are enabled for a given apiKey
 *
 *  @return Array NSDictionary objects, where each object has a "longName" and "shortName". The longName should be displauyed to the user and the short name should be used wbe sending a request to the ems server
 */
- (void)getAvailableBrokersWithCompletionBlock:(void (^ _Nullable)(NSArray * _Nullable))completionBlock;

- (void)getAvailableBrokersAsObjectsWithCompletionBlock:(void (^ _Nonnull)(NSArray<TradeItBroker *> * _Nullable))completionBlock;

/**
 *  A user oAuth token is generated given credentials for a broker. The token may be used to authenticate the user in the future without them having to re-enter their credentials.
 * **** This token should be treated and stored like a password.  *****
 *  It's recommended to use the saveLinkToKeychain method to hold onto the token, and use either touchId or a short password like a 4 digit pen before retrieving the token for the user
 *  
 *  @return TradeItResult returned into the completion block will indicate success/failure of the credentials
 */
- (void) linkBrokerWithAuthenticationInfo:(TradeItAuthenticationInfo * _Nullable)authInfo
                       andCompletionBlock:(void (^ _Nullable)(TradeItResult * _Nullable))completionBlock;

/**
 *  If the oAuth token becomes stale, we can issue a new token by the previous linked login. This will replace the occurrence, if any, in the keychain/userprofile.  If it was never previously saved, it will be created.
 *
 *  @return TradeItResult returned in completion block if successful will include a new userId and userToken
 */
- (void)updateUserToken:(TradeItLinkedLogin *)linkedLogin
 withAuthenticationInfo:(TradeItAuthenticationInfo *)authInfo
     andCompletionBlock:(void (^)(TradeItResult *))completionBlock;

/**
 *  Using a successful response from the linkBrokerWithAuthenticationInfo:andCompletionBlock: this method will save basic information to the user preferences, and a UUID pointed to the actual user token which will be stored in the keychain.
 */
- (TradeItLinkedLogin * _Nullable)saveLinkToKeychain:(TradeItAuthLinkResult * _Nullable)link
                                withBroker:(NSString * _Nullable)broker;

/**
 *  Same as above, but with a custom label. Useful if allowing users to link to more than one login per broker. The default, in the above method, is just the broker name.
 */
- (TradeItLinkedLogin * _Nullable)saveLinkToKeychain:(TradeItAuthLinkResult * _Nullable)link
                                withBroker:(NSString * _Nullable)broker
                                  andLabel:(NSString * _Nullable)label;

/**
 *  Using a successful response from the updateUserToken:withAuthenticationInfo:andCompletionBlock: this method will update the keychain token for an already linked account.
 */
- (TradeItLinkedLogin *)updateLinkInKeychain:(TradeItUpdateLinkResult *)link
                                  withBroker:(NSString *)broker;

/**
 *  Retrieve a list of stored linkedLogins
 * @return an Array of TradeItLinkedLogin
 */
- (NSArray * _Nullable)getLinkedLogins;

/**
 *  Exchange the keychainId for the userToken associated with it.
 *  This is the last chance to protect the user, retrieving this token should be protected by a pin, password or touchId.
 *
 *  @return token, to establish a session with the associated user and broker
 */
- (NSString * _Nullable)userTokenFromKeychainId:(NSString * _Nullable)keychainId;

/**
 *  Used to unlink the linked account. Should be exposed to the user via the app settings.
 */
- (void)unlinkBroker:(NSString * _Nullable)broker;

- (void)unlinkLogin:(TradeItLinkedLogin * _Nullable)login;

/**
 *  If the oAuth token becomes stale, we can issue a new token by the previous linked login. This will replace the occurrence, if any, in the keychain/userprofile
 *
 *  @return TradeItResult if successful will include a new userId and userToken
 */
- (TradeItResult * _Nullable)updateUserToken:(TradeItLinkedLogin * _Nullable)linkedLogin
            withAuthenticationInfo:(TradeItAuthenticationInfo * _Nullable)authInfo;




/**
 *  Method used by the session and services to issue requests to the ems servers
 *  You shouldn't need to call this method directly
 */
- (void)sendEMSRequest:(NSMutableURLRequest * _Nullable)request
   withCompletionBlock:(void (^ _Nullable)(TradeItResult * _Nullable, NSMutableString * _Nullable))completionBlock;

@end
