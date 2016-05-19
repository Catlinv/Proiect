//
//  QuestionBaseViewController.h
//  Proiect
//
//  Created by webteam on 22/02/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PROQuestion.h"

@interface QuestionBaseViewController : UIViewController

@property (strong, nonatomic)  PROQuestion *question;

//Protected

- (void) didAnswerCorrectly;
- (void) hideWorkingUI;

@property (strong, nonatomic) IBOutlet UIView *questionWorkingView;

//†† Jesus was here ††

@end
