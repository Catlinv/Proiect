//
//  PRODataGatherer.m
//  Proiect
//
//  Created by webteam on 18/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PRODataGatherer.h"
#import "PROQuestion.h"

#define kFileName @"QuestionDataSet.plist"

@implementation PRODataGatherer

+ (void)decideFillCOreData {
    //if(noCoreData)
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:kFileName];
    NSArray *value = [plistDict objectForKey:@"QuestionsArray"];
    for (NSDictionary *question in value)
    {
        PROQuestion *aux ;
        
    }
}

#pragma mark - For Later

@end
