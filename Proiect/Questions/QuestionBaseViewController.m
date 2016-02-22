//
//  QuestionBaseViewController.m
//  Proiect
//
//  Created by webteam on 22/02/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "QuestionBaseViewController.h"

@interface QuestionBaseViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation QuestionBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
