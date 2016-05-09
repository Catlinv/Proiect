//
//  QuestionBaseViewController.m
//  Proiect
//
//  Created by webteam on 22/02/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "QuestionBaseViewController.h"
#import "Question+CoreDataProperties.h"

@interface QuestionBaseViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *answerDescriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation QuestionBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self assignQuestion];
    self.answerTextField.delegate = self;
    self.view.backgroundColor = [UIColor blueColor];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.answerTextField becomeFirstResponder];
}

#pragma mark - Setters

- (void)setQuestion:(PROQuestion *)question {
    _question = question;
    
    [self assignQuestion];
}

#pragma mark - Private Methods

- (BOOL)didAnswerCorrectly {
    
    if ([[self.answerTextField.text lowercaseString]isEqualToString: [[self.question returnAnswer] lowercaseString]])
    {
        self.question.isSolved = @(YES);
        return YES;   
    }
    return NO;
}

- (void)assignQuestion {
    self.questionLabel.text = self.question.name;
    self.answerLabel.text = [self.question returnAnswer];
    self.answerDescriptionTextView.text = self.question.extraInfo;
}

#pragma mark - UITextFieldDelefgateMethods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self didAnswerCorrectly]){
        self.view.backgroundColor = [UIColor greenColor];
        [textField resignFirstResponder];
        PROUserDefaultsInstance.score++;
        self.answerTextField.hidden = YES;
        self.answerDescriptionTextView.hidden = NO;
        [self.answerLabel setHidden:NO];
        
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
