//
//  YelpClient.m
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/21/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient

NSString* yelpAPIbaseUrlString = @"http://api.yelp.com/v2/";

- (id) initWithConsumerKey:(NSString *)consumerKey
           consumerSecret :(NSString *)consumerSecret
           accessToken    :(NSString *)accessToken
           accessSecret   :(NSString *)accessSecret
{
    NSURL *baseURL = [NSURL URLWithString:yelpAPIbaseUrlString];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    
    return self;
}

- (AFHTTPRequestOperation *) searchWithTerm:(NSString *)term
                                    success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    
    NSDictionary *parameters = @{@"term": term,  @"ll" : @"37.7900274,-122.4053277" };
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}


@end
