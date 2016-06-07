//
//  PRODataGatherer.h
//  Proiect
//
//  Created by webteam on 18/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRODataGathererInstance ([PRODataGatherer sharedInstance])

@protocol PRODataGathererDelegate;

@class PROQuestion;

@interface PRODataGatherer : NSObject

@property (nonatomic, weak) id<PRODataGathererDelegate> delegate;

@property (strong, nonatomic, readonly) NSArray <PROQuestion *> *questionsArray;

+ (PRODataGatherer *)sharedInstance;

- (void)fillCoreData;
- (void)fillQuestions;

@end

@protocol PRODataGathererDelegate <NSObject>

-(void)dataGathererDidFinishFilling:(PRODataGatherer *)dataGatherer;


@end