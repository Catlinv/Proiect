//
//  QuestionMultipleChoiceViewController.m
//  Proiect
//
//  Created by webteam on 17/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "QuestionMultipleChoiceViewController.h"

@interface QuestionMultipleChoiceViewController ()

@property (strong, nonatomic) NSMutableArray *buttonArray;

@end

@implementation QuestionMultipleChoiceViewController

- (instancetype)init
{
    self = [super initWithNibName:@"QuestionBaseViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButtons];
}

#pragma mark - Private Methods

- (BOOL)checkAnswer:(UIButton*)button {
    if ([button.titleLabel.text isEqualToString:[self.question returnAnswer]])
    {
        self.question.isSolved = @(YES);
        return YES;
    }
    return NO;
}

#pragma mark - Actions

- (void) didTapButton:(UIButton *)button {
    if ([self checkAnswer:button])
    {
        [self didAnswerCorrectly];
        for (UIButton *b in self.buttonArray) {
            [b removeFromSuperview];
        }
        self.buttonArray = nil;
    }
}

#pragma mark - Private UI Methods

- (void)setupButtons {
    
    self.buttonArray = [NSMutableArray new];
    UIButton *button;
    PROOption *currentOption;
    NSArray<PROOption *> *optionsArray = [self.question.options allObjects];
    //((PROOption*)[asdf objectAtIndex:0]).answer;
    for (NSInteger i = 0; i < optionsArray.count; i++){
        currentOption = optionsArray[i];
        button = [UIButton new];
        [button setTitle:currentOption.answer forState:UIControlStateNormal];
        [self.questionWorkingView addSubview:button];
        
        NSLayoutConstraint *halfWidth = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeWidth multiplier:2.0 constant:0];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeHeight multiplier:2.0 constant:0];
        
        NSLayoutConstraint *horizontalMargin = i%2 ? [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0] : [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
        
        NSLayoutConstraint *verticalMargin = i<2 ? [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0] : [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        
        [button.superview addConstraints:@[horizontalMargin,verticalMargin,halfWidth, height]];
        [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
    }
}
 

@end
