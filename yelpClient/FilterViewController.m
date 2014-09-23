//
//  FilterViewController.m
//  yelpClient
//
//  Created by Deepak Somashekhara on 9/23/14.
//  Copyright (c) 2014 Deepak Somashekhara. All rights reserved.
//

#import "FilterViewController.h"
#import "SwitchFilterViewCell.h"

static NSString *switchFilterCellId = @"SwitchFilterCellId";

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
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchFilterViewCell" bundle:nil] forCellReuseIdentifier:switchFilterCellId];
    
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
        case 0: return 1;
        case 1: return 5;
        case 2: return 5;
        case 3: return 4;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0: return @"General Features";
        case 1: return @"Category";
        case 2: return @"Distance";
        case 3: return @"Sort by";
    }
    return @"Filter";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    // Configure the cell...
    
    switch (section)
    {
        case 0:
        {
            SwitchFilterViewCell* sfvCell = [tableView dequeueReusableCellWithIdentifier:switchFilterCellId];
            if (indexPath.row == 0)
            {
                sfvCell.descLabel.text = @"Offering a deal";
            }
            return sfvCell;
        }
    }
    
    return [[UITableViewCell alloc] init];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
