//
//  YelpClient.h
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/21/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"

@interface YelpClient : BDBOAuth1RequestOperationManager

- (id) initWithConsumerKey:(NSString *)consumerKey
           consumerSecret :(NSString *)consumerSecret
           accessToken    :(NSString *)accessToken
           accessSecret   :(NSString *)accessSecret;

- (AFHTTPRequestOperation *) searchWithTerm:(NSString *)term 
                                    success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
