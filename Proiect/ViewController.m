//
// ViewController.m
//  Proiect
//
//  Created by user on 03/12/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "ViewController.h"
#import "OptionsTableViewController.h"
//#import "QuestionBaseViewController.h"
#import "QuestionLocationViewController.h"
#import "QuestionMultipleChoiceViewController.h"
#import "PRODataGatherer.h"

const CGFloat kMinImageHeight = 64.0;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *statsLabel;
//@property (weak, nonatomic) IBOutlet UICollectionView *intrebariScroll;
@property (weak, nonatomic) IBOutlet UIImageView *imageStart;

@property (nonatomic, assign) NSUInteger i;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, assign) CGFloat maxImageHeight;
@property (nonatomic, assign) CGFloat prevScrollOffsetY;

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.i = 0;
    self.prevScrollOffsetY = 0;
    self.statsLabel.text = [@(self.i) stringValue];
    self.images = @{ @(PROQuestionTypeLocation):[UIImage imageNamed:@"compasIcon.jpg"],
                     @(PROQuestionTypeTextInput):[UIImage imageNamed:@"compasIcon.jpg"],
                     @(PROQuestionTypeMultipleChoice):[UIImage imageNamed:@"compasIcon.jpg"],
                     @(PROQuestionTypeSolved):[UIImage imageNamed:@"checkSign.png"]
                   };
    self.intrebariScroll.dataSource = self;
    self.intrebariScroll.delegate = self;
    self.maxImageHeight = self.view.frame.size.height / 2.0;
    CGRect frame =  self.imageStart.frame;
    frame.size.height = self.view.frame.size.height / 2.0;
    self.imageStart.frame = frame;
//    self.imageStart.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.statsLabel.text = [NSString stringWithFormat:@"%li",(long)PROUserDefaultsInstance.score];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDefaultsValueChanged:) name:kPROUserDefaultsValueChangedNotification  object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.intrebariScroll reloadData];
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
    return [[PRODataGatherer getQuestionsArray] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Orice" forIndexPath:indexPath];
    PROQuestion *tester = [[PRODataGatherer getQuestionsArray] objectAtIndex:indexPath.row];
    UIImageView *imageView;
    if (cell.contentView.subviews.count){
        imageView = [cell.contentView.subviews firstObject];
    }
    else {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imageView];
    }
    
    imageView.image = [self.images objectForKey:tester.type];
    imageView = nil;
    
    if (cell.contentView.subviews.count > 1){
        if ([tester.isSolved boolValue]){
        imageView = [cell.contentView.subviews objectAtIndex:1];
        }
    }
    else {
        if ([tester.isSolved boolValue]) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imageView];
        }
    }
    
    imageView.image = [self.images objectForKey:@(PROQuestionTypeSolved)];
    
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
    PROQuestion *tester =[PROQuestion new];
    tester = [[PRODataGatherer getQuestionsArray] objectAtIndex:indexPath.row];
//    tester.name = @"Test?";
//    tester.extraInfo = @"This is just a test";
//    tester.longitude = @(46);
//    tester.latitude = @(46);
//    PROOption *optiune = [PROOption new];
//    optiune.isAnswer = @(TRUE);
//    optiune.answer = @"aaa";
//    tester.options = [NSSet setWithObject:optiune];
    //NSArray *asdf = [tester.options allObjects];
    //((PROOption*)[asdf objectAtIndex:0]).answer;
    
    switch (index) {
        case 0:{
            //Black
            //tester.type = @(PROQuestionTypeLocation);
            QuestionBaseViewController *questionMenu = [[QuestionLocationViewController alloc] init];
            questionMenu.question = tester;
            questionMenu.view.frame = self.view.bounds;
            [self presentViewController:questionMenu forCellAtIndexPath:indexPath];
            break;
        }
        case 1: {
            //Blue
            //tester.type = @(PROQuestionTypeTextInput);
            QuestionBaseViewController *questionMenu = [[QuestionBaseViewController alloc] init];
            questionMenu.question = tester;
            questionMenu.view.frame = self.view.bounds;
            [self presentViewController:questionMenu forCellAtIndexPath:indexPath];
            
            break;
        }
        case 2:{
            //Red
//            PROOption *optiune1 = [PROOption new];
//            optiune1.isAnswer = @(NO);
//            optiune1.answer = @"bbb";
//            PROOption *optiune2 = [PROOption new];
//            optiune2.isAnswer = @(NO);
//            optiune2.answer = @"ccc";
//            PROOption *optiune3 = [PROOption new];
//            optiune3.isAnswer = @(NO);
//            optiune3.answer = @"ddd";
//            
//            NSMutableSet *asd = [tester.options mutableCopy];
//            [asd addObjectsFromArray:@[optiune1,optiune2,optiune3]];
//            tester.options = asd;
            
            //tester.type = @(PROQuestionTypeMultipleChoice);
            QuestionBaseViewController *questionMenu = [[QuestionMultipleChoiceViewController alloc] init];
            questionMenu.question = tester;
            questionMenu.view.frame = self.view.bounds;
            [self presentViewController:questionMenu forCellAtIndexPath:indexPath];
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - Notifications

- (void)userDefaultsValueChanged:(NSNotification *)notif {
    NSString *valueName = [notif.userInfo objectForKey:kPROUserDefaultsValueNameKey];
    
    if ([valueName isEqualToString:kPROScore]) {
        NSInteger newScore = [[notif.userInfo objectForKey:kPROUserDefaultsNewValueKey] integerValue];
        self.statsLabel.text = [NSString stringWithFormat:@"%li",(long)newScore];
    }
}

@end
