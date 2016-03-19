//
//  QuestionBaseViewController.m
//  Proiect
//
//  Created by webteam on 22/02/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "QuestionBaseViewController.h"
#import "Question+CoreDataProperties.h"
#import "PROQuestion.h"

@interface QuestionBaseViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation QuestionBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.answerTextField.delegate = self;
    self.view.backgroundColor = [UIColor blueColor];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.answerTextField becomeFirstResponder];
}

#pragma mark - Private Methods

- (BOOL)didAnswerCorrectly {
    PROQuestion *tester =[PROQuestion new];
    tester.name = @"Test";
    
    if ([[self.answerTextField.text lowercaseString]isEqualToString: [[tester returnAnswer] lowercaseString]])
    {
        tester.isSolved = @(YES);
        return YES;   
    }
    return NO;
}

#pragma mark - UITextFieldDelefgateMethods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self didAnswerCorrectly]){
        self.view.backgroundColor = [UIColor greenColor];
        [textField resignFirstResponder];
        PROUserDefaultsInstance.score++;
        return YES;
    }
    self.view.backgroundColor = [UIColor redColor];
    return NO;
}

#pragma mark - Actions

- (IBAction)didTapBackButton:(id)sender {
    CGRect frame = self.view.frame;
    frame.origin.x = 2 * frame.size.width;
    
    [UIView animateWithDuration:1.05 animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

@end
