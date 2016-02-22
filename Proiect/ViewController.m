//
//  ViewController.m
//  Proiect
//
//  Created by user on 03/12/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "ViewController.h"
#import "OptionsTableViewController.h"
#import "QuestionBaseViewController.h"

const CGFloat kMinImageHeight = 64.0;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *statsLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *intrebariScroll;
@property (weak, nonatomic) IBOutlet UIImageView *imageStart;

@property (nonatomic, assign) NSUInteger i;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) CGFloat maxImageHeight;
@property (nonatomic, assign) CGFloat prevScrollOffsetY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.i = 0;
    self.prevScrollOffsetY = 0;
    self.statsLabel.text = [@(self.i) stringValue];
    self.colors = @[[UIColor blackColor], [UIColor blueColor], [UIColor redColor]];
    self.intrebariScroll.dataSource = self;
    self.intrebariScroll.delegate = self;
    self.maxImageHeight = self.view.frame.size.height / 2.0;
    CGRect frame =  self.imageStart.frame;
    frame.size.height = self.view.frame.size.height / 2.0;
    self.imageStart.frame = frame;
//    self.imageStart.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

- (IBAction)optionsButtonTapped:(id)sender {
    OptionsTableViewController *optionsMenu = [[OptionsTableViewController alloc] init];
    
    optionsMenu.view.frame = self.view.bounds;
    [self.view addSubview:optionsMenu.view];
    /*Calling the addChildViewController: method also calls
     the child’s willMoveToParentViewController: method automatically */
    [self addChildViewController:optionsMenu];
    [optionsMenu didMoveToParentViewController:self];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    if (self.imageStart.frame.size.height == self.maxImageHeight) {
//        CGRect frame =  self.imageStart.frame;
//        frame.size.height = self.view.frame.size.height / 2.0;
//        self.imageStart.frame = frame;
//    }
//    else
    self.prevScrollOffsetY = self.intrebariScroll.contentOffset.y;
    self.maxImageHeight = self.view.frame.size.height / 2.0;
}

#pragma mark - Private Methods

- (void)presentViewController:(UIViewController *)viewControllerToPresent forCellAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.intrebariScroll cellForItemAtIndexPath:indexPath];
    CGRect cellFrame = [self.view convertRect:cell.frame fromView:self.intrebariScroll];
    CGRect viewFinal = viewControllerToPresent.view.frame;
    
    viewControllerToPresent.view.frame = cellFrame;
    [self.view addSubview:viewControllerToPresent.view];
    /*Calling the addChildViewController: method also calls
     the child’s willMoveToParentViewController: method automatically */
    [self addChildViewController:viewControllerToPresent];
    [viewControllerToPresent didMoveToParentViewController:self];
    
    [viewControllerToPresent.view layoutIfNeeded];
    
    [UIView animateWithDuration:1.0 animations:^{
        viewControllerToPresent.view.frame = viewFinal;
        //[viewControllerToPresent.view setNeedsUpdateConstraints];
        [viewControllerToPresent.view layoutIfNeeded];
    }];
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 500;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Orice" forIndexPath:indexPath];
    cell.backgroundColor = [self.colors objectAtIndex:indexPath.row % 3];
    return cell;
}

#pragma mark - UICollectionViewDelgate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect frame =  self.imageStart.frame;
    CGFloat diff = self.prevScrollOffsetY - scrollView.contentOffset.y;
    
    if (diff < 0) {
        if (frame.size.height > kMinImageHeight && self.prevScrollOffsetY >= 0 && frame.size.height > kMinImageHeight) {
            frame.size.height += diff;
            if (frame.size.height < kMinImageHeight){
                frame.size.height = kMinImageHeight;
            }
            [scrollView setContentOffset:CGPointZero animated:NO];
            self.imageStart.frame = frame;
//            self.imageStart.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            //    [self.view layoutIfNeeded]
            frame = scrollView.frame;
            frame.origin.y = CGRectGetMaxY(self.imageStart.frame);
            frame.size.height = self.view.frame.size.height - frame.origin.y;
            scrollView.frame = frame;
        }

    }
    else if (self.prevScrollOffsetY <= 0 && frame.size.height + diff < self.maxImageHeight) {
        frame.size.height += diff;
        self.imageStart.frame = frame;
//        [scrollView setContentOffset:CGPointZero animated:NO];
//        self.imageStart.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        //    [self.view layoutIfNeeded]
        frame = scrollView.frame;
        frame.origin.y = CGRectGetMaxY(self.imageStart.frame);
        frame.size.height = self.view.frame.size.height - frame.origin.y;
        scrollView.frame = frame;
    }
    self.prevScrollOffsetY = scrollView.contentOffset.y;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    int index = indexPath.row % 3;
    
    switch (index) {
        case 0:
            //Black
            break;
        case 1: {
            //Blue
            QuestionBaseViewController *questionMenu = [[QuestionBaseViewController alloc] init];
            
            questionMenu.view.frame = self.view.bounds;
            [self presentViewController:questionMenu forCellAtIndexPath:indexPath];
            
            break;
        }
        case 2:
            //Red
            break;
        default:
            break;
    }
}

@end
