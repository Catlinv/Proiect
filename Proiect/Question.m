//
//  Question.m
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "Question.h"
#import "Option.h"
#import "PROQuestion.h"
#import "PROOption.h"

@implementation Question

// Insert code here to add functionality to your managed object subclass

- (void) fillQuestionWithQuestion:(Question *)question{
    self.name = question.name;
    self.type = question.type;
    self.longitude = question.longitude;
    self.extraInfo = question.extraInfo;
    self.latitude = question.latitude;
    self.isSolved = question.isSolved;
    self.isUnlocked = question.isUnlocked;
    self.options = question.options;
}

- (void) fillQuestionWithPROQuestion:(PROQuestion *)question{
    self.name = question.name;
    self.type = question.type;
    self.longitude = question.longitude;
    self.extraInfo = question.extraInfo;
    self.latitude = question.latitude;
    self.isSolved = question.isSolved;
    self.isUnlocked = question.isUnlocked;
}

- (NSString*) returnAnswer {
    
    Option *optiune = [Option new];
    optiune.isAnswer = @(TRUE);
    optiune.answer = @"aaa";
    self.options = [NSSet setWithObject:optiune];
    
    __block NSString *result = nil;
    [self.options enumerateObjectsUsingBlock:^(Option * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj.isAnswer boolValue] == TRUE)
            result = obj.answer;
    }];
    return result;
}

@end
