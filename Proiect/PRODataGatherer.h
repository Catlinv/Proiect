//
//  PRODataGatherer.h
//  Proiect
//
//  Created by webteam on 18/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRODataGathererInstance ([PRODataGatherer sharedInstance])

@class PROQuestion;

@interface PRODataGatherer : NSObject

@property (strong, nonatomic, readonly) NSArray <PROQuestion *> *questionsArray;

+ (PRODataGatherer *)sharedInstance;

- (void)fillCoreData;

@end
