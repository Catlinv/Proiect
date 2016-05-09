//
//  PROQuestion.m
//  Proiect
//
//  Created by OctavF on 19/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PROQuestion.h"
#import "PROOption.h"

@implementation PROQuestion

// Insert code here to add functionality to your managed object subclass

- (void) fillQuestionWithQuestion:(PROQuestion *)question{
    self.name = question.name;
    self.type = question.type;
    self.longitude = question.longitude;
    self.extraInfo = question.extraInfo;
    self.latitude = question.latitude;
    self.isSolved = question.isSolved;
    self.isUnlocked = question.isUnlocked;
    self.options = question.options;
}

- (NSString*) returnAnswer {
    
    
    __block NSString *result = nil;
    [self.options enumerateObjectsUsingBlock:^(PROOption * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj.isAnswer boolValue] == TRUE)
            result = obj.answer;
    }];
    return result;
}

@end
