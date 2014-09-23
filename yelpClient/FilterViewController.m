//
//  FilterViewController.m
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/23/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import "FilterViewController.h"
#import "PriceViewCell.h"

static NSString *filterViewCellId = @"FilterViewCellId";

@interface FilterViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
    }
    
    return self;
}


- (void)viewDidLoad
{
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PriceViewCell" bundle:nil] forCellReuseIdentifier:filterViewCellId];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0: return 5;
        case 1: return 5;
        case 2: return 4;
        case 3: return 1;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0: return @"Category";
        case 1: return @"Distance";
        case 2: return @"Sort by";
        case 3: return @"General Features";
    }
    return @"Filter";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:filterViewCellId];
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
