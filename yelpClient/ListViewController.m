//
//  ListViewController.m
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/21/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import "ListViewController.h"
#import "AppModel.h"
#import "ListItemViewCell.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

static NSString *cellIdentifier = @"ListItemViewCellId";

@interface ListViewController ()

@property (strong, nonatomic) AppModel* model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ListItemViewCell *prototypeCell;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.model = [[AppModel alloc] init];
        self.model.observer = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    //self.tableView.rowHeight  = 130; //UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 105;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ListItemViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    [super viewDidLoad];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)];
    self.searchBar.placeholder = @"Search";
    self.searchBar.userInteractionEnabled=YES;
    //self.searchBar.delegate = self;
    [self.searchBar setBarTintColor:[UIColor colorWithRed:(196.0f/255) green:(18.0f/255) blue:0 alpha:1]];
    [self.searchBar setTranslucent:YES];
    
    self.navigationItem.titleView = self.searchBar;
    
    //UIView* filterButton = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 44.0)];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    
    [self.model searchWithTerm:@"Thai"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.model != nil) {
        return [self.model getResultCount];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (self.model == nil) {
        return cell;
    }
    
    int rowIndex = indexPath.row;
    
    [self configureCell:cell index:rowIndex];
    
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.prototypeCell)
    {
        self.prototypeCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    [self configureCell:self.prototypeCell index:indexPath.row];
    
    self.prototypeCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(self.prototypeCell.bounds));
    
    [self.prototypeCell setNeedsLayout];
    [self.prototypeCell layoutIfNeeded];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
}

-(void) configureCell:(ListItemViewCell*)itemCell index:(int)rowIndex
{
    NSDictionary* item = [self.model getBusinessItem:rowIndex];
    
    /*if(rowIndex == 0) {
        itemCell.itemTitleLabel.text = @"This is a restaurant with a very long name in the beautiful city of San Francisco";
        itemCell.itemReviewCountLabel.text = @"10000 Reviews";
        itemCell.itemAddressLabel.text = @"Street Num, Then the streen name, then the unit number, city and pin code";
        itemCell.itemCategoriesLabel.text = @"Category1, Category2, Category3, Category4, Category5, Category6, Category7";
        
        NSURL* thumbnailUrl = [[NSURL alloc] initWithString:[self.model getItemImageUrlString:rowIndex]];
        [itemCell.itemImageView setImageWithURL:thumbnailUrl placeholderImage:nil];
        itemCell.itemImageView.layer.cornerRadius = 5.0f;
        itemCell.itemImageView.clipsToBounds = YES;
        
        NSURL* ratingsImgUrl = [[NSURL alloc] initWithString:[self.model getRatingImageUrlString:rowIndex]];
        [itemCell.itemStarsImageView setImageWithURL:ratingsImgUrl placeholderImage:[UIImage imageNamed:@"stars_4_half.png"]];
        return;
    }*/
    
    if (item) {
        itemCell.itemTitleLabel.text = [NSString stringWithFormat:@"%d. %@", rowIndex + 1, item[@"name"]];
        itemCell.itemReviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews", item[@"review_count"]];
        itemCell.itemAddressLabel.text = [self.model getBusinessItemAddress:rowIndex];
        itemCell.itemCategoriesLabel.text = [self.model getCategoryListString:rowIndex];
        
        NSURL* thumbnailUrl = [[NSURL alloc] initWithString:[self.model getItemImageUrlString:rowIndex]];
        [itemCell.itemImageView setImageWithURL:thumbnailUrl placeholderImage:nil];
        itemCell.itemImageView.layer.cornerRadius = 5.0f;
        itemCell.itemImageView.clipsToBounds = YES;
        
        NSURL* ratingsImgUrl = [[NSURL alloc] initWithString:[self.model getRatingImageUrlString:rowIndex]];
        [itemCell.itemStarsImageView setImageWithURL:ratingsImgUrl placeholderImage:[UIImage imageNamed:@"stars_4_half.png"]];
    }
}

// From UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// From AppModelObserver

-(void)searchResultsLoaded
{
    [self.tableView reloadData];
}

-(void)searchFailed:(NSError*)error
{
    
}


@end
