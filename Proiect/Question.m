//
//  Question.m
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "Question.h"
#import "Option.h"

@implementation Question

// Insert code here to add functionality to your managed object subclass

-(void) fillQuestionWithQuestion:(Question *)question{
    self.name = question.name;
    self.type = question.type;
    self.longitude = question.longitude;
    self.extraInfo = question.extraInfo;
    self.latitude = question.latitude;
    self.isSolved = question.isSolved;
    self.isUnlocked = question.isUnlocked;
    self.options = question.options;
}

@end
