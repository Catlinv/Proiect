//
//  QuestionBaseViewController.m
//  Proiect
//
//  Created by webteam on 22/02/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "QuestionBaseViewController.h"
#import "Question+CoreDataProperties.h"
#import "ViewController.h"

@interface QuestionBaseViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *answerDescriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *descriptonQuestionConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *descriptionAnswerConstraint;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation QuestionBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self assignQuestion];
    if (![self.question.isSolved boolValue]){
        self.view.backgroundColor = [UIColor blueColor];
        self.answerTextField.delegate = self;
    }
    else
        [self presentSolvedScreen];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self prepareScreen];
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

#pragma mark - Protected Methods

- (void) didAnswerCorrectly {

    [self presentSolvedScreen];
    if (![self.question.isSolved boolValue])
        PROUserDefaultsInstance.score++;
    self.question.isSolved = @(1);
    #warning YOU FUCKED UP (UpdateCoreData)
    //TODO: (CS) Uptadte CoreData
}

- (void)hideWorkingUI {
    self.answerTextField.hidden = YES;
}

#pragma mark - Private Methods

- (void) presentSolvedScreen {
    self.view.backgroundColor = [UIColor greenColor];
    self.answerDescriptionTextView.hidden = NO;
    [self hideWorkingUI];
    if ([self.question.type integerValue] != PROQuestionTypeLocation)
        [self.answerLabel setHidden:NO];
}

- (BOOL)checkAnswer {
    
    return [[self.answerTextField.text lowercaseString]isEqualToString: [[self.question returnAnswer] lowercaseString]];
}

- (void)assignQuestion {
    self.questionLabel.text = self.question.name;
    self.answerLabel.text = [self.question returnAnswer];
    self.answerDescriptionTextView.text = self.question.extraInfo;
}


- (void)prepareScreen {
        switch ([self.question.type integerValue]) {
            case PROQuestionTypeTextInput:
                //Do nothing
            break;
            case PROQuestionTypeMultipleChoice:{
                self.answerTextField.hidden = YES;
                //self.descriptionAnswerConstraint.priority = 250;
                //self.descriptonQuestionConstraint.priority = 750;
            break;
            }
            case PROQuestionTypeLocation:{
                self.answerTextField.hidden = YES;
                self.descriptionAnswerConstraint.priority = 250;
                self.descriptonQuestionConstraint.priority = 750;
            break;
        }
        default:
            break;
        }
}

#pragma mark - UITextFieldDelefgateMethods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self checkAnswer]){
        [self didAnswerCorrectly];
        self.answerTextField.hidden = YES;
        [textField resignFirstResponder];
        
        return YES;
    }
    self.view.backgroundColor = [UIColor redColor];
    
    return NO;
}

#pragma mark - Actions

- (IBAction)didTapBackButton:(id)sender {
    
    ViewController *mainVC = (ViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [mainVC.intrebariScroll reloadData];
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
