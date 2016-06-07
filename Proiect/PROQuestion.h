//
//  PROQuestion.h
//  Proiect
//
//  Created by NOTOctavF on 19/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PROOption.h"

typedef NS_ENUM (NSInteger, PROQuestionType) {
    PROQuestionTypeLocation,
    PROQuestionTypeTextInput,
    PROQuestionTypeMultipleChoice,
    PROQuestionTypeSolved
};

@class Question;

@interface PROQuestion : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSString *extraInfo;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *isSolved;
@property (nonatomic, retain) NSNumber *isUnlocked;
@property (nonatomic, retain) NSSet<PROOption *> *options;

-(void) fillQuestionWithQuestion:(PROQuestion *)question;
+ (instancetype)questionWithDictionary:(NSDictionary*)dictionar;

- (NSString*) returnAnswer;
//TODO: (CS) Implement Question convetor
+ (instancetype)convertQuestionToPROQuestion:(Question *)question;

@end
