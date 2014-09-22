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

static NSString *cellIdentifier = @"ListItemViewCellId";

@interface ListViewController ()

@property (strong, nonatomic) AppModel* model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.model = [[AppModel alloc] init];
        self.model.observer = self;
        self.title = @"Results";
    }
    
    return self;
}

- (void)viewDidLoad
{
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight  = 130;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ListItemViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    [super viewDidLoad];
    
    [self.model searchWithTerm:@"Indian"];
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
    
    NSDictionary* item = [self.model getBusinessItem:rowIndex];
    if (item) {
        cell.itemTitleLabel.text = [NSString stringWithFormat:@"%d. %@", rowIndex + 1, item[@"name"]];
        cell.itemStarsLabel.text = [NSString stringWithFormat:@"%@ stars", item[@"rating"]];
        cell.itemReviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews", item[@"review_count"]];
        cell.itemAddressLabel.text = [self.model getBusinessItemAddress:rowIndex];
        cell.itemCategoriesLabel.text = [self.model getCategoryListString:rowIndex];
    }
    
    return cell;
}

// From UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
