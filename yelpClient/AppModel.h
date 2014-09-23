//
//  AppModel.h
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/21/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppModelObserver

-(void)searchResultsLoaded;
-(void)searchFailed:(NSError*)error;

@end

@interface AppModel : NSObject

@property (weak, nonatomic) id <AppModelObserver> observer;

-(void) searchWithTerm:(NSString*)searchTerm;
-(int)  getResultCount;
-(NSDictionary*) getBusinessItem:(int)itemIndex;
-(NSString*) getBusinessItemAddress:(int)itemIndex;
-(NSString*) getCategoryListString:(int)itemIndex;
-(NSString*) getRatingImageUrlString:(int)itemIndex;
-(NSString*) getItemImageUrlString:(int)itemIndex;
-(float) getDistanceInMiles:(int)itemIndex;

@end
