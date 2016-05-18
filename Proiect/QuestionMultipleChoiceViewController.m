//
//  QuestionMultipleChoiceViewController.m
//  Proiect
//
//  Created by webteam on 17/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "QuestionMultipleChoiceViewController.h"

#define margin 5.0

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
    else
    {
        [self.view setBackgroundColor:[UIColor redColor]];
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
        [button setBackgroundColor:[UIColor purpleColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:currentOption.answer forState:UIControlStateNormal];
        
        [self.questionWorkingView addSubview:button];
        
        NSLayoutConstraint *halfWidth = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:-1.5 * margin];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:-1.5 * margin];
        
        NSLayoutConstraint *horizontalMargin = i%2 ? [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:margin] : [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-margin];
        
        NSLayoutConstraint *verticalMargin = i<2 ? [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin] : [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.questionWorkingView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-margin];
        
        
        
        [button.superview addConstraints:@[horizontalMargin,verticalMargin,halfWidth, height]];
        [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
    }
}
 

@end
