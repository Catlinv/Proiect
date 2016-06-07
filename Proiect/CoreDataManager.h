//
//  CoreDataManager.h
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CoreDataManagerInstance ([CoreDataManager sharedInstance])

@protocol CoreDataManagerDelegate;

@class Question,PROQuestion;

@interface CoreDataManager : NSObject

@property (nonatomic, weak) id<CoreDataManagerDelegate> delegate;

+ (CoreDataManager *)sharedInstance;

- (void)requestQuestionsAsync;
- (void)addQuestions:(NSArray<PROQuestion *> *)questionsArray;
//- (void)deleteQuestions:(NSArray<Question *> *)questionsArray;
- (void)updateDatabaseState;

@end

@protocol CoreDataManagerDelegate <NSObject>

- (void)coreDataManagerDidRetreiveResults:(NSArray<Question *> *)resultsArray;

@optional
- (void)coreDataManagerDidFailDueToErrorCode:(NSError *)error;

@end
