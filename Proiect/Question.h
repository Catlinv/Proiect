//
//  Question.h
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Option,PROQuestion;

NS_ASSUME_NONNULL_BEGIN

@interface Question : NSManagedObject

- (void) fillQuestionWithQuestion:(Question *)question;
- (void) fillQuestionWithPROQuestion:(PROQuestion *)question;
- (NSString*) returnAnswer;

@end

NS_ASSUME_NONNULL_END

#import "Question+CoreDataProperties.h"
