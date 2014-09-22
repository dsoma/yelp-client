//
//  ListItemViewCell.h
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/21/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListItemViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *itemStarsImageView;

@property (weak, nonatomic) IBOutlet UILabel *itemReviewCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *itemAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *itemCategoriesLabel;

-(void) setItemTitle:(NSString*)itemTitle;

@end
