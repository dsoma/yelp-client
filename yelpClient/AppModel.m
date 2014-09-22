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
@property (strong, nonatomic) NSArray* resultItems;

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
     
    success: ^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response[@"businesses"]);
        
        self.resultItems = response[@"businesses"];
        
        if (self.observer) {
            [self.observer searchResultsLoaded];
        }
    }
    
    failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
        
        if (self.observer) {
            [self.observer searchFailed:error];
        }
    }];
}

-(int) getResultCount
{
    if (self.resultItems != nil) {
        return [self.resultItems count];
    }
    return 0;
}

-(NSDictionary*) getBusinessItem:(int)itemIndex
{
    if (self.resultItems != nil && itemIndex >= 0 && itemIndex < self.resultItems.count) {
        return self.resultItems[itemIndex];
    }
    
    return nil;
}

-(NSString*) getBusinessItemAddress:(int)itemIndex
{
    NSDictionary* item = [self getBusinessItem:itemIndex];
    if (item) {
        NSDictionary* location = item[@"location"];
        NSArray* address = [location valueForKey:@"address"];
        return address[0];
    }
    
    return nil;
}

-(NSString*) getCategoryListString:(int)itemIndex
{
    NSArray* categoryList = [self getCategories:itemIndex];
    if(categoryList && categoryList.count > 0) {
        return [self getCategoryListStringFromArray:categoryList];
    }
    
    return nil;
}

-(NSString*) getRatingImageUrlString:(int)itemIndex
{
    NSDictionary* item = [self getBusinessItem:itemIndex];
    if (item) {
        return [item valueForKey:@"rating_img_url"];
    }
    
    return nil;
}

-(NSString*) getItemImageUrlString:(int)itemIndex
{
    NSDictionary* item = [self getBusinessItem:itemIndex];
    if (item) {
        return [item valueForKey:@"image_url"];
    }
    
    return nil;
}

-(NSArray*) getCategories:(int)itemIndex
{
    NSDictionary* item = [self getBusinessItem:itemIndex];
    if (item) {
        return [item valueForKey:@"categories"];
    }
    
    return nil;
}

-(NSString*) getCategoryListStringFromArray:(NSArray*)categories
{
    NSMutableString* resultString = [NSMutableString stringWithString:@""];
    for (int i = 0; (categories && i < categories.count); i++) {
        NSArray* item = categories[i];
        if (item && item.count > 0) {
            if (i != 0 ) {
                [resultString appendString:@", "];
            }
            [resultString appendString: item[0]];
        }
    }
    
    return resultString;
}

@end
