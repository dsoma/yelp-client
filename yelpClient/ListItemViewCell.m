//
//  ListItemViewCell.m
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/21/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import "ListItemViewCell.h"

@interface ListItemViewCell ()



@end

@implementation ListItemViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setItemTitle:(NSString*)itemTitle
{
    self.itemTitleLabel.text = itemTitle;
}

@end
