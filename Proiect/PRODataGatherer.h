//
//  PRODataGatherer.h
//  Proiect
//
//  Created by webteam on 18/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PROQuestion;

@interface PRODataGatherer : NSObject

+ (void)fillCoreData;
+ (NSArray<PROQuestion *> *)getQuestionsArray;

@end
