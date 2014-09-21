//
//  AppModel.m
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/21/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import "AppModel.h"
#import "YelpClient.h"

NSString * const kYelpConsumerKey       = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret    = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken             = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret       = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface AppModel ()

@property (strong, nonatomic) YelpClient* yelpClient;

@end

@implementation AppModel

-(id) init
{
    self.yelpClient = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                          consumerSecret:kYelpConsumerSecret
                                          accessToken:kYelpToken
                                          accessSecret:kYelpTokenSecret];
    
    return self;
}

-(void) searchWithTerm:(NSString *)searchTerm
{
    if (searchTerm == nil || ![searchTerm length])
        return;
    
    [self.yelpClient searchWithTerm:searchTerm
                            success:^(AFHTTPRequestOperation *operation, id response) {
                                NSLog(@"response: %@", response);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                NSLog(@"error: %@", [error description]);
                            }];
}

@end
