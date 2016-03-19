//
//  PROQuestion.h
//  Proiect
//
//  Created by OctavF on 19/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PROOption.h"

@interface PROQuestion : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDecimalNumber *type;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSString *extraInfo;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *isSolved;
@property (nonatomic, retain) NSNumber *isUnlocked;
@property (nonatomic, retain) NSSet<PROOption *> *options;

-(void) fillQuestionWithQuestion:(PROQuestion *)question;

- (NSString*) returnAnswer;

@end
