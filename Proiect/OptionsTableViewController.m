//
//  OptionsTableViewController.m
//  Proiect
//
//  Created by OctavF on 14/12/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "OptionsTableViewController.h"

@interface OptionsTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) UIView *blurEffectView;

@end

@implementation OptionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:self.view.frame];
    self.view.backgroundColor = [UIColor clearColor];
    [self addOptionsTableBlurView];
    [self addTableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.05 animations:^{
        CGRect frame = self.tableView.frame;
        frame.origin.x = 0.0;
        self.tableView.frame = frame;
        self.blurEffectView.alpha = 1.0;
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Name"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Name"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *title = [NSString stringWithFormat:@"Option %ld %ld", (long)indexPath.section, indexPath.row];
    cell.textLabel.text = title;
    if (indexPath.row == 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==  1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        } else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
            
    }
}


#pragma mark - Actions

- (void)tapOnBlur {
    
    [UIView animateWithDuration:1.05 animations:^{
        CGRect frame = self.tableView.frame;
        frame.origin.x = -frame.size.width;
        self.tableView.frame = frame;
        self.blurEffectView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}




#pragma mark - PrivateUIMethods

- (void)addOptionsTableBlurView {
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        
    } else {
        self.blurEffectView = [[UIView alloc] init];
        self.blurEffectView.backgroundColor = [UIColor clearColor];
    }
    self.blurEffectView.frame = self.view.bounds;
    self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.blurEffectView.alpha = 0.0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnBlur)];
    [self.blurEffectView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:self.blurEffectView];
}

- (void)addTableView {
    CGRect frame = self.view.frame;
    frame.size.width = self.view.frame.size.width * 2.5 / 4;
    frame.origin.x = -frame.size.width;
    self.tableView = [[UITableView alloc] initWithFrame:frame];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor blueColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

@end
