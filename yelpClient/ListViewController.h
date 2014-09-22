//
//  ListViewController.h
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/21/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AppModelObserver>

@end
